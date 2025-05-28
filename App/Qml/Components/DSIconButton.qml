import QtQuick 2.15
import QtQuick.Controls 2.15
import DSSvg

Button {
    id: dsIconButton
    property url source: ""
    property string elementId: "layer1"
    property int iconSize: 20

    accessible.name: text
    implicitWidth: iconSize + leftPadding + rightPadding
    implicitHeight: iconSize + topPadding + bottomPadding
    padding: 6
    focusPolicy: Qt.StrongFocus

    contentItem: Item {
        width: iconSize
        height: iconSize
        anchors.centerIn: parent

        DSSvgItem {
            anchors.fill: parent
            source: iconButton.source
            elementId: iconButton.elementId
            color: iconButton.enabled ? "black" : "#757575"
            visible: source !== ""
        }

        Rectangle {
            visible: source === ""
            anchors.fill: parent
            radius: 3
            color: "#999999"
        }
    }

    background: Rectangle {
        radius: 6
        color: {
            if (!enabled) return "#BDBDBD"
            if (iconButton.down) {
                return "#C0C0C0"
            } else if (iconButton.hovered) {
                return "#D6D6D6"
            } else {
                return "#E0E0E0"
            }
        }

        border.color: iconButton.focus ? "#1565C0" : "transparent"
        border.width: iconButton.focus ? 2 : 0
    }

    ToolTip.visible: hovered && text !== ""
    ToolTip.text: text
}

// Usage Example
// DSIconButton {
//     source: "qrc:/icons/save.svg"
//     iconSize: 24
//     mode: 1
//     onClicked: console.log("Save icon clicked")
// }