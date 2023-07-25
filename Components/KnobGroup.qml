import QtQuick
import QtQuick.Controls

Column {
    property string type: "Label"
    property var mod
    property int min: 0
    property int max: 100
    property int defaultValue: 50
    property alias textValue: field.text

    Label {
        id: label
        text: type
        width: 60
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Dial {
        id: dial
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
        width: 60
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        text: dial.value

        Binding {
            target: dial
            property: "value"
            value: parseInt(field.text)
        }

        onTextChanged: mod
    }
}