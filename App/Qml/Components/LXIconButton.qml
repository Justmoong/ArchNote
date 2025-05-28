import QtQuick 2.15
import QtQuick.Controls 2.15
import QtSvg 1.15

Rectangle {
    id: iconButton
    width: icon.implicitWidth + padding * 2
    height: icon.implicitHeight + padding * 2
    radius: 6

    property int mode: 0
    readonly property var modes: ["Normal", "Accent", "Warning", "Disabled"]
    property bool enabled: mode !== 3
    property url source: ""          // 사용자 설정 SVG 경로
    readonly property int iconSize: 20
    property int padding: 6

    signal clicked()

    color: {
        if (mode === 3) return "#BDBDBD"
        if (mouseArea.pressed) {
            switch (mode) {
                case 0:
                    return "#C0C0C0"
                case 1:
                    return "#3074D2"
                case 2:
                    return "#E08C00"
                default:
                    return "#E0E0E0"
            }
        }
        if (mouseArea.containsMouse) {
            switch (mode) {
                case 0:
                    return "#D6D6D6"
                case 1:
                    return "#3A7FE6"
                case 2:
                    return "#F09600"
                default:
                    return "#E0E0E0"
            }
        }
        switch (mode) {
            case 0:
                return "#E0E0E0"
            case 1:
                return "#448AFF"
            case 2:
                return "#FFA000"
            default:
                return "#E0E0E0"
        }
    }

    // SVG 아이콘 또는 Placeholder
    Item {
        id: iconContainer
        width: iconSize
        height: iconSize
        anchors.centerIn: parent

        SvgImage {
            id: icon
            visible: source !== ""
            anchors.fill: parent
            iconButton.source
            color: (mode === 3) ? "#757575" : "black"
        }

        Rectangle {
            visible: source === ""
            anchors.fill: parent
            radius: 3
            color: "#999999"

            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.strokeStyle = "#ffffff"
                    ctx.lineWidth = 2
                    ctx.beginPath()
                    ctx.moveTo(4, 4)
                    ctx.lineTo(width - 4, height - 4)
                    ctx.moveTo(width - 4, 4)
                    ctx.lineTo(4, height - 4)
                    ctx.stroke()
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: iconButton.enabled

        onClicked: iconButton.clicked()
    }
}

// Usage Example
// DSIconButton {
//     source: "qrc:/icons/save.svg"
//     iconSize: 24
//     mode: 1
//     onClicked: console.log("Save icon clicked")
// }