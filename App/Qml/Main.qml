import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    visible: true

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

    ContentsView {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}