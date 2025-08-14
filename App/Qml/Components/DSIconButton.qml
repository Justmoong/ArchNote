// DSIconButton.qml (QML)
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ArchNote 1.0  // KSvgIcon

Button {
    id: control

    // 외부에서 전달할 아이콘 URL (qrc:/, :/, file:/ 모두 가능)
    property url iconSource: ""
    // 옵션: SVG 내부 특정 요소 ID를 지정해서 부분 렌더링
    property string svgElementId: ""
    // 아이콘 크기
    property int iconSize: 20
    // 좌우 패딩
    padding: 6

    implicitWidth: iconSize
    implicitHeight: iconSize

    // 아이콘만 있는 버튼으로 가정. 텍스트가 있다면 Row로 확장 가능.
    contentItem: Item {
        implicitWidth: iconSize
        implicitHeight: iconSize

        // 간단한 확장: SVG 여부 판단
        readonly property bool isSvg: {
            const s = String(control.iconSource).toLowerCase()
            return s.endsWith(".svg") || s.endsWith(".svgz")
        }

        Loader {
            id: iconLoader
            anchors.centerIn: parent
            width: control.iconSize
            height: control.iconSize
            sourceComponent: isSvg ? svgComp : rasterComp
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

//사용 방법
// DSIconButton {
//     iconSource: "qrc:/icons/zoom_in.svg"
//     iconSize: 22
//     onClicked: console.log("clicked")
// }
