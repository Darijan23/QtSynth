import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: fxGroup
    property string type: "Effect"
    property var pyoVar;
    property alias knobModel: effect.model
    Layout.fillWidth: true
    Layout.fillHeight: true

    spacing: 20

    Label {
        text: type
        font.pixelSize: 18
        horizontalAlignment: Text.AlignLeft
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    GridView {
        id: effect
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: 250
        Layout.minimumHeight: 120
        Layout.preferredHeight: 120
        Layout.maximumWidth: 500
        Layout.minimumWidth: 400
        Layout.preferredWidth: 500
        cellHeight: 120
        model: knobModel
    }
}
