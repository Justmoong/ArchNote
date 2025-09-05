import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import View 1.0
import Components 1.0
import ArchNote 1.0

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    visible: true
    minimumWidth: 720
    minimumHeight: 480

    // Material Design 테마 설정
    Material.theme: Material.Dark
    Material.primary: Material.Blue
    Material.accent: Material.Orange

    // 햄버거 메뉴 드로어
    property alias drawer: drawer

    Drawer {
        id: drawer
        width: Math.min(window.width * 0.8, 300)
        height: window.height
        modal: true

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 8

            Label {
                text: qsTr("ArchNote")
                font.pointSize: 18
                font.bold: true
                color: Material.primaryTextColor
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Material.dividerColor
            }

            ItemDelegate {
                width: parent.width
                text: qsTr("📚 Library")
                Material.foreground: Material.primaryTextColor
                onClicked: {
                    drawer.close()
                }
            }

            ItemDelegate {
                width: parent.width
                text: qsTr("🚀 Projects")
                Material.foreground: Material.primaryTextColor
                onClicked: {
                    drawer.close()
                }
            }

            ItemDelegate {
                width: parent.width
                text: qsTr("📦 Archive")
                Material.foreground: Material.primaryTextColor
                onClicked: {
                    drawer.close()
                }
            }

            ItemDelegate {
                width: parent.width
                text: qsTr("🔖 Bookmarks")
                Material.foreground: Material.primaryTextColor
                onClicked: {
                    drawer.close()
                }
            }
        }
    }

    // 헤더바
    header: ToolBar {
        Material.primary: Material.Blue
        
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: "☰"
                font.pointSize: 16
                onClicked: drawer.open()
            }

            Label {
                text: qsTr("ArchNote")
                font.pointSize: 16
                font.bold: true
                Layout.fillWidth: true
            }
        }
    }

    // 메인 컨텐츠 영역
    ContentsView {
        anchors.fill: parent
    }
}
