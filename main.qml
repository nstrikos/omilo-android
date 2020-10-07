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

    function setInitialState() {
        mainRect.color = "white"
    }

    function setConnectedState() {
        mainRect.color = "black"
    }
}
