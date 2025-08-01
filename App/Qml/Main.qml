import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import View

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    visible: true
    minimumWidth: 720
    minimumHeight: 480


    Rectangle {
        id: titleBar
        width: parent.width
        height: 40
        color: "transparent"

        MouseArea {
            id: dragArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property bool dragging: false

            onPressed: dragging = true
            onReleased: dragging = false

            onPositionChanged: {
                if (dragging) {
                    window.startSystemMove()
                    dragging = false
                }
            }
        }
    }

    Rectangle {
        id: windowBackground
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: '#373737'

        ContentsView {
            anchors.fill: parent

        }
    }
}
