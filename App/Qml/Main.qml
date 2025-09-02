import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import View
import Components
import ArchNote 1.0

ApplicationWindow {
    id: window
    title: "Arch Note"
    width: 1440
    height: 900
    visible: true
    minimumWidth: 720
    minimumHeight: 480

    color: "transparent"

    header: Rectangle {
        id: titleBar
        height: 40
        color: "transparent"


        MouseArea {
            id: dragArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            hoverEnabled: false
            onPressed: {
                if (mouse.button === Qt.LeftButton) {
                    window.startSystemMove()
                }
            }
        }
    }

    // 배경은 전체로 깔고, 상단은 투명 header가 덮는 구조
    Rectangle {
        id: windowBackground
        anchors.fill: parent
        color: "#373737"

        ContentsView {
            anchors.fill: parent
        }
    }
}