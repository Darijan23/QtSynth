import QtQuick
import QtQuick.Controls

Item {
    property string type: "Label"
    property var mod: function() {}
    property int min: 0
    property int max: 100
    property int defaultValue: 50
    property alias textValue: field.text

    Column {
        Label {
            id: label
            text: type
            width: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Dial {
            id: dial
            height: 75
            width: height
            spacing: 0
            from: min
            to: max
            value: defaultValue
            stepSize: 1
            snapMode: Dial.SnapAlways
            inputMode: dialInputMode
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            id: field
            width: 40
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text: dial.value
            horizontalAlignment: TextInput.AlignRight

            Binding {
                target: dial
                property: "value"
                value: parseInt(field.text)
            }

            onTextChanged: mod
        }
    }
}