import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import qtsynth.pyo 1
import "Components"

ApplicationWindow {
    width: 1400
    height: 960
    visible: true
    title: qsTr("QtSynth")

    property int dialInputMode: Dial.Vertical

    property list<string> noiseWaveforms: ["White noise", "Pink noise", "Brown noise"]

    property list<ObjectModel> oscillatorModels: [
        ObjectModel {
            id: oscillatorModel1

            KnobGroup { id: octave1; type: "Octave"; min: -2; max: 2; defaultValue: 0; ind: 0; mod: pyo.set_octave(ind, parseFloat(textValue)) }
            KnobGroup { id: level1; type: "Level"; min: 0; max: 100; defaultValue: 100; ind: 0; mod: pyo.set_level(ind, parseFloat(textValue)) }
            KnobGroup { id: detune1; type: "Detune"; min: -50; max: 50; defaultValue: 0; ind: 0; mod: pyo.set_detune(ind, parseFloat(textValue)) }
            KnobGroup { id: pan1; type: "Pan"; min: -100; max: 100; defaultValue: 0; ind: 0; mod: pyo.set_pan(ind, parseFloat(textValue)) }
            KnobGroup { id: attack1; type: "Attack"; min: 0; max: 1000; defaultValue: 10; ind: 0; mod: pyo.set_ADSR(ind, "A", parseFloat(textValue)) }
            KnobGroup { id: decay; type: "Decay"; min: 0; max: 1000; defaultValue: 50; ind: 0; mod: pyo.set_ADSR(ind, "D", parseFloat(textValue)) }
            KnobGroup { id: sustain1; type: "Sustain"; min: 0; max: 100; defaultValue: 50; ind: 0; mod: pyo.set_ADSR(ind, "S", parseFloat(textValue)) }
            KnobGroup { id: release1; type: "Release"; min: 0; max: 5000; defaultValue: 100; ind: 0; mod: pyo.set_ADSR(ind, "R", parseFloat(textValue)) }
        },

        ObjectModel {
            id: oscillatorModel2

            KnobGroup { id: octave2; type: "Octave"; min: -2; max: 2; defaultValue: 0; ind: 1; mod: pyo.set_octave(ind, parseFloat(textValue)) }
            KnobGroup { id: level2; type: "Level"; min: 0; max: 100; defaultValue: 100; ind: 1;  mod: pyo.set_level(ind, parseFloat(textValue)) }
            KnobGroup { id: detune2; type: "Detune"; min: -50; max: 50; defaultValue: 0; ind: 1;  mod: pyo.set_detune(ind, parseFloat(textValue)) }
            KnobGroup { id: pan2; type: "Pan"; min: -100; max: 100; defaultValue: 0; ind: 1;  mod: pyo.set_pan(ind, parseFloat(textValue)) }
            KnobGroup { id: attack2; type: "Attack"; min: 0; max: 1000; defaultValue: 10; ind: 1;  mod: pyo.set_ADSR(ind, "A", parseFloat(textValue)) }
            KnobGroup { id: decay2; type: "Decay"; min: 0; max: 1000; defaultValue: 50; ind: 1;  mod: pyo.set_ADSR(ind, "D", parseFloat(textValue)) }
            KnobGroup { id: sustain2; type: "Sustain"; min: 0; max: 100; defaultValue: 50; ind: 1;  mod: pyo.set_ADSR(ind, "S", parseFloat(textValue)) }
            KnobGroup { id: release2; type: "Release"; min: 0; max: 5000; defaultValue: 100; ind: 1;  mod: pyo.set_ADSR(ind, "R", parseFloat(textValue)) }
        },

        ObjectModel {
            id: oscillatorModel3

            KnobGroup { id: attack3; type: "Attack"; min: 0; max: 1000; defaultValue: 10; ind: 2; mod: pyo.set_ADSR(ind, "A", parseFloat(textValue)) }
            KnobGroup { id: decay3; type: "Decay"; min: 0; max: 1000; defaultValue: 50; ind: 2; mod: pyo.set_ADSR(ind, "D", parseFloat(textValue)) }
            KnobGroup { id: sustain3; type: "Sustain"; min: 0; max: 100; defaultValue: 50; ind: 2; mod: pyo.set_ADSR(ind, "S", parseFloat(textValue)) }
            KnobGroup { id: release3; type: "Release"; min: 0; max: 5000; defaultValue: 100; ind: 2; mod: pyo.set_ADSR(ind, "R", parseFloat(textValue)) }
            KnobGroup { id: level3; type: "Level"; min: 0; max: 100; defaultValue: 100; ind: 2; mod: pyo.set_level(ind, parseFloat(textValue)) }
            KnobGroup { id: pan3; type: "Pan"; min: -100; max: 100; defaultValue: 0; ind: 2; mod: pyo.set_pan(ind, parseFloat(textValue)) }
        }
    ]

    property list<ObjectModel> filterModels: [
        ObjectModel {
            id: filterModel1

            KnobGroup { id: rate1; type: "Rate"; min: 0; max: 20; defaultValue: 1; ind: 0; mod: pyo.set_filter_rate(ind, parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq1; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; ind: 0; mod: pyo.set_filter_freq(ind, parseFloat(textValue)) }
            KnobGroup { id: width1; type: "Width"; min: 0; max: 10000; defaultValue: 100; ind: 0; mod: pyo.set_filter_width(ind, parseFloat(textValue)) }
            KnobGroup { id: q1; type: "Q"; min: 1; max: 10; defaultValue: 1; ind: 0; mod: pyo.set_filter_Q(ind, parseFloat(textValue)) }
        },

        ObjectModel {
            id: filterModel2

            KnobGroup { id: rate2; type: "Rate"; min: 0; max: 20; defaultValue: 1; ind: 1; mod: pyo.set_filter_rate(ind, parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq2; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; ind: 1; mod: pyo.set_filter_freq(ind, parseFloat(textValue)) }
            KnobGroup { id: width2; type: "Width"; min: 0; max: 10000; defaultValue: 100; ind: 1; mod: pyo.set_filter_width(ind, parseFloat(textValue)) }
            KnobGroup { id: q2; type: "Q"; min: 1; max: 10; defaultValue: 1; ind: 1; mod: pyo.set_filter_Q(ind, parseFloat(textValue)) }
        },

        ObjectModel {
            id: filterModel3

            KnobGroup { id: rate3; type: "Rate"; min: 0; max: 20; defaultValue: 1; ind: 2; mod: pyo.set_filter_rate(ind, parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq3; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; ind: 2; mod: pyo.set_filter_freq(ind, parseFloat(textValue)) }
            KnobGroup { id: width3; type: "Width"; min: 0; max: 10000; defaultValue: 100; ind: 2; mod: pyo.set_filter_width(ind, parseFloat(textValue)) }
            KnobGroup { id: q3; type: "Q"; min: 1; max: 10; defaultValue: 1; ind: 2; mod: pyo.set_filter_Q(ind, parseFloat(textValue)) }
        }
    ]

    ObjectModel {
        id: groupModel

        OscillatorFilterGroup { id: group1; groupIndex: 0; pyoVar: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex] }
        OscillatorFilterGroup { id: group2; groupIndex: 1; pyoVar: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex] }
        OscillatorFilterGroup { id: group3; groupIndex: 2; pyoVar: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex];
                                oscillatorType: "Noise oscillator"; oscillatorWaveforms: noiseWaveforms; oscillatorWaveIndex: 0 }
    }

    property list<ObjectModel> fxModels: [
        ObjectModel {
            id: distortionModel

            KnobGroup { id: distoDrive; type: "Drive"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_drive(parseFloat(textValue)) }
            KnobGroup { id: distoSlope; type: "Slope"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_slope(parseFloat(textValue)) }
            KnobGroup { id: distoMix; type: "Mix"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_distortion_mix(parseFloat(textValue)) }
        },

        ObjectModel {
            id: chorusModel

            KnobGroup { id: chorusDepth; type: "Depth"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_chorus_depth(parseFloat(textValue)) }
            KnobGroup { id: chorusFeedback; type: "Feedback"; min: 0; max: 100; defaultValue: 25; mod: pyo.set_chorus_feedback(parseFloat(textValue)) }
            KnobGroup { id: chorusMix; type: "Mix"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_chorus_mix(parseFloat(textValue)) }
        },

        ObjectModel {
            id: phaserModel

            KnobGroup { id: phaserFreq; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; mod: pyo.set_phaser_freq(parseFloat(textValue)) }
            KnobGroup { id: phaserSpread; type: "Spread"; min: 0; max: 10; defaultValue: 1.1; step: 0.1; mod: pyo.set_phaser_spread(parseFloat(textValue)) }
            KnobGroup { id: phaserQ; type: "Q"; min: 1; max: 100; defaultValue: 10; mod: pyo.set_phaser_Q(parseFloat(textValue)) }
            KnobGroup { id: phaserFeedback; type: "Feedback"; min: 0; max: 100; defaultValue: 25; mod: pyo.set_phaser_feedback(parseFloat(textValue)) }
            KnobGroup { id: phaserMix; type: "Mix"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_phaser_mix(parseFloat(textValue)) }
        },

        ObjectModel {
            id: delayModel

            KnobGroup { id: delayTime; type: "Delay"; min: 50; max: 5000; defaultValue: 0; mod: pyo.set_delay_time(parseFloat(textValue)) }
            KnobGroup { id: delayFeedback; type: "Feedback"; min: 0; max: 100; defaultValue: 25; mod: pyo.set_delay_feedback(parseFloat(textValue)) }
            KnobGroup { id: delayMix; type: "Mix"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_delay_mix(parseFloat(textValue)) }
        },

        ObjectModel {
            id: reverbModel

            KnobGroup { id: reverbSize; type: "Size"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_reverb_size(parseFloat(textValue)) }
            KnobGroup { id: reverbDamp; type: "Damping"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_reverb_damp(parseFloat(textValue)) }
            KnobGroup { id: reverbMix; type: "Mix"; min: 0; max: 100; defaultValue: 0; mod: pyo.set_reverb_mix(parseFloat(textValue)) }
        }
    ]

    ObjectModel {
        id: fxModel

        Effect { id: distortion; type: "Distortion"; pyoVar: pyo; knobModel: distortionModel }
        Effect { id: chorus; type: "Chorus"; pyoVar: pyo; knobModel: chorusModel }
        Effect { id: phaser; type: "Phaser"; pyoVar: pyo; knobModel: phaserModel }
        Effect { id: delay; type: "Delay"; pyoVar: pyo; knobModel: delayModel }
        Effect { id: reverb; type: "Reverb"; pyoVar: pyo; knobModel: reverbModel }
    }


    MessageDialog {
        id: errorMessageDialog
        title: "Error"
        text: "Invalid preset file"
        visible: false
        onAccepted: {
            errorMessageDialog.visible = false
        }
    }

    function serialize(groups, effects) {
        var serializedOscillators = [];
        var serializedFilters = [];
        var serializedEffects = []

        for (let i = 0; i < groups.children.length; i++) {
            var group = groups.children[i];
            var oscillator = group.osc;
            var filter = group.fltr;

            var serializedOscillator = {};
            var oscillatorKnobs = [];
            var oscillatorModel = oscillator.knobModel

            for (let j = 0; j < oscillatorModel.children.length; j++) {
                var knobGroup = oscillatorModel.children[j];

                if (knobGroup.type) {
                    oscillatorKnobs.push(parseFloat(knobGroup.textValue));
                }
            }

            serializedOscillator["KnobValues"] = oscillatorKnobs;
            serializedOscillator["Toggled"] = oscillator.toggleOsc;
            serializedOscillator["Waveform"] = oscillator.waveIndex;

            serializedOscillators.push(serializedOscillator);

            var serializedFilter = {};
            var filterKnobs = [];
            var filterModel = filter.knobModel;

            for (let j = 0; j < filterModel.children.length; j++) {
                var knobGroup = filterModel.children[j];

                if (knobGroup.type) {
                    filterKnobs.push(parseFloat(knobGroup.textValue));
                }
            }

            serializedFilter["KnobValues"] = filterKnobs;
            serializedFilter["Mix"] = filter.mixValue;
            serializedFilter["Shape"] = filter.shapeIndex;

            serializedFilters.push(serializedFilter);
        }

        for (let i = 0; i < effects.children.length; i++) {
            var effect = effects.children[i];
            var effectModel = effect.knobModel;

            var serializedEffect = {};
            var effectKnobs = [];

            for (let j = 0; j < effectModel.children.length; j++) {
                var knobGroup = effectModel.children[j];

                if (knobGroup.type) {
                    effectKnobs.push(parseFloat(knobGroup.textValue));
                }
            }

            serializedEffect["KnobValues"] = effectKnobs;
            serializedEffects.push(serializedEffect);
        }

        return JSON.stringify({ Valid: true, Oscillators: serializedOscillators, Filters: serializedFilters, Effects: serializedEffects }, null, 4);
    }

    function readFile(filePath) {
        var file = new XMLHttpRequest();
        file.open("GET", filePath, true);
        file.onreadystatechange = function() {
            if (file.readyState === XMLHttpRequest.DONE) {
                if (file.status === 200) {
                    try {
                        var jsonContent = file.responseText;
                        var parsedJson = JSON.parse(jsonContent);
                        if (parsedJson["Valid"] !== true) {
                            errorMessageDialog.open();
                            return null;
                        }
                        setPreset(parsedJson);
                    } catch (e) {
                        console.error(e)
                        errorMessageDialog.open();
                    }
                } else {
                    console.error("Error reading file:", file.statusText);
                    errorMessageDialog.open();
                }
            }
        };
        file.send();
    }

    function setPreset(preset_json) {
        var oscillators = preset_json["Oscillators"];
        var filters = preset_json["Filters"];
        var effects = preset_json["Effects"];

        for (let i = 0; i < groupModel.children.length; i++) {
            var group = groupModel.children[i]
            var oscillator = group.osc;
            var filter = group.fltr;

            var oscillatorModel = oscillator.knobModel;
            var filterModel = filter.knobModel;

            var oscillatorParams = oscillators[i]["KnobValues"];
            var filterParams = filters[i]["KnobValues"];

            for (var j = 0; j < oscillatorParams.length; j++) {
                oscillatorModel.get(j).textValue = oscillatorParams[j];
            }

            oscillator.toggleOsc = oscillators[i]["Toggled"];
            oscillator.waveIndex = oscillators[i]["Waveform"];

            for (var j = 0; j < filterParams.length; j++) {
                filterModel.get(j).textValue = filterParams[j];
            }

            filter.mixValue = filters[i]["Mix"];
            filter.shapeIndex = filters[i]["Shape"];
        }

        for (let i = 0; i < fxModel.children.length; i++) {
            var effect = fxModel.children[i];
            var effectModel = effect.knobModel;

            var effectParams = effects[i]["KnobValues"];

            for (let j = 0; j < effectParams.length; j++) {
                effectModel.get(j).textValue = effectParams[j];
            }
        }
    }

    function finishPlayback() {
        midiTab.playing = false;
        midiTab.stopped = true;
    }

    PyoThread {
        id: pyo
    }

    Connections {
        target: pyo
        function onPlaybackFinished() {
            finishPlayback()
        }
    }

    RowLayout {
        id: bpmRow
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.topMargin: 10
        Layout.bottomMargin: 10
        spacing: 10

        Label {
            Layout.leftMargin: 10
            text: "BPM"
            width: 60
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        SpinBox {
            id: bpm
            width: 40
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            value: 120
            from: 1
            to: 1000
            onValueModified: pyo.set_bpm(value)
        }

        FileDialog {
            id: presetLoadFileDialog
            fileMode: FileDialog.OpenFile
            nameFilters: ["JSON files (*.json)", "Any (*)"]
            onAccepted: {
                readFile(selectedFile);
            }
        }

        FileDialog {
            id: presetSaveFileDialog
            fileMode: FileDialog.SaveFile
            nameFilters: ["JSON files (*.json)", "Any (*)"]
            defaultSuffix: "json"
            onAccepted: {
                var preset_content = serialize(groupModel, fxModel)
                pyo.save_preset(preset_content, selectedFile);
            }
        }

        Button {
            id: presetSave
            text: "Save preset"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: {
                presetSaveFileDialog.open()
            }
        }

        Button {
            id: presetLoad
            text: "Load preset"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: {
                presetLoadFileDialog.open()
            }
        }
    }


    TabBar {
        id: bar
        anchors.top: bpmRow.bottom
        anchors.left: parent.left
        width: parent.width

        TabButton {
            text: "Oscillators"
        }
        TabButton {
            text: "Effects"
        }
        TabButton {
            text: "MIDI"
        }
    }

    StackLayout {
        id: stack
        anchors.top: bar.bottom
        anchors.left: parent.left
        anchors.margins: 10
        width: parent.width
        height: parent.height - bar.height
        currentIndex: bar.currentIndex

        Item {
            id: oscillatorTab
            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                ListView {
                    id: oscillatorFilterView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: 1200
                    Layout.minimumHeight: 1400
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    model: groupModel
                }
            }
        }
        Item {
            id: fxTab

            GridView {
                id: fxGridView
                anchors.fill: parent
                cellWidth: 550
                cellHeight: 180
                currentIndex: -1    // hack ali radi
                model: fxModel
            }
        }
        Item {
            id: midiTab
            property alias midiFile: midiFileDialog.selectedFile
            property bool fileLoaded: false
            property bool playing: false
            property bool stopped: true

            RowLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                Label {
                    text: "MIDI File:"
                    width: 120
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                }

                Button {
                    id: fileButton
                    text: "Select MIDI file"
                    onClicked: midiFileDialog.open()
                }

                FileDialog {
                    id: midiFileDialog
                    fileMode: FileDialog.OpenFile
                    nameFilters: ["MIDI files (*.mid)", "Any (*)"]
                    onAccepted: {
                        pyo.set_midi_file(selectedFile);
                        midiTab.fileLoaded = true;
                    }
                }

                Button {
                    id: playButton
                    text: midiTab.playing ? "Pause" : "Play"
                    enabled: midiTab.fileLoaded
                    onClicked: {
                        midiTab.playing = !midiTab.playing;
                        midiTab.stopped = false
                        pyo.toggle_playback()
                    }
                }

                Button {
                    id: stopButton
                    text: "Stop"
                    enabled: !midiTab.stopped
                    onClicked: {
                        midiTab.playing = false;
                        midiTab.stopped = true
                        pyo.stop_playback()
                    }
                }
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        Layout.alignment: Qt.AlignBottom

        Label {
            text: "Dial control"
            width: 100
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignRight
        }

        ComboBox {
            width: 100
            Layout.alignment: Qt.AlignRight
            model: ["Vertical", "Horizontal", "Circular"]
            currentIndex: 0
            onCurrentIndexChanged: {
                switch (currentIndex) {
                    case 0:
                        dialInputMode = Dial.Vertical
                        break
                    case 1:
                        dialInputMode = Dial.Horizontal
                        break
                    case 2:
                        dialInputMode = Dial.Circular
                        break
                }
            }
        }
    }
}
