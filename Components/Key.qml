import QtQuick
import QtQuick.Controls

Rectangle {
    id: keyRect
    width: 50
    height: 200
    color: keyRect.isPressed ? "black" : "white"
    border.color: "black"
    MouseArea {
        id: keyArea
        anchors.fill: parent
        property bool isPressed: false
        onPressedChanged: keyRect.isPressed = pressed
        onClicked: {
            // Handle the MIDI input or any other desired action
            console.log("Note On: " + noteNumber)
        }
    }
}
