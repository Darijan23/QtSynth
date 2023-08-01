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
        self.s.setMidiInputDevice(99)
        self.s.boot()
        self.s.amp = 1.

        # self.midi_names, self.midi_devices = pm_get_input_devices()
        # print(self.midi_names, self.midi_devices)

        self.bpm = 120

        self.notes = Notein(scale=1)
        self.notes.keyboard()

        self.adsr1 = MidiAdsr(self.notes["velocity"])
        self.osc1 = Sine(freq=self.notes["pitch"], mul=self.adsr1).mix(2)
        self.octave1 = Harmonizer(self.osc1, transpo=0)
        self.detune1 = Harmonizer(self.octave1, transpo=0)
        self.pan1 = SPan(self.detune1, mul=1.)

        self.adsr2 = MidiAdsr(self.notes["velocity"])
        self.osc2 = Sine(freq=self.notes["pitch"], mul=self.adsr2).mix(2)
        self.octave2 = Harmonizer(self.osc2, transpo=0)
        self.detune2 = Harmonizer(self.octave2, transpo=0)
        self.pan2 = SPan(self.detune2, mul=1.).out()

        # Creates an LFO oscillating +/- 500 around 1000 (filter's frequency)
        self.lfo1 = Sine(freq=.1, mul=500, add=1000)
        # Creates a dynamic bandpass filter applied to the noise source
        self.filter1 = MoogLP(self.pan1, freq=self.lfo1).out()

        self.s.start()

    @Slot(int)
    def set_bpm(self, bpm):
        self.bpm = bpm

    @Slot()
    def play_note(self):
        self.adsr1.play()
        self.adsr2.play()

    @Slot()
    def stop_note(self):
        self.adsr1.stop()
        self.adsr2.stop()

    @Slot(str, int)
    def set_ADSR1(self, param, value):
        if param == "A":
            self.adsr1.setAttack(value * 0.001)
        elif param == "D":
            self.adsr1.setDecay(value * 0.001)
        elif param == "S":
            self.adsr1.setSustain(value * 0.01)
        elif param == "R":
            self.adsr1.setRelease(value * 0.001)

    @Slot(int)
    def set_A1(self, value):
        self.set_ADSR1("A", value)

    @Slot(int)
    def set_D1(self, value):
        self.set_ADSR1("D", value)

    @Slot(int)
    def set_S1(self, value):
        self.set_ADSR1("S", value)

    @Slot(int)
    def set_R1(self, value):
        self.set_ADSR1("R", value)

    @Slot(int)
    def set_octave1(self, value):
        self.octave1.setTranspo(value * 12)

    @Slot(int)
    def set_detune1(self, value):
        self.detune1.setTranspo(value * 0.02)

    @Slot(int)
    def set_pan1(self, value):
        self.pan1.setPan(0.5 + (value * 0.005))

    @Slot(int)
    def set_level1(self, value):
        self.adsr1.setMul(value * 0.01)

    @Slot(int)
    def set_osc1(self, wave):
        if wave == 0:
            self.osc1 = Sine(freq=self.notes["pitch"], mul=self.adsr1).mix(2)
        elif wave == 1:
            self.osc1 = LFO(freq=self.notes["pitch"], mul=self.adsr1, type=2).mix(2)
        elif wave == 2:
            self.osc1 = LFO(freq=self.notes["pitch"], mul=self.adsr1, type=3).mix(2)
        elif wave == 3:
            self.osc1 = LFO(freq=self.notes["pitch"], mul=self.adsr1, type=0).mix(2)
        elif wave == 4:
            self.osc1 = Noise(mul=self.adsr1).mix(2)

        self.octave1.setInput(self.osc1)

    @Slot()
    def toggle_osc1(self):
        self.pan1.setMul(1. - self.pan1.mul)

    @Slot(str, int)
    def set_ADSR2(self, param, value):
        if param == "A":
            self.adsr2.setAttack(value * 0.001)
        elif param == "D":
            self.adsr2.setDecay(value * 0.001)
        elif param == "S":
            self.adsr2.setSustain(value * 0.01)
        elif param == "R":
            self.adsr2.setRelease(value * 0.001)

    @Slot(int)
    def set_A2(self, value):
        self.set_ADSR2("A", value)

    @Slot(int)
    def set_D2(self, value):
        self.set_ADSR2("D", value)

    @Slot(int)
    def set_S2(self, value):
        self.set_ADSR2("S", value)

    @Slot(int)
    def set_R2(self, value):
        self.set_ADSR2("R", value)

    @Slot(int)
    def set_octave2(self, value):
        self.octave2.setTranspo(value * 12)

    @Slot(int)
    def set_detune2(self, value):
        self.detune2.setTranspo(value * 0.02)

    @Slot(int)
    def set_pan2(self, value):
        self.pan2.setPan(0.5 + (value * 0.005))

    @Slot(int)
    def set_level2(self, value):
        self.adsr2.setMul(value * 0.01)

    @Slot(int)
    def set_osc2(self, wave):
        if wave == 0:
            self.osc2 = Sine(freq=self.notes["pitch"], mul=self.adsr2).mix(2)
        elif wave == 1:
            self.osc2 = LFO(freq=self.notes["pitch"], mul=self.adsr2, type=2).mix(2)
        elif wave == 2:
            self.osc2 = LFO(freq=self.notes["pitch"], mul=self.adsr2, type=3).mix(2)
        elif wave == 3:
            self.osc2 = LFO(freq=self.notes["pitch"], mul=self.adsr2, type=0).mix(2)
        elif wave == 4:
            self.osc2 = Noise(mul=self.adsr2).mix(2)

        self.octave2.setInput(self.osc2)

    @Slot()
    def toggle_osc2(self):
        self.pan2.setMul(1. - self.pan2.mul)

    @Slot(int)
    def set_freq1(self, freq):
        self.lfo1.setAdd(freq)

    @Slot(int)
    def set_filter_width1(self, width):
        self.lfo1.setMul(width)

    @Slot(int)
    def set_Q1(self, q):
        self.filter1.setQ(q)

    @Slot(float)
    def set_resonance1(self, res):
        self.filter1.setRes(res)
