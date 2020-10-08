import QtQuick 2.15
import QtQuick.Window 2.15

import QtQml.StateMachine 1.15 as DSM

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Omilo android")

    signal connected()
    signal disconnected()
    signal showInfo()
    signal hideInfo()

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
        anchors.fill: parent
        font.family: "Helvetica"
        font.pointSize: 24
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
        id: timer
        interval: 10000
        onTriggered: hideInfo()
    }

    function setInitialState() {
        mainRect.color = "white"
        text.text = "Waiting to connect..."

    }

    function setConnectedState() {
        mainRect.color = "black"
        text.text = ""
    }

    function setShowInfoState() {
        mainRect.color = "white"
        text.text = chat.getNickName() + "\n\n"
                + qsTr("Connected to\n")
                + chat.getCurrentClient()

        timer.start()
    }
}
