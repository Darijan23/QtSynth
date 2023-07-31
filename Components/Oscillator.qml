import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: oscGroup
    property bool toggleOsc: true
    property var knobModel;
    property var oscFunc: function() {}
    property var toggleFunc: function() {}

    ColumnLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

        GridView {
            id: adsr
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
                    id: waveformComboBox
                    width: 100
                    model: ["Sine", "Square", "Triangle", "Saw", "White noise"]
                    currentIndex: 0
                    Layout.alignment: Qt.AlignHCenter
                    onActivated: {
                        oscGroup.oscFunc(currentIndex);
                        console.log(currentIndex);
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
                    text: toggleOsc ? "On" : "Off"
                    onClicked: {
                        toggleOsc = !toggleOsc;
                        oscGroup.toggleFunc();
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
            }
        }
    }
}
