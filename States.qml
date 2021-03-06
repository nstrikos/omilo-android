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
                targetState: countDownState
                signal: window.connected
            }
            onEntered: {
                console.log("initial state")
                window.setInitialState()
                keepAwakeChecker.disable()
            }
        }
        DSM.State {
            id: countDownState
            DSM.SignalTransition {
                targetState: initialState
                signal: window.disconnected
            }
            DSM.SignalTransition {
                targetState: connectedState
                signal: window.countDownFinished
            }
            onEntered: {
                console.log("countdown state")
                window.setCountDownState()
            }
        }
        DSM.State {
            id: connectedState
            DSM.SignalTransition {
                targetState: initialState
                signal: window.disconnected
            }
            DSM.SignalTransition {
                targetState: showInfoState
                signal: window.showInfo
            }
            onEntered: {
                console.log("connected state")
                window.setConnectedState()
                keepAwakeChecker.enable()
            }
        }
        DSM.State {
            id: showInfoState
            DSM.SignalTransition {
                targetState: connectedState
                signal: window.hideInfo
            }
            DSM.SignalTransition {
                targetState: initialState
                signal: window.disconnected
            }
            onEntered: {
                console.log("showinfo state")
                window.setShowInfoState()
            }
        }
    }
}

