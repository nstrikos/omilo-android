import QtQuick 2.0

import QtQuick 2.15
import QtQuick.Window 2.15

import QtQml.StateMachine 1.15 as DSM

Item {
    DSM.StateMachine {
        id: stateMachine
        initialState: initialState
        running: true
        DSM.State {
            id: initialState
            DSM.SignalTransition {
                targetState: connectedState
                signal: window.connected
            }
            onEntered: {
                console.log("initial state")
            }
        }
        DSM.State {
            id: connectedState
            DSM.SignalTransition {
                targetState: initialState
                //signal: window.init
            }
            onEntered: {
                console.log("connected state")
                //window.showError(functionController.getError())
            }
        }
    }
}

