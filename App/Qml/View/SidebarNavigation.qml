import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import Components
import ArchNote 1.0

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
            iconSource: "qrc:/icons/library.svg"
            iconSize: 20
            onClicked: {
                currentKey = "library"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/project.svg"
            iconSize: 20
            onClicked: {
                currentKey = "project"
                projectsSelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/bookmark.svg"
            iconSize: 20
            onClicked: {
                currentKey = "bookmark"
                bookmarksSelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/rss.svg"
            iconSize: 20
            onClicked: {
                currentKey = "rss"
                rssSelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/checklist.svg"
            iconSize: 20
            onClicked: {
                currentKey = "checklist"
                checklistSelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/archive.svg"
            iconSize: 20
            onClicked: {
                currentKey = "archive"
                archiveSelected()
            }
        }


    }
}

// DSIconButton {
//     iconSource: "qrc:/icons/zoom_in.svg"
//     iconSize: 20
//     onClicked: console.log("clicked")
// }
