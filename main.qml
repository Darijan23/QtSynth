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

    property var knobModel: [
        { type: "Octave", min: -2, max: 2, defaultValue: 0, mod: pyo.set_octave },
        { type: "Level", min: 0, max: 100, defaultValue: 100, mod: pyo.set_level },
        { type: "Detune", min: -50, max: 50, defaultValue: 0, mod: pyo.set_detune },
        { type: "Pan", min: -100, max: 100, defaultValue: 0, mod: pyo.set_pan },
        { type: "Attack", min: 0, max: 1000, defaultValue: 10, mod: pyo.set_A },
        { type: "Decay", min: 0, max: 1000, defaultValue: 50, mod: pyo.set_D },
        { type: "Sustain", min: 0, max: 100, defaultValue: 50, mod: pyo.set_S },
        { type: "Release", min: 0, max: 5000, defaultValue: 100, mod: pyo.set_R },
    ]

     Column {
        anchors.fill: parent
        spacing: 10

        GridView {
            id: knobGrid
            width: parent.width * 0.75
            height: parent.height / 1.5
            cellHeight: 180
            model: knobModel
            delegate: KnobGroup {
                property var element: knobModel[model.index]
                type: element.type
                min: element.min
                max: element.max
                defaultValue: element.defaultValue
                mod: element.mod(parseInt(textValue))
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

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

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
    }
}
