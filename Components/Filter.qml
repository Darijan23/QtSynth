import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: filterGroup
    property bool toggleFilter: true
    property var pyo;
    property var knobModel;
    property int filterIndex;
    property var mixFunc: function() {}
    default property var dialStep: 1.0

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
                        pyo.set_filter(filterIndex, currentIndex);
                    }
                }
            }

            KnobGroup {
                type: "Mix"
                mod: pyo.filter_mix(filterIndex, parseFloat(textValue))
                defaultValue: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }
        }
    }
}
