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
    signal connected()
    signal disconnected()
    signal showInfo()
    signal hideInfo()

    property int secondsElapsed: 0

    States {
    }

    Connections {
        target: chat
        function onConnected() {
            console.log("connected")
            connected()
        }
    }

    Connections {
        target: chat
        function onDisconnected() {
            console.log("disconnected")
            disconnected()
        }
    }

    Rectangle {
        id: mainRect
        anchors.fill: parent
    }

    Text {
        id: text
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height / 2
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
        height: parent.height / 2
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
            showInfo()
            console.log("mousearea pressed")
        }
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
                mainRect.color = "white"
                text.text = qsTr("Connected to\n")
                        + chat.getCurrentClient()
                text2.text = qsTr("The screen will turn off in ") + (10 - secondsElapsed)
                timer.repeat = true
                timer.start()
            }
        }
    }

    Timer {
        id: timer2
        interval: 10000
        onTriggered: hideInfo()
    }

    function setInitialState() {
        timer.repeat = false
        timer.stop()
        secondsElapsed = 0
        mainRect.color = "white"
        text.text = "Waiting to connect..."
        text2.text = "If you can't connect:\n1. Enable wifi\n2. Start desktop application"
    }

    function setCountDownState() {
        timer.start()
    }

    function setConnectedState() {
        timer.repeat = false
        timer.stop()
        secondsElapsed = 0
        mainRect.color = "black"
        text.text = ""
        text2.text = ""
    }

    function setShowInfoState() {
        mainRect.color = "white"
        text.text = chat.getNickName() + "\n\n"
                + qsTr("Connected to\n")
                + chat.getCurrentClient()
        text2.text = "";

        timer2.start()
    }
}
