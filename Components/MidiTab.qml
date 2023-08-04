import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Item {
    property var pyo;
    property alias midiFile: midiFileDialog.selectedFile

    RowLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

        Label {
            text: "MIDI File:"
            width: 120
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Button {
            id: fileButton
            text: "Select MIDI file"
            onClicked: midiFileDialog.open()
        }

        FileDialog {
            id: midiFileDialog
            fileMode: FileDialog.OpenFile
            nameFilters: ["MIDI files (*.mid)", "Any (*)"]
            onAccepted: {
                pyo.set_midi_file(midiFile);
            }
        }

        Button {
            id: playButton
            text: "Play"
            onClicked: pyo.play_file()
        }
    }
}