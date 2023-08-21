import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: oscGroup
    property string type: "Oscillator"
    property bool toggleOsc: true
    property var pyo;
    property var knobModel;
    property var waveformModel: ["Saw up", "Saw down", "Square", "Triangle", "Pulse", "Bipolar Pulse", "Sample and hold", "Sine"]
    property var waveIndex: 7
    property int oscIndex;

    spacing: 20

    Label {
        text: type
        font.pixelSize: 18
        horizontalAlignment: Text.AlignLeft
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    RowLayout {
        ColumnLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignTop

            GridView {
                id: adsr
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 240
                Layout.minimumHeight: 240
                Layout.preferredHeight: 240
                Layout.maximumWidth: 400
                Layout.minimumWidth: 400
                Layout.preferredWidth: 400
                cellHeight: 120
                model: knobModel
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredHeight: 240
            Layout.maximumHeight: 240

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
                        id: waveformComboBox
                        width: 100
                        model: waveformModel
                        currentIndex: waveIndex
                        Layout.alignment: Qt.AlignHCenter
                        onActivated: {
                            pyo.set_oscillator(oscIndex, currentIndex);
                        }
                    }
                }

                // Toggle button
                ColumnLayout {
                    Layout.alignment: Qt.AlignVCenter

                    Label {
                        text: "Toggle"
                        width: 60
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Button {
                        id: toggleButton1
                        width: 60
                        height: 30
                        text: toggleOsc ? "On" : "Off"
                        onClicked: {
                            toggleOsc = !toggleOsc;
                            pyo.toggle_oscillator(oscIndex);
                        }
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }
            }
        }
    }
}
