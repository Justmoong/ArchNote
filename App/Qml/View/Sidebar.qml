import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts

Rectangle {
    color: "transparent"

    property var libraryModel: ["My Notes", "Work Documents", "Personal"]
    property var projectsModel: ["ArchNote", "Web Project", "Mobile App"]
    property var bookmarksModel: ["Important Links", "References", "Resources"]
    property var rssModel: ["Tech News", "Design Blogs", "Development"]
    property var archiveModel: ["Old Projects", "Archived Notes", "Backups"]
    property var checklistModel: ["Daily Tasks", "Shopping List", "To-Do"]

    property var currentModel: libraryModel
    property string currentCategory: "Library"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Material Design 카테고리 카드
        Pane {
            Layout.fillWidth: true
            Layout.preferredHeight: 220
            Layout.margins: 8
            Material.elevation: 2

            ColumnLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Categories")
                    font.pointSize: 14
                    font.bold: true
                    Material.foreground: Material.primaryTextColor
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ListView {
                        model: [
                            {name: qsTr("📚 Library"), data: libraryModel},
                            {name: qsTr("🚀 Projects"), data: projectsModel},
                            {name: qsTr("🔖 Bookmarks"), data: bookmarksModel},
                            {name: qsTr("📦 Archive"), data: archiveModel},
                            {name: qsTr("✅ Checklist"), data: checklistModel}
                        ]
                        spacing: 4

                        delegate: ItemDelegate {
                            width: ListView.view.width
                            text: modelData.name
                            Material.foreground: Material.primaryTextColor

                            onClicked: {
                                currentModel = modelData.data
                                currentCategory = modelData.name
                            }
                        }
                    }
                }
            }
        }

        // Material Design 아이템 목록 카드
        Pane {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 8
            Material.elevation: 2

            ColumnLayout {
                anchors.fill: parent

                Label {
                    text: currentCategory
                    font.pointSize: 12
                    font.bold: true
                    Material.foreground: Material.primaryTextColor
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ListView {
                        model: currentModel
                        spacing: 2

                        delegate: ItemDelegate {
                            width: ListView.view.width
                            text: "📄 " + modelData
                            Material.foreground: Material.primaryTextColor

                            onClicked: {
                                console.log("Selected:", modelData)
                            }
                        }
                    }
                }
            }
        }
    }
}