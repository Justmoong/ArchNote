import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    color: "transparent"

    property var libraryModel: ["lib 1", "lib 2", "lib 3"]
    property var projectsModel: ["proj 1", "proj 2", "proj 3"]
    property var bookmarksModel: ["bookmark 1", "bookmark 2", "bookmark 3"]

    property var currentModel: libraryModel

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        SidebarNavigation {
            onLibrarySelected: currentModel = libraryModel
            onProjectsSelected: currentModel = projectsModel
            onBookmarksSelected: currentModel = bookmarksModel
            onRssSelected: currentModel = rssModel
            onArchiveSelected: currentModel = archiveModel
            onChecklistSelected: currentModel = checklistModel
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                model: currentModel

                delegate: Text {
                    text: modelData
                    font.pixelSize: 13
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}