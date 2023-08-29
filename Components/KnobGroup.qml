import QtQuick
import QtQuick.Controls

Column {
    id: knobGroup
    property string type: "Label"
    property var mod: function() {}
    property double min: 0
    property double max: 100
    default property var step: 1.0
    property double defaultValue: 50
    property alias textValue: dial.value

    Label {
        id: label
        text: type
        width: 40
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Dial {
        id: dial
        height: 60
        width: height
        spacing: 0
        from: min
        to: max
        value: defaultValue
        stepSize: step
        snapMode: Dial.SnapAlways
        inputMode: dialInputMode
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextField {
        id: field
        width: 50
        height: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: textValue.toFixed(Math.ceil(Math.log10(1.0 / step)))
        horizontalAlignment: TextInput.AlignRight

        onTextChanged: mod
    }

    Binding {
        target: dial
        property: "value"
        value: parseFloat(field.text)
    }
}