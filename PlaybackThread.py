import time

from PySide6.QtCore import Slot, QObject, QUrl, QThread, Signal
from PySide6.QtQml import QmlElement
from mido import MidiFile, Message

from pyo import *


class PlaybackThread(QThread):
    def __init__(self, server, file: MidiFile):
        super().__init__()
        self.s = server
        self.file = file
        self.play = False
        self.reset = True
        self.playback_finished = Signal()
        self.playback_stopped = Signal()

        self.messages = None
        self.current_message_index = 0
        self.current_time = 0.0  # Current time position in MIDI file

        self.metro = Metro(1000)  # Metronome to synchronize MIDI messages

    def init_file(self):
        self.messages = self.file.play()

    def run(self):
        while not self.file:
            self.sleep(2)
        self.playback()

    def playback(self):
        messages = self.file.play()
        for message in self.messages:
            # if self.reset:
            #     return
            print(message)
            while not self.play:
                self.msleep(500)
            self.s.addMidiEvent(*message.bytes())
        self.stop_playback()

    def start_playback(self):
        self.play = True
        self.reset = False

    def pause(self):
        self.play = False

    def stop_playback(self):
        self.pause()
        self.reset = True
