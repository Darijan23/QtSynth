import QtQuick
import QtQuick.Controls

import qtsynth.pyo 1
import "Components"

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("QtSynth")

    property int dialInputMode: Dial.Vertical
    property bool toggleState: true

    PyoThread {
        id: pyo
    }

    Column {
        anchors.fill: parent
        spacing: 10

        Row {
            spacing: 10

            // Octave
            KnobGroup {
                id: octave
                type: "Octave"
                min: -2
                max: 2
                defaultValue: 0
                mod: pyo.set_octave(parseInt(textValue))
            }

            // Level
            KnobGroup {
                id: level
                type: "Level"
                min: 0
                max: 100
                defaultValue: 100
                mod: pyo.set_level(parseInt(textValue))
            }

            // Detune
            KnobGroup {
                id: detune
                type: "Detune"
                min: -50
                max: 50
                defaultValue: 0
                mod: pyo.set_detune(parseInt(textValue))
            }

            // Pan
            KnobGroup {
                id: pan
                type: "Pan"
                min: -100
                max: 100
                defaultValue: 0
                mod: pyo.set_pan(parseInt(textValue))
            }
        }

        Row {
            spacing: 10

            // Attack
            KnobGroup {
                id: attack
                type: "Attack"
                min: 0
                max: 1000
                defaultValue: 10
                mod: pyo.set_ADSR("A", parseInt(textValue))
            }

            // Decay
            KnobGroup {
                id: decay
                type: "Decay"
                min: 0
                max: 1000
                defaultValue: 50
                mod: pyo.set_ADSR("D", parseInt(textValue))
            }

            // Sustain
            KnobGroup {
                id: sustain
                type: "Sustain"
                min: 0
                max: 100
                defaultValue: 50
                mod: pyo.set_ADSR("S", parseInt(textValue))
            }

            // Release
            KnobGroup {
                id: release
                type: "Release"
                min: 0
                max: 5000
                defaultValue: 100
                mod: pyo.set_ADSR("R", parseInt(textValue))
            }

            // Waveform dropdown menu
            Column {
                Label {
                    text: "Waveform"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ComboBox {
                    id: waveformComboBox
                    width: 100
                    model: ["Sine", "Square", "Triangle", "Saw", "White noise"]
                    currentIndex: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    onActivated: {
                        pyo.set_osc(currentIndex)
                    }
                }
            }

            // Toggle button
            Column {
                Label {
                    text: "Toggle"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    id: toggleButton
                    width: 60
                    height: 30
                    text: toggleState ? "On" : "Off"
                    onClicked: {
                        toggleState = !toggleState
                        pyo.toggle_osc()
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            // Play button
            Button {
                text: "Play"
                onPressed: {
                    pyo.play_note()
                }
                onReleased: {
                    pyo.stop_note()
                }
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: "Dial control"
                width: 100
                horizontalAlignment: Text.AlignRight
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 100
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
