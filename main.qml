import QtQuick 2.15
import QtQuick.Window 2.15

import QtQml.StateMachine 1.15 as DSM

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Omilo android")

    signal countDownFinished()
    signal connectionEstablished()
    signal disconnected()
    //signal showInfo()
    //signal hideInfo()
    signal wake()
    signal showSettings()
    signal exitSettings()

    property int secondsElapsed: 0

    property bool isConnected: false

    States {
    }

    Connections {
        target: chat
        function onConnected() {
            console.log("connected")
            isConnected = true
            connectionEstablished()
        }
    }

    Connections {
        target: chat
        function onDisconnected() {
            console.log("disconnected")
            isConnected = false
            disconnected()
            texttospeech.stop()
        }
    }

//    Connections {
//        target: texttospeech
//        function onInfoUpdate() {
//            speechSettings.getInfo()
//        }
//    }

    Rectangle {
        id: mainRect
        anchors.fill: parent

        Text {
            id: text
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 4
            font.family: "Helvetica"
            font.pointSize: 24
            color: "green"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }

        Text {
            id: text2
            anchors.top: text.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 4
            font.family: "Helvetica"
            font.pointSize: 16
            color: "green"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                console.log("mousearea pressed")
                wake()
            }
        }

        Rectangle {
            id: settingsButton
            border.color: "grey"
            border.width: 7
            radius: 15
            anchors.top:  text2.bottom
            anchors.topMargin: 50
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 3
            anchors.leftMargin: parent.width / 3
            anchors.left: parent.left
            height: 50

            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                font.family: "Helvetica"
                font.pointSize: 16
                color: "green"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                text: qsTr("Settings")
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    console.log("Settings pressed")
                    showSettings()
                }
            }
        }
    }





    SpeechSettings {
        id: speechSettings
        anchors.fill: parent
        visible: false
    }

    Timer {
        id:timer
        interval: 1000
        repeat: true
        onTriggered: {
            secondsElapsed++
            if (secondsElapsed >= 10) {
                countDownFinished()
            } else {
//                mainRect.color = "white"
//                text.text = qsTr("Connected to\n")
//                        + chat.getCurrentClient()
                text2.text = qsTr("The screen will turn off in ") + (10 - secondsElapsed)
                timer.repeat = true
                timer.start()
            }
        }
    }

//    Timer {
//        id: timer2
//        interval: 10000
//        onTriggered: hideInfo()
//    }

    function waitingStateEntered() {
        timer.repeat = false
        timer.stop()
        secondsElapsed = 0
        mainRect.color = "white"
        text.text = "Waiting to connect..."
        text2.text = "If you can't connect:\n1. Enable wifi\n2. Start desktop application"
//        speechSettings.visible = true
        mainRect.visible = true
        settingsButton.visible = true
    }

    function settingsStateEntered() {
        speechSettings.visible = true
        mainRect.visible = false
    }

    function settingsStateExited() {
        console.log("settingsState exited")
        speechSettings.visible = false
    }

    function showInfoStateEntered() {
        timer.repeat = false
        timer.stop()
        secondsElapsed = 0
        mainRect.color = "white"
        settingsButton.visible = true
        mainRect.visible = true
//        text.text = ""
//        text2.text = ""
        text.text = qsTr("Connected to\n") + chat.getCurrentClient()
        text2.text = "";
        timer.start()
    }

    function showInfoStateExited() {
        console.log("Show info state exited")
        timer.repeat = false
        timer.stop()
    }

    function connectedStateEntered() {
        mainRect.color = "black"
        settingsButton.visible = false
        text.text = ""
        text2.text = ""

        //timer2.start()
    }
}
