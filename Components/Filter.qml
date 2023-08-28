import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: filterGroup
    property string type: "Filter"
    property bool toggleFilter: true
    property var pyo;
    property alias knobModel: filter.model
    property int filterIndex;
    property var mixFunc: function() {}
    property alias mixValue: mixKnob.textValue
    property alias shapeIndex: shapeComboBox.currentIndex

    spacing: 20

    Label {
        text: type
        font.pixelSize: 18
        horizontalAlignment: Text.AlignLeft
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    RowLayout {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        spacing: 10

        GridView {
            id: filter
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 120
            Layout.minimumHeight: 120
            Layout.preferredHeight: 120
            Layout.maximumWidth: 400
            Layout.minimumWidth: 400
            Layout.preferredWidth: 400
            cellHeight: 120
            model: knobModel
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 120
            Layout.maximumHeight: 120

            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter

                Label {
                    text: "Waveform"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignVCenter
                }

                ComboBox {
                    id: shapeComboBox
                    width: 100
                    model: ["Lowpass", "Highpass", "Bandpass", "Bandstop", "Allpass"]
                    currentIndex: 0
                    Layout.alignment: Qt.AlignVCenter
                    onActivated: {
                        pyo.set_filter(filterIndex, currentIndex);
                    }
                }
            }
        }

        KnobGroup {
            id: mixKnob
            type: "Mix"
            mod: pyo.filter_mix(filterIndex, parseFloat(textValue))
            defaultValue: 100
            Layout.alignment: Qt.AlignTop
        }
    }
}
