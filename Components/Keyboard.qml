import QtQuick
import QtQuick.Controls

Item {
    width: 600
    height: 200

    property int octaveStart: 4
    property int octaveEnd: 6
    property int whiteKeyCount: 7

    Column {
        spacing: 0

        Repeater {
            id: octaveRepeater
            model: octaveEnd - octaveStart + 1
            delegate: Row {
                spacing: 0
                property int octaveIndex: index + octaveStart

                Repeater {
                    model: whiteKeyCount
                    delegate: Key {
                        width: parent.width / whiteKeyCount
                        height: parent.height
                        property int noteNumber: index + octaveIndex * whiteKeyCount
                    }
                }
            }
        }

        Row {
            spacing: 0
            Repeater {
                model: octaveRepeater.count * (whiteKeyCount - 1)
                delegate: Rectangle {
                    width: parent.width / model
                    height: parent.height / 2
                    color: "black"
                    border.color: "black"
                    MouseArea {
                        anchors.fill: parent
                        property int noteNumber: index + 1 + Math.floor(index / (whiteKeyCount - 1)) * whiteKeyCount
                        onClicked: {
                            // Handle the MIDI input or any other desired action
                            console.log("Note On: " + noteNumber)
                        }
                    }
                }
            }
        }
    }
}
