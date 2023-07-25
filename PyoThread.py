from PySide6.QtCore import Slot, QObject
from PySide6.QtQml import QmlElement

from pyo import *
QML_IMPORT_NAME = "qtsynth.pyo"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class PyoThread(QObject):
    def __init__(self):
        super().__init__()
        self.s = Server(duplex=0)
        self.s.setOutputDevice(pa_get_default_output())
        self.s.boot()
        self.s.start()
        self.s.amp = 1.

        midi_devices = pm_get_input_devices()

        # Sets fundamental frequency.
        self.freq = 440.0

        self.adsr1 = Adsr()
        self.osc1 = Sine(freq=self.freq, mul=self.adsr1).mix(2)
        self.octave1 = Harmonizer(self.osc1, transpo=0)
        self.detune1 = Harmonizer(self.octave1, transpo=0)
        self.pan = SPan(self.detune1, mul=1.).out()

    @Slot()
    def play_note(self):
        self.adsr1.play()

    @Slot()
    def stop_note(self):
        self.adsr1.stop()

    @Slot(str, int)
    def set_ADSR(self, param, value):
        if param == "A":
            self.adsr1.setAttack(value * 0.001)
        elif param == "D":
            self.adsr1.setDecay(value * 0.001)
        elif param == "S":
            self.adsr1.setSustain(value * 0.01)
        elif param == "R":
            self.adsr1.setRelease(value * 0.001)

    @Slot(int)
    def set_A(self, value):
        self.set_ADSR("A", value)

    @Slot(int)
    def set_D(self, value):
        self.set_ADSR("D", value)

    @Slot(int)
    def set_S(self, value):
        self.set_ADSR("S", value)

    @Slot(int)
    def set_R(self, value):
        self.set_ADSR("R", value)

    @Slot(int)
    def set_octave(self, value):
        self.octave1.setTranspo(value * 12)

    @Slot(int)
    def set_detune(self, value):
        self.detune1.setTranspo(value * 0.02)

    @Slot(int)
    def set_pan(self, value):
        self.pan.setPan(0.5 + (value * 0.005))

    @Slot(int)
    def set_level(self, value):
        self.adsr1.setMul(value * 0.01)

    @Slot(int)
    def set_osc(self, wave):
        if wave == 0:
            self.osc1 = Sine(freq=self.freq, mul=self.adsr1)
        elif wave == 1:
            self.osc1 = LFO(freq=self.freq, mul=self.adsr1, type=2)
        elif wave == 2:
            self.osc1 = LFO(freq=self.freq, mul=self.adsr1, type=3)
        elif wave == 3:
            self.osc1 = LFO(freq=self.freq, mul=self.adsr1, type=0)
        elif wave == 4:
            self.osc1 = Noise(mul=self.adsr1)

        self.octave1.setInput(self.osc1)

    @Slot()
    def toggle_osc(self):
        self.pan.setMul(1. - self.pan.mul)
