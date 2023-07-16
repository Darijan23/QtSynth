import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("QtSynth")

    property int dialInputMode: Dial.Vertical
    property bool toggleState: true

    Column {
        anchors.fill: parent
        spacing: 10

        Row {
            spacing: 10

            // Octave
            Column {
                Label {
                    text: "Octave"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: octaveDial
                    from: -2
                    to: 2
                    value: 0
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_octave(value)
                    }
                }

                TextField {
                    id: octaveInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(octaveDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= octaveDial.from && parsedValue <= octaveDial.to) {
                            octaveDial.value = parsedValue;
                        }
                    }
                }
            }

            // Level
            Column {
                Label {
                    text: "Level"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: levelDial
                    from: 0
                    to: 100
                    value: 100
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_level(value)
                    }
                }

                TextField {
                    id: levelInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(levelDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= levelDial.from && parsedValue <= levelDial.to) {
                            levelDial.value = parsedValue;
                        }
                    }
                }
            }

            // Detune
            Column {
                Label {
                    text: "Detune"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: detuneDial
                    from: -50
                    to: 50
                    value: 0
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_detune(value)
                    }
                }

                TextField {
                    id: detuneInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(detuneDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= detuneDial.from && parsedValue <= detuneDial.to) {
                            detuneDial.value = parsedValue;
                        }
                    }
                }
            }

            // Pan
            Column {
                Label {
                    text: "Pan"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: panDial
                    from: -100
                    to: 100
                    value: 0
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_pan(value)
                    }
                }

                TextField {
                    id: panInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(panDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= panDial.from && parsedValue <= panDial.to) {
                            panDial.value = parsedValue;
                        }
                    }
                }
            }
        }

        Row {
            spacing: 10

            // Attack
            Column {

                Label {
                    text: "Attack"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: attackDial
                    from: 0
                    to: 1000
                    value: 10
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_ADSR("A", value)
                    }
                }

                TextField {
                    id: attackInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(attackDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= attackDial.from && parsedValue <= attackDial.to) {
                            attackDial.value = parsedValue;
                        }
                    }
                }
            }

            // Decay
            Column {

                Label {
                    text: "Decay"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: decayDial
                    from: 0
                    to: 1000
                    value: 50
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_ADSR("D", value)
                    }
                }

                TextField {
                    id: decayInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(decayDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= decayDial.from && parsedValue <= decayDial.to) {
                            decayDial.value = parsedValue;
                        }
                    }
                }
            }

            // Sustain
            Column {

                Label {
                    text: "Sustain"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: sustainDial
                    from: 0
                    to: 100
                    value: 50
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_ADSR("S", value)
                    }
                }

                TextField {
                    id: sustainInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(sustainDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= sustainDial.from && parsedValue <= sustainDial.to) {
                            sustainDial.value = parsedValue;
                        }
                    }
                }
            }

            // Release
            Column {

                Label {
                    text: "Release"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Dial {
                    id: releaseDial
                    from: 0
                    to: 5000
                    value: 100
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    inputMode: dialInputMode
                    anchors.horizontalCenter: parent.horizontalCenter
                    onMoved: {
                        pyo.set_ADSR("R", value)
                    }
                }

                TextField {
                    id: releaseInput
                    width: 60
                    height: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(releaseDial.value).toString()
                    onTextChanged: {
                        var parsedValue = parseInt(text);
                        if (!isNaN(parsedValue) && parsedValue >= releaseDial.from && parsedValue <= releaseDial.to) {
                            releaseDial.value = parsedValue;
                        }
                    }
                }
            }

            // Waveform dropdown menu
            Column {
                Label {
                    text: "Waveform"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ComboBox {
                    id: waveformComboBox
                    width: 100
                    model: ["Sine", "Square", "Triangle", "Saw", "White noise"]
                    currentIndex: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    onActivated: {
                        pyo.set_osc(currentIndex)
                    }
                }
            }

            // Toggle button
            Column {
                Label {
                    text: "Toggle"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    id: toggleButton
                    width: 60
                    height: 30
                    text: toggleState ? "On" : "Off"
                    onClicked: {
                        toggleState = !toggleState
                        pyo.toggle_osc()
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            // Play button
            Button {
                text: "Play"
                onPressed: {
                    pyo.play_note()
                }
                onReleased: {
                    pyo.stop_note()
                }
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: "Dial control"
                width: 100
                horizontalAlignment: Text.AlignRight
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 100
                model: ["Vertical", "Horizontal", "Circular"]
                currentIndex: 0
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                        case 0:
                            dialInputMode = Dial.Vertical
                            break
                        case 1:
                            dialInputMode = Dial.Horizontal
                            break
                        case 2:
                            dialInputMode = Dial.Circular
                            break
                    }
                }
            }
        }
    }
}
