import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: oscFilterGroup
    property int groupIndex: 0
    property var pyoVar;
    property var oscillatorModel;
    property var filterModel;
    property alias oscillatorType: osc.type
    property alias oscillatorWaveforms: osc.waveformModel
    property alias oscillatorWaveIndex: osc.waveIndex
    property alias osc: osc
    property alias fltr: filter

    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

    Oscillator {
        id: osc
        pyo: pyoVar
        type: "Oscillator %1".arg(groupIndex + 1)
        knobModel: oscillatorModel
        oscIndex: groupIndex
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    Item {
        // spacer item
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.minimumWidth: 50
        property var type: "spacer"
    }

    Filter {
        id: filter
        pyo: pyoVar
        type: "Filter %1".arg(groupIndex + 1)
        knobModel: filterModel
        filterIndex: groupIndex
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
}