import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qtsynth.pyo 1
import "Components"

ApplicationWindow {
    width: 1280
    height: 1080
    visible: true
    title: qsTr("QtSynth")

    property int dialInputMode: Dial.Vertical

    PyoThread {
        id: pyo
    }

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: "Oscillators"
        }
        TabButton {
            text: "Effects"
        }
        TabButton {
            text: "MIDI"
        }
    }

    StackLayout {
        anchors.top: bar.bottom
        anchors.left: parent.left
        anchors.margins: 10
        width: parent.width
        height: parent.height - bar.height
        currentIndex: bar.currentIndex

        Item {
            id: oscillatorTab
            OscillatorTab {
                pyo: pyo
            }
        }
        Item {
            id: fxTab
        }
        Item {
            id: midiTab
            MidiTab {
                pyo: pyo
            }
        }
    }
}
