import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    id: window
    height: 1080
    visible: true
    width: 800

    Rectangle {
        id: titleBar

        color: "transparent"
        height: 40
        width: parent.width

        MouseArea {
            id: dragArea

            anchors.fill: parent
            drag.target: null

            onPressed: {
                window.startSystemMove();
            }
        }
    }
    ContentsView {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
    }
}