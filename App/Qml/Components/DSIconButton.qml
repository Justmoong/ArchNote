import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: dsIconButton

    property url source
    property bool isActive: false

    width: 30
    height: 30
    hoverEnabled: true

    contentItem: Image {
        id: iconImage
        source: dsIconButton.source
        width: 24
        height: 24
        anchors.centerIn: parent
    }

    background: Rectangle {
        radius: 4
        color: {
            if (dsIconButton.isActive) return "#1565c0"
            if (!dsIconButton.enabled) return "transparent"
            return "transparent"
        }
        border.color: dsIconButton.focus ? "#1565C0" : "transparent"
        border.width: dsIconButton.focus ? 2 : 0
    }

    ToolTip {
        id: dsToolTip
        visible: dsIconButton.hovered && dsToolTip.text !== ""
        delay: 500
    }

    property alias tooltipText: dsToolTip.text
}

//usage example
// DSIconButton {
//     "qrc:/Icons/library@3x.png"
//     isActive: currentKey === "library"
//     onClicked: {
//         currentKey = "library"
//         librarySelected()
//     }
// }