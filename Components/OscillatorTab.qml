import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property var pyo;

    property var oscillatorModel1: [
        { type: "Octave", min: -2, max: 2, defaultValue: 0, mod: pyo.set_octave1 },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level1 },
        { type: "Detune", min: -50, max: 50, defaultValue: 0, mod: pyo.set_detune1 },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan1 },
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A1 },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D1 },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S1 },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R1 },
    ]

    property var oscillatorModel2: [
        { type: "Octave", min: -2, max: 2, defaultValue: 0, mod: pyo.set_octave2 },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level2 },
        { type: "Detune", min: -50, max: 50, defaultValue: 0, mod: pyo.set_detune2 },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan2 },
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A2 },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D2 },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S2 },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R2 },
    ]

    property var oscillatorModel3: [
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A3 },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D3 },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S3 },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R3 },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level3 },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan3 },
    ]

    property var filterModel1: [
        { type: "Rate", min: 0, max: 20, defaultValue: 1, mod: pyo.set_filter_rate1, dialStep: 0.01 },
        { type: "Frequency", min: 0, max: 20000, defaultValue: 1000, mod: pyo.set_freq1 },
        { type: "Width", min: 0, max: 10000, defaultValue: 100, mod: pyo.set_filter_width1 },
        { type: "Q", min: 1, max: 10, defaultValue: 1, mod: pyo.set_Q1 },
    ]

    property var filterModel2: [
        { type: "Rate", min: 0, max: 20, defaultValue: 1, mod: pyo.set_filter_rate2, dialStep: 0.01 },
        { type: "Frequency", min: 0, max: 20000, defaultValue: 1000, mod: pyo.set_freq2 },
        { type: "Width", min: 0, max: 10000, defaultValue: 100, mod: pyo.set_filter_width2 },
        { type: "Q", min: 1, max: 10, defaultValue: 1, mod: pyo.set_Q2, dialStep: 0.01 },
    ]

    property var filterModel3: [
        { type: "Rate", min: 0, max: 20, defaultValue: 1, mod: pyo.set_filter_rate3, dialStep: 0.01 },
        { type: "Frequency", min: 0, max: 20000, defaultValue: 1000, mod: pyo.set_freq3 },
        { type: "Width", min: 0, max: 10000, defaultValue: 100, mod: pyo.set_filter_width3 },
        { type: "Q", min: 1, max: 10, defaultValue: 1, mod: pyo.set_Q3, dialStep: 0.01 },
    ]

    ColumnLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            Label {
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
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                Oscillator {
                    id: osc1
                    knobModel: oscillatorModel1
                    oscFunc: pyo.set_osc1
                    toggleFunc: pyo.toggle_osc1
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }

                Oscillator {
                    id: osc2
                    knobModel: oscillatorModel2
                    oscFunc: pyo.set_osc2
                    toggleFunc: pyo.toggle_osc2
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }

                Oscillator {
                    id: osc3
                    knobModel: oscillatorModel3
                    oscFunc: pyo.set_osc3
                    toggleFunc: pyo.toggle_osc3
                    waveformModel: ["White noise", "Pink noise", "Brown noise"]
                    waveIndex: 0
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }
            }

            Item {
                // spacer item
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                Filter {
                    id: filter1
                    knobModel: filterModel1
                    lfoFunc: pyo.set_filter1
                    toggleFunc: pyo.toggle_filter1
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }

                Filter {
                    id: filter2
                    knobModel: filterModel2
                    lfoFunc: pyo.set_filter2
                    toggleFunc: pyo.toggle_filter2
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }

                Filter {
                    id: filter3
                    knobModel: filterModel3
                    lfoFunc: pyo.set_filter3
                    toggleFunc: pyo.toggle_filter3
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }
            }
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