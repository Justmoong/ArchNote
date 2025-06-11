import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    Layout.preferredHeight: 30
    Layout.fillWidth: true

    signal librarySelected()

    signal projectsSelected()

    signal bookmarksSelected()

    signal rssSelected()

    signal archiveSelected()

    signal checklistSelected()

    property var currentKey: "library" // 예시: 활성화 표시용

    RowLayout {
        spacing: 4
        anchors.margins: 8
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        DSIconButton {
            "qrc:/Icons/library@3x.png"
            isActive: currentKey === "library"
            onClicked: {
                currentKey = "library"
                librarySelected()
            }
        }

        DSIconButton {
            "qrc:/Icons/projects@3x.png"
            isActive: currentKey === "projects"
            onClicked: {
                currentKey = "projects"
                projectsSelected()
            }
        }

        DSIconButton {
            "qrc:/Icons/checklist@3x.png"
            isActive: currentKey === "checklist"
            onClicked: {
                currentKey = "checklist"
                checklistSelected()
            }
        }

        DSIconButton {
            "qrc:/Icons/bookmark@3x.png"
            isActive: currentKey === "bookmarks"
            onClicked: {
                currentKey = "bookmarks"
                bookmarksSelected()
            }
        }

        DSIconButton {
            "qrc:/Icons/rss@3x.png"
            isActive: currentKey === "rss"
            onClicked: {
                currentKey = "rss"
                rssSelected()
            }
        }

        DSIconButton {
            "qrc:/Icons/archive@3x.png"
            isActive: currentKey === "archive"
            onClicked: {
                currentKey = "archive"
                archiveSelected()
            }
        }


    }
}