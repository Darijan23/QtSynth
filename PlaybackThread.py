from PySide6.QtCore import Slot, QObject, QUrl, QThread, Signal
from PySide6.QtQml import QmlElement
from mido import MidiFile

from pyo import *


class PlaybackThread(QThread):
    def __init__(self, server, file):
        super().__init__()
        self.s = server
        self.file = file
        self.play = False
        self.pos = 0
        self.playback_finished = Signal()

    def run(self):
        if self.file:
            messages = list(self.file.play())
            while self.pos < len(messages):
                if self.play:
                    print("A")
                    self.s.addMidiEvent(*messages[self.pos].bytes())
                    self.pos += 1
            self.playback_finished.emit()

    def start_playback(self):
        self.play = True

    def pause(self):
        self.play = False

    def stop_playback(self):
        self.pause()
        self.pos = 0
