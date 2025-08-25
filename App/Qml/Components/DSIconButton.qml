// DSIconButton.qml (QML)
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ArchNote 1.0  // KSvgIcon

Button {
    id: control

    property url iconSource: ""
    property string svgElementId: ""
    property int iconSize: 24
    background: Rectangle {
        color: "transparent"     // 배경 투명
        border.width: 0          // 보더 제거
        radius: 0
    }
    padding: 8

    implicitWidth: iconSize
    implicitHeight: iconSize

    contentItem: Item {
        id: contentRoot
        implicitWidth: iconSize
        implicitHeight: iconSize

        readonly property bool isSvg: {
            const s = String(control.iconSource).toLowerCase()
            return s.endsWith(".svg") || s.endsWith(".svgz")
        }

        Loader {
            id: iconLoader
            anchors.centerIn: parent
            width: control.iconSize
            height: control.iconSize
            // 스코프를 명시적으로 지정
            sourceComponent: contentRoot.isSvg ? svgComp : rasterComp
        }

        Component {
            id: svgComp
            KSvgIcon {
                source: control.iconSource
                elementId: control.svgElementId
                width: iconLoader.width
                height: iconLoader.height
                smooth: true
            }
        }

        Component {
            id: rasterComp
            Image {
                source: control.iconSource
                sourceSize.width: iconLoader.width
                sourceSize.height: iconLoader.height
                width: iconLoader.width
                height: iconLoader.height
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                smooth: true
            }
        }
    }
}