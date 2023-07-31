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
    property bool toggleState1: true
    property bool toggleState2: true

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

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                GridView {
                    id: adsr1
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.maximumHeight: 300
                    Layout.minimumHeight: 300
                    Layout.preferredHeight: 300
                    Layout.maximumWidth: 400
                    Layout.minimumWidth: 200
                    Layout.preferredWidth: 400
                    cellHeight: 150
                    model: knobModel1
                    delegate: KnobGroup {
                        property var element: knobModel1[model.index]
                        type: element.type
                        min: element.min
                        max: element.max
                        defaultValue: element.defaultValue
                        mod: element.mod(parseInt(textValue))
                    }
                }
            }

            Item {
                // spacer item
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 200
                Layout.maximumHeight: 600

                RowLayout {
                    Layout.alignment: Qt.AlignVCenter

                    // Waveform dropdown menu
                    ColumnLayout {
                        Label {
                            text: "Waveform"
                            width: 60
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignVCenter
                        }

                        ComboBox {
                            id: waveformComboBox1
                            width: 100
                            model: ["Sine", "Square", "Triangle", "Saw", "White noise"]
                            currentIndex: 0
                            Layout.alignment: Qt.AlignHCenter
                            onActivated: {
                                pyo.set_osc1(currentIndex)
                            }
                        }
                    }

                    // Toggle button
                    ColumnLayout {
                        Label {
                            text: "Toggle"
                            width: 60
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        }

                        Button {
                            id: toggleButton1
                            width: 60
                            height: 30
                            text: toggleState1 ? "On" : "Off"
                            onClicked: {
                                toggleState1 = !toggleState1;
                                pyo.toggle_osc1();
                            }
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                GridView {
                    id: adsr2
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.maximumHeight: 300
                    Layout.minimumHeight: 300
                    Layout.preferredHeight: 300
                    Layout.maximumWidth: 400
                    Layout.minimumWidth: 200
                    Layout.preferredWidth: 400
                    cellHeight: 150
                    model: knobModel2
                    delegate: KnobGroup {
                        property var element: knobModel2[model.index]
                        type: element.type
                        min: element.min
                        max: element.max
                        defaultValue: element.defaultValue
                        mod: element.mod(parseInt(textValue))
                    }
                }
            }

            Item {
                // spacer item
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: 200
                Layout.maximumHeight: 600

                RowLayout {
                    Layout.alignment: Qt.AlignVCenter

                    // Waveform dropdown menu
                    ColumnLayout {
                        Label {
                            text: "Waveform"
                            width: 60
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignVCenter
                        }

                        ComboBox {
                            id: waveformComboBox2
                            width: 100
                            model: ["Sine", "Square", "Triangle", "Saw", "White noise"]
                            currentIndex: 0
                            Layout.alignment: Qt.AlignHCenter
                            onActivated: {
                                pyo.set_osc2(currentIndex)
                            }
                        }
                    }

                    // Toggle button
                    ColumnLayout {
                        Label {
                            text: "Toggle"
                            width: 60
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        }

                        Button {
                            id: toggleButton2
                            width: 60
                            height: 30
                            text: toggleState2 ? "On" : "Off"
                            onClicked: {
                                toggleState2 = !toggleState2;
                                pyo.toggle_osc2();
                            }
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        }
                    }
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
