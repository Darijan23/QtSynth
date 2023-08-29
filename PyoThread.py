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
    bpmChanged = Signal(float)
    bpm = Property(float, lambda self: self._bpm, bpmChanged)
    playbackFinished = Signal()

    def __init__(self):
        super().__init__()
        self.s = Server(duplex=0)
        self.s.setOutputDevice(pa_get_default_output())
        self.s.setMidiInputDevice(99)
        self.s.boot()
        self.s.amp = 1.

        self._bpm = 120.0

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

        self.oscMix = Mix(input=[self.osc1out, self.osc2out, self.osc3out], voices=2).out()

        self.distortion = Disto(input=self.oscMix, drive=0.).out()
        self.distOut = Selector(inputs=[self.oscMix, self.distortion], voice=0.).out()
        self.chorus = Chorus(input=self.distOut, depth=0, feedback=0, bal=0.).out()
        self.phaser = Phaser(input=self.chorus).out()
        self.phsrOut = Selector(inputs=[self.chorus, self.phaser], voice=0.).out()
        self.delay = Delay(input=self.phsrOut, maxdelay=10).out()
        self.dlyOut = Selector(inputs=[self.phsrOut, self.delay], voice=0.).out()
        self.reverb = Freeverb(input=self.dlyOut, bal=0.).out()

        self.midiFile = None
        self.playback_thread = PlaybackThread(self.s, self.midiFile)
        self.playback_thread.playback_finished.connect(self.end_playback)
        self.playback_thread.start()

        self.adsrs = [self.adsr1, self.adsr2, self.adsr3]
        self.oscillators = [self.osc1, self.osc2, self.osc3]
        self.octaves = [self.octave1, self.octave2]
        self.detunes = [self.detune1, self.detune2]
        self.pans = [self.pan1, self.pan2, self.pan3]
        self.lfos = [self.lfo1, self.lfo2, self.lfo3]
        self.filters = [self.filter1, self.filter2, self.filter3]

        self.s.start()

    @Slot(float)
    def set_bpm(self, value):
        self._bpm = value
        self.bpmChanged.emit(value)
        self.playback_thread.set_bpm(self.bpm)

    @Slot(int, str, float)
    def set_ADSR(self, ind, param, value):
        adsr = self.adsrs[ind]
        if param == "A":
            adsr.setAttack(value * 0.001)
        elif param == "D":
            adsr.setDecay(value * 0.001)
        elif param == "S":
            adsr.setSustain(value * 0.01)
        elif param == "R":
            adsr.setRelease(value * 0.001)

    @Slot(int, float)
    def set_octave(self, ind, value):
        octave = self.octaves[ind]
        octave.setTranspo(value * 12)

    @Slot(int, float)
    def set_detune(self, ind, value):
        detune = self.detunes[ind]
        detune.setTranspo(value * 0.02)

    @Slot(int, float)
    def set_pan(self, ind, value):
        pan = self.pans[ind]
        pan.setPan(0.5 + (value * 0.005))

    @Slot(int, float)
    def set_level(self, ind, value):
        adsr = self.adsrs[ind]
        adsr.setMul(value * 0.01 * 0.3)

    @Slot(int, int)
    def set_osc(self, ind, wave):
        if ind == 2:
            self.set_noise_osc(wave)
        else:
            osc = self.oscillators[ind]
            osc.setType(wave)

    @Slot(int)
    def toggle_osc(self, ind):
        osc = self.pans[ind]
        osc.setMul(1. - osc.mul)

    @Slot(int)
    def set_noise_osc(self, shape):
        if shape == 0:
            self.osc3 = Noise(mul=self.adsr3)
        elif shape == 1:
            self.osc3 = BrownNoise(mul=self.adsr3)
        elif shape == 2:
            self.osc3 = PinkNoise(mul=self.adsr3)
        self.osc3mix = self.osc3.mix(2)
        self.pan3.setInput(self.osc3mix)

    @Slot(int, float)
    def set_filter_freq(self, ind, freq):
        filter = self.lfos[ind]
        filter.setAdd(freq)

    @Slot(int, float)
    def set_filter_width(self, ind, width):
        filter = self.lfos[ind]
        filter.setMul(width)

    @Slot(int, float)
    def set_filter_rate(self, ind, rate):
        filter = self.lfos[ind]
        filter.setFreq(rate)

    @Slot(int, float)
    def set_filter_Q(self, ind, q):
        filter = self.filters[ind]
        filter.setQ(q)

    @Slot(int, int)
    def set_filter_shape(self, ind, shape):
        filter = self.filters[ind]
        filter.setType(shape)

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
    def set_filter_mix(self, ind, mix):
        mix_functions = [self.filter1_mix, self.filter2_mix, self.filter3_mix]
        mix_functions[ind](mix)

    @Slot(float)
    def set_drive(self, drive):
        self.distortion.setDrive(drive * 0.01)

    @Slot(float)
    def set_slope(self, slope):
        self.distortion.setSlope(slope * 0.01)

    @Slot(float)
    def set_distortion_mix(self, mix):
        self.distOut.setVoice(mix * 0.01)

    @Slot(float)
    def set_chorus_depth(self, depth):
        self.chorus.setDepth(depth * 0.01)

    @Slot(float)
    def set_chorus_feedback(self, feedback):
        self.chorus.setFeedback(feedback * 0.01)

    @Slot(float)
    def set_chorus_mix(self, mix):
        self.chorus.setBal(mix * 0.01)

    @Slot(float)
    def set_phaser_freq(self, freq):
        self.phaser.setFreq(freq)

    @Slot(float)
    def set_phaser_spread(self, spread):
        self.phaser.setSpread(spread)

    @Slot(float)
    def set_phaser_Q(self, q):
        self.phaser.setQ(q)

    @Slot(float)
    def set_phaser_feedback(self, feedback):
        self.phaser.setFeedback(feedback * 0.01)

    @Slot(float)
    def set_phaser_mix(self, mix):
        self.phsrOut.setVoice(mix * 0.01)

    @Slot(float)
    def set_delay_time(self, delay):
        self.delay.setDelay(delay * 0.001)

    @Slot(float)
    def set_delay_feedback(self, feedback):
        self.delay.setFeedback(feedback * 0.01)

    @Slot(float)
    def set_delay_mix(self, mix):
        self.dlyOut.setVoice(mix * 0.01)

    @Slot(float)
    def set_reverb_size(self, size):
        self.reverb.setSize(size * 0.01)

    @Slot(float)
    def set_reverb_damp(self, damp):
        self.reverb.setDamp(damp * 0.01)

    @Slot(float)
    def set_reverb_mix(self, mix):
        self.reverb.setBal(mix * 0.01)

    @Slot(QUrl)
    def set_midi_file(self, url):
        self.midiFile = MidiFile(url.path())
        self.playback_thread.file = self.midiFile
        self.playback_thread.init_file()
        if not self.playback_thread.isRunning():
            self.playback_thread.start()
        self.set_bpm(self.playback_thread.bpm)

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

    @Slot()
    def end_playback(self):
        self.stop_playback()
        self.playbackFinished.emit()
