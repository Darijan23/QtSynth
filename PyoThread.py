import sys
import json

from PySide6.QtCore import Slot, QObject, QUrl, Property, Signal
from PySide6.QtQml import QmlElement
from mido import MidiFile
from pyo import *

from PlaybackThread import PlaybackThread

QML_IMPORT_NAME = "qtsynth.pyo"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class PyoThread(QObject):
    counter_changed = Signal(int)

    def __init__(self):
        super().__init__()
        self.s = Server(duplex=0)
        self.s.setOutputDevice(pa_get_default_output())
        self.s.setMidiInputDevice(99)
        self.s.boot()
        self.s.amp = 1.

        self.bpm = 120

        self.notes = Notein(scale=1)
        self.noise_notes = Notein(scale=1, poly=10)

        self.adsr1 = MidiAdsr(self.notes["velocity"])
        self.osc1 = LFO(freq=self.notes["pitch"], sharp=0, mul=self.adsr1)
        self.osc1mix = self.osc1.mix(2)
        self.octave1 = Harmonizer(self.osc1mix, transpo=0)
        self.detune1 = Harmonizer(self.octave1, transpo=0)
        self.pan1 = SPan(self.detune1, mul=1.)

        self.adsr2 = MidiAdsr(self.notes["velocity"])
        self.osc2 = LFO(freq=self.notes["pitch"], sharp=0, mul=self.adsr2)
        self.osc2mix = self.osc2.mix(2)
        self.octave2 = Harmonizer(self.osc2mix, transpo=0)
        self.detune2 = Harmonizer(self.octave2, transpo=0)
        self.pan2 = SPan(self.detune2, mul=1.)

        self.adsr3 = MidiAdsr(self.noise_notes["velocity"])
        self.osc3 = Noise(mul=self.adsr3)
        self.osc3mix = self.osc3.mix(2)
        self.pan3 = SPan(self.osc3mix, mul=1.)

        self.lfo1 = Sine(freq=.1, mul=500, add=1000)
        self.filter1 = Biquad(self.pan1, freq=self.lfo1)
        self.osc1out = Selector(inputs=[self.pan1, self.filter1], voice=1.).out()

        self.lfo2 = Sine(freq=.1, mul=500, add=1000)
        self.filter2 = Biquad(self.pan2, freq=self.lfo2)
        self.osc2out = Selector(inputs=[self.pan2, self.filter2], voice=1.).out()

        self.lfo3 = Sine(freq=.1, mul=500, add=1000)
        self.filter3 = Biquad(self.pan3, freq=self.lfo3)
        self.osc3out = Selector(inputs=[self.pan3, self.filter3], voice=1.).out()

        self.midiFile = None
        self.playback_thread = PlaybackThread(self.s, self.midiFile)
        self.playback_thread.start()

        self.f1_toggle = True
        self.f2_toggle = True
        self.f3_toggle = True

        self._test_counter = 0

        self.s.start()

    @Property(int, notify=counter_changed)
    def test_counter(self):
        return self._test_counter

    @test_counter.setter
    def test_counter(self, value):
        if value != self._test_counter:
            self._test_counter = value

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
        self.osc1.setType(wave)

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
        self.osc2.setType(wave)

    @Slot()
    def toggle_osc2(self):
        self.pan2.setMul(1. - self.pan2.mul)

    @Slot(str, int)
    def set_ADSR3(self, param, value):
        if param == "A":
            self.adsr3.setAttack(value * 0.001)
        elif param == "D":
            self.adsr3.setDecay(value * 0.001)
        elif param == "S":
            self.adsr3.setSustain(value * 0.01)
        elif param == "R":
            self.adsr3.setRelease(value * 0.001)

    @Slot(int)
    def set_A3(self, value):
        self.set_ADSR3("A", value)

    @Slot(int)
    def set_D3(self, value):
        self.set_ADSR3("D", value)

    @Slot(int)
    def set_S3(self, value):
        self.set_ADSR3("S", value)

    @Slot(int)
    def set_R3(self, value):
        self.set_ADSR3("R", value)

    @Slot(int)
    def set_pan3(self, value):
        self.pan3.setPan(0.5 + (value * 0.005))

    @Slot(int)
    def set_level3(self, value):
        self.adsr3.setMul(value * 0.01)

    @Slot(int)
    def set_osc3(self, shape):
        if shape == 0:
            self.osc3 = Noise(mul=self.adsr3)
        elif shape == 1:
            self.osc3 = BrownNoise(mul=self.adsr3)
        elif shape == 2:
            self.osc3 = PinkNoise(mul=self.adsr3)
        self.osc3mix = self.osc3

    @Slot()
    def toggle_osc3(self):
        self.pan3.setMul(1. - self.pan3.mul)

    @Slot(int)
    def set_freq1(self, freq):
        self.lfo1.setAdd(freq)

    @Slot(int)
    def set_filter_width1(self, width):
        self.lfo1.setMul(width)

    @Slot(float)
    def set_filter_rate1(self, rate):
        self.lfo1.setFreq(rate)

    @Slot(int)
    def set_Q1(self, q):
        self.filter1.setQ(q)

    @Slot(float)
    def set_resonance1(self, res):
        self.filter1.setRes(res)

    @Slot(int)
    def set_filter1(self, filter_type):
        self.filter1.setType(filter_type)

    @Slot()
    def toggle_filter1(self):
        if self.f1_toggle:
            del self.osc1out
            self.osc1out = self.pan1.out()
        else:
            del self.osc1out
            self.osc1out = self.filter1.out()
        self.f1_toggle = not self.f1_toggle

    @Slot(int)
    def set_freq2(self, freq):
        self.lfo2.setAdd(freq)

    @Slot(int)
    def set_filter_width2(self, width):
        self.lfo2.setMul(width)

    @Slot(float)
    def set_filter_rate2(self, rate):
        self.lfo2.setFreq(rate)

    @Slot(int)
    def set_Q2(self, q):
        self.filter2.setQ(q)

    @Slot(float)
    def set_resonance2(self, res):
        self.filter2.setRes(res)

    @Slot(int)
    def set_filter2(self, filter_type):
        self.filter2.setType(filter_type)

    @Slot()
    def toggle_filter2(self):
        if self.f2_toggle:
            del self.osc2out
            self.osc2out = self.pan2.out()
        else:
            del self.osc2out
            self.osc2out = self.filter2.out()
        self.f2_toggle = not self.f2_toggle

    @Slot(int)
    def set_freq3(self, freq):
        self.lfo3.setAdd(freq)

    @Slot(int)
    def set_filter_width3(self, width):
        self.lfo3.setMul(width)

    @Slot(float)
    def set_filter_rate3(self, rate):
        self.lfo3.setFreq(rate)

    @Slot(int)
    def set_Q3(self, q):
        self.filter3.setQ(q)

    @Slot(float)
    def set_resonance3(self, res):
        self.filter3.setRes(res)

    @Slot(int)
    def set_filter3(self, filter_type):
        self.filter3.setType(filter_type)

    @Slot()
    def toggle_filter3(self):
        if self.f3_toggle:
            # self.filter3.stop()
            self.osc3out = self.pan3.out()
        else:
            # self.osc3out.stop()
            self.osc3out = self.filter3.out()
        self.f3_toggle = not self.f3_toggle

    @Slot(float)
    def filter1_mix(self, mix):
        self.osc1out.setVoice(mix * .01)

    @Slot(float)
    def filter2_mix(self, mix):
        self.osc2out.setVoice(mix * .01)

    @Slot(float)
    def filter3_mix(self, mix):
        self.osc3out.setVoice(mix * .01)

    @Slot(int, float)
    def filter_mix(self, ind, mix):
        mix_functions = [self.filter1_mix, self.filter2_mix, self.filter3_mix]
        mix_functions[ind](mix)

    @Slot(int)
    def toggle_oscillator(self, ind):
        toggle_functions = [self.toggle_osc1, self.toggle_osc2, self.toggle_osc3]
        toggle_functions[ind]()

    @Slot(int, int)
    def set_oscillator(self, ind, wave):
        set_functions = [self.set_osc1, self.set_osc2, self.set_osc3]
        set_functions[ind](wave)

    @Slot(int)
    def toggle_filter(self, ind):
        toggle_functions = [self.toggle_filter1, self.toggle_filter2, self.toggle_filter3]
        toggle_functions[ind]()

    @Slot(int, int)
    def set_filter(self, ind, shape):
        set_functions = [self.set_filter1, self.set_filter2, self.set_filter3]
        set_functions[ind](shape)

    @Slot(QUrl)
    def set_midi_file(self, url):
        self.midiFile = MidiFile(url.path())
        self.playback_thread.file = self.midiFile
        self.playback_thread.init_file()
        if not self.playback_thread.isRunning():
            self.playback_thread.start()

    @Slot(str, QUrl)
    def save_preset(self, preset, url):
        with open(url.path(), "w+") as file:
            file.write(preset)
            file.close()

    @Slot()
    def toggle_playback(self):
        if self.playback_thread.play:
            self.playback_thread.pause()
        else:
            self.playback_thread.start_playback()

    @Slot()
    def stop_playback(self):
        self.playback_thread.stop_playback()
