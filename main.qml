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

    property list<ObjectModel> oscillatorModels: [
        ObjectModel {
            id: oscillatorModel1

            KnobGroup { id: octave1; type: "Octave"; min: -2; max: 2; defaultValue: 0; mod: pyo.set_octave1(parseFloat(textValue)) }
            KnobGroup { id: level1; type: "Level"; min: 0; max: 100; defaultValue: 100; mod: pyo.set_level1(parseFloat(textValue)) }
            KnobGroup { id: detune1; type: "Detune"; min: -50; max: 50; defaultValue: 0; mod: pyo.set_detune1(parseFloat(textValue)) }
            KnobGroup { id: pan1; type: "Pan"; min: -100; max: 100; defaultValue: 0; mod: pyo.set_pan1(parseFloat(textValue)) }
            KnobGroup { id: attack1; type: "Attack"; min: 0; max: 1000; defaultValue: 10; mod: pyo.set_A1(parseFloat(textValue)) }
            KnobGroup { id: decay; type: "Decay"; min: 0; max: 1000; defaultValue: 50; mod: pyo.set_D1(parseFloat(textValue)) }
            KnobGroup { id: sustain1; type: "Sustain"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_S1(parseFloat(textValue)) }
            KnobGroup { id: release1; type: "Release"; min: 0; max: 5000; defaultValue: 100; mod: pyo.set_R1(parseFloat(textValue)) }
        },

        ObjectModel {
            id: oscillatorModel2

            KnobGroup { id: octave2; type: "Octave"; min: -2; max: 2; defaultValue: 0; mod: pyo.set_octave2(parseFloat(textValue)) }
            KnobGroup { id: level2; type: "Level"; min: 0; max: 100; defaultValue: 100; mod: pyo.set_level2(parseFloat(textValue)) }
            KnobGroup { id: detune2; type: "Detune"; min: -50; max: 50; defaultValue: 0; mod: pyo.set_detune2(parseFloat(textValue)) }
            KnobGroup { id: pan2; type: "Pan"; min: -100; max: 100; defaultValue: 0; mod: pyo.set_pan2(parseFloat(textValue)) }
            KnobGroup { id: attack2; type: "Attack"; min: 0; max: 1000; defaultValue: 10; mod: pyo.set_A2(parseFloat(textValue)) }
            KnobGroup { id: decay2; type: "Decay"; min: 0; max: 1000; defaultValue: 50; mod: pyo.set_D2(parseFloat(textValue)) }
            KnobGroup { id: sustain2; type: "Sustain"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_S2(parseFloat(textValue)) }
            KnobGroup { id: release2; type: "Release"; min: 0; max: 5000; defaultValue: 100; mod: pyo.set_R2(parseFloat(textValue)) }
        },

        ObjectModel {
            id: oscillatorModel3

            KnobGroup { id: attack3; type: "Attack"; min: 0; max: 1000; defaultValue: 10; mod: pyo.set_A3(parseFloat(textValue)) }
            KnobGroup { id: decay3; type: "Decay"; min: 0; max: 1000; defaultValue: 50; mod: pyo.set_D3(parseFloat(textValue)) }
            KnobGroup { id: sustain3; type: "Sustain"; min: 0; max: 100; defaultValue: 50; mod: pyo.set_S3(parseFloat(textValue)) }
            KnobGroup { id: release3; type: "Release"; min: 0; max: 5000; defaultValue: 100; mod: pyo.set_R3(parseFloat(textValue)) }
            KnobGroup { id: level3; type: "Level"; min: 0; max: 100; defaultValue: 100; mod: pyo.set_level3(parseFloat(textValue)) }
            KnobGroup { id: pan3; type: "Pan"; min: -100; max: 100; defaultValue: 0; mod: pyo.set_pan3(parseFloat(textValue)) }
        }
    ]

    property list<ObjectModel> filterModels: [
        ObjectModel {
            id: filterModel1

            KnobGroup { id: rate1; type: "Rate"; min: 0; max: 20; defaultValue: 1; mod: pyo.set_filter_rate1(parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq1; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; mod: pyo.set_freq1(parseFloat(textValue)) }
            KnobGroup { id: width1; type: "Width"; min: 0; max: 10000; defaultValue: 100; mod: pyo.set_filter_width1(parseFloat(textValue)) }
            KnobGroup { id: q1; type: "Q"; min: 1; max: 10; defaultValue: 1; mod: pyo.set_Q1(parseFloat(textValue)) }
        },

        ObjectModel {
            id: filterModel2

            KnobGroup { id: rate2; type: "Rate"; min: 0; max: 20; defaultValue: 1; mod: pyo.set_filter_rate2(parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq2; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; mod: pyo.set_freq2(parseFloat(textValue)) }
            KnobGroup { id: width2; type: "Width"; min: 0; max: 10000; defaultValue: 100; mod: pyo.set_filter_width2(parseFloat(textValue)) }
            KnobGroup { id: q2; type: "Q"; min: 1; max: 10; defaultValue: 1; mod: pyo.set_Q2(parseFloat(textValue)) }
        },

        ObjectModel {
            id: filterModel3

            KnobGroup { id: rate3; type: "Rate"; min: 0; max: 20; defaultValue: 1; mod: pyo.set_filter_rate3(parseFloat(textValue)); step: 0.01 }
            KnobGroup { id: freq3; type: "Frequency"; min: 0; max: 20000; defaultValue: 1000; mod: pyo.set_freq3(parseFloat(textValue)) }
            KnobGroup { id: width3; type: "Width"; min: 0; max: 10000; defaultValue: 100; mod: pyo.set_filter_width3(parseFloat(textValue)) }
            KnobGroup { id: q3; type: "Q"; min: 1; max: 10; defaultValue: 1; mod: pyo.set_Q3(parseFloat(textValue)) }
        }
    ]

    ObjectModel {
        id: groupModel

        OscillatorFilterGroup { id: group1; groupIndex: 0; pyoGlob: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex] }
        OscillatorFilterGroup { id: group2; groupIndex: 1; pyoGlob: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex] }
        OscillatorFilterGroup { id: group3; groupIndex: 2; pyoGlob: pyo; oscillatorModel: oscillatorModels[groupIndex]; filterModel: filterModels[groupIndex] }
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

    function serialize(oscillators, filters) {
        var serializedOscillators = [];

        for (var i = 0; i < oscillators.length; i++) {
            var oscillator = oscillators[i];

            var serializedOscillator = [];

            for (var j = 0; j < oscillator.children.length; j++) {
                var knobGroup = oscillator.children[j];

                if (knobGroup.type) {
                    serializedOscillator.push(parseFloat(knobGroup.textValue));
                }
            }

            serializedOscillators.push(serializedOscillator);
        }

        var serializedFilters = [];

        for (var i = 0; i < filters.length; i++) {
            var filter = filters[i];

            var serializedFilter = [];

            for (var j = 0; j < filter.children.length; j++) {
                var knobGroup = filter.children[j];

                if (knobGroup.type) {
                    serializedFilter.push(parseFloat(knobGroup.textValue));
                }
            }

            serializedFilters.push(serializedFilter);
        }

        return JSON.stringify({ Valid: true, Oscillators: serializedOscillators, Filters: serializedFilters }, null, 4);
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
        for (var i = 0; i < oscillators.length; i++) {
            var oscillator = oscillatorModels[i];
            var oscillator_params = oscillators[i];

            for (var j = 0; j < oscillator_params.length; j++) {
                oscillator.get(j).textValue = oscillator_params[j];
            }
        }

        var filters = preset_json["Filters"];
        for (var i = 0; i < filters.length; i++) {
            var filter = filterModels[i];
            var filter_params = filters[i];

            for (var j = 0; j < filter_params.length; j++) {
                filter.get(j).textValue = filter_params[j];
            }
        }
    }

    PyoThread {
        id: pyo
    }

    RowLayout {
        id: bpmRow
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

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
            height: 30
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
                var preset_content = serialize(oscillatorModels, filterModels)
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

        Button {
            id: ajmoProbat
            text: pyo.test_counter
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: {
                // console.log(filter3.knobModel);
                // console.log(freq3);
                // console.log(freq3.textValue)
                console.log(pyo.test_counter);
                console.log(midiTab.midiFile)
                pyo.test_counter = pyo.test_counter + 1;
                console.log(serialize(oscillatorModels, filterModels))
                freq3.textValue = 2000;
                filterModels[2].get(3).textValue = 3
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
                    model: groupModel
                }

                RowLayout {
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
        }
        Item {
            id: fxTab
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
}
