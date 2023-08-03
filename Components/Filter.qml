import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: filterGroup
    property bool toggleFilter: true
    property var knobModel;
    default property var dialStep: 1.0
    property var lfoFunc: function() {}
    property var toggleFunc: function() {}

    ColumnLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

        GridView {
            id: filter
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 150
            Layout.minimumHeight: 150
            Layout.preferredHeight: 150
            Layout.maximumWidth: 400
            Layout.minimumWidth: 400
            Layout.preferredWidth: 400
            cellHeight: 150
            model: knobModel
            delegate: KnobGroup {
                property var element: knobModel[model.index]
                type: element.type
                min: element.min
                max: element.max
                defaultValue: element.defaultValue
                step: element.dialStep
                mod: element.mod(parseFloat(textValue))
            }
        }
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.preferredHeight: 150
        Layout.maximumHeight: 150

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
                    model: ["Lowpass", "Highpass", "Bandpass", "Bandstop", "Allpass"]
                    currentIndex: 0
                    Layout.alignment: Qt.AlignHCenter
                    onActivated: {
                        filterGroup.lfoFunc(currentIndex);
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
                    text: filterGroup.toggleFilter ? "On" : "Off"
                    onClicked: {
                        filterGroup.toggleFilter = !filterGroup.toggleFilter;
                        filterGroup.toggleFunc();
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
            }
        }
    }
}
