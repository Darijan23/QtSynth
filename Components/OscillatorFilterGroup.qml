import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: oscFilterGroup
    property int groupIndex: 0
    property var pyoGlob;
    property var oscillatorModel;
    property var filterModel;
    property alias osc: osc
    property alias fltr: filter

    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

    Oscillator {
        id: osc
        pyo: pyoGlob
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
        pyo: pyoGlob
        type: "Filter %1".arg(groupIndex + 1)
        knobModel: filterModel
        filterIndex: groupIndex
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
}