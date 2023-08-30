from datetime import datetime, timedelta

from PySide6.QtCore import Slot, QObject, QUrl, QThread, Signal
from PySide6.QtQml import QmlElement
from mido import MidiFile, Message, MetaMessage, tempo2bpm, bpm2tempo

from pyo import *


class CustomClock:
    def __init__(self):
        self.resume_time = datetime.fromtimestamp(0)
        self.pause_time = datetime.fromtimestamp(0)
        self.start_time = datetime.fromtimestamp(0)
        self.time_diff = 0
        self.playing = False

    def start(self):
        self.resume_time = datetime.now()
        self.pause_time = datetime.now()
        self.start_time = datetime.now()
        self.time_diff = 0
        self.playing = True

    def pause(self):
        self.pause_time = datetime.now()
        self.playing = False

    def resume(self):
        self.resume_time = datetime.now()
        self.time_diff += (self.resume_time - self.pause_time).total_seconds()
        self.playing = True

    def get_time(self):
        if self.playing:
            return (datetime.now() - self.start_time - timedelta(seconds=self.time_diff)).total_seconds()
        else:
            return 0


class PlaybackThread(QThread):
    playback_finished = Signal()

    def __init__(self, server, file: MidiFile):
        super().__init__()
        self.s = server
        self.file = file
        self.play = False
        self.reset = True
        self.playback_in_progress = False
        self.bpm = 120

        self.messages = None
        self.clock = CustomClock()

    def init_file(self):
        self.clock.__init__()
        self.messages = self.file.play(now=self.clock.get_time)
        self.set_bpm(tempo2bpm(self.file.ticks_per_beat))

    def set_bpm(self, bpm):
        self.bpm = round(bpm)
        tempo = bpm2tempo(self.bpm)
        bpm_message = MetaMessage("set_tempo", tempo=tempo)
        # self.s.addMidiEvent(*bpm_message.bytes())    # Ne radi

    def run(self):
        while not self.file:
            self.sleep(1)
        while True:
            if not self.playback_in_progress:
                self.playback()

    def playback(self):
        self.playback_in_progress = True
        while self.reset:
            self.msleep(500)
        for message in self.messages:
            if self.reset:
                return
            while not self.play:
                self.msleep(500)
            self.s.addMidiEvent(*message.bytes())
        self.finish_playback()

    def start_playback(self):
        if self.reset:
            self.play = True
            self.reset = False
            self.clock.start()
            self.messages = self.file.play(now=self.clock.get_time)
        else:
            self.resume_playback()

    def resume_playback(self):
        self.play = True
        self.reset = False
        self.clock.resume()

    def pause(self):
        self.play = False
        self.clock.pause()
        for n in range(128):
            stop_msg = Message('note_off', note=n)
            self.s.addMidiEvent(*stop_msg.bytes())

    def stop_playback(self):
        self.pause()
        self.messages = None
        self.reset = True
        self.playback_in_progress = False

    def finish_playback(self):
        self.stop_playback()
        self.playback_finished.emit()
