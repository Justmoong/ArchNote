import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    Layout.preferredHeight: 30
    Layout.fillWidth: true

    signal selectLibrary()

    signal selectProjects()

    signal selectBookmarks()

    signal selectRSS()

    signal selectArchive()

    signal selectTrash()

    RowLayout {
        spacing: 12
        anchors.margins: 12
        anchors.top: parent.top
        anchors.left: parent.left

        DSIconButton {
            source: "qrc:/icons/library.svg"
            elementId: "layer1"              // 아이콘 내부 구조에 맞게 조정
            iconSize: 24
            accessibleName: "Library"
            onClicked: contentModel = libraryModel
        }

        DSIconButton {
            source: "qrc:/icons/projects.svg"
            accessibleName: "Projects"
            onClicked: contentModel = projectsModel
        }

        DSIconButton {
            source: "qrc:/icons/bookmark.svg"
            accessibleName: "Bookmarks"
            onClicked: contentModel = bookmarksModel
        }

        DSIconButton {
            source: "qrc:/icons/rss.svg"
            accessibleName: "RSS"
            onClicked: contentModel = rssModel
        }

        DSIconButton {
            source: "qrc:/icons/archive.svg"
            accessibleName: "Archive"
            onClicked: contentModel = archiveModel
        }

        DSIconButton {
            source: "qrc:/icons/trash.svg"
            accessibleName: "Trash"
            onClicked: contentModel = trashModel
        }
    }
}