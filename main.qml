import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qtsynth.pyo 1
import "Components"

ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("QtSynth")

    property int dialInputMode: Dial.Vertical

    PyoThread {
        id: pyo
    }

    property var knobModel1: [
        { type: "Octave", min: -2, max: 2, defaultValue: 0, mod: pyo.set_octave1 },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level1 },
        { type: "Detune", min: -50, max: 50, defaultValue: 0, mod: pyo.set_detune1 },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan1 },
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A1 },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D1 },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S1 },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R1 },
    ]

    property var knobModel2: [
        { type: "Octave", min: -2, max: 2, defaultValue: 0, mod: pyo.set_octave2 },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level2 },
        { type: "Detune", min: -50, max: 50, defaultValue: 0, mod: pyo.set_detune2 },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan2 },
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A2 },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D2 },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S2 },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R2 },
    ]


    ColumnLayout {
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 5

        Oscillator {
            id: osc1
            knobModel: knobModel1
            oscFunc: pyo.set_osc1
            toggleFunc: pyo.toggle_osc1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        Oscillator {
            id: osc2
            knobModel: knobModel2
            oscFunc: pyo.set_osc2
            toggleFunc: pyo.toggle_osc2
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
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
