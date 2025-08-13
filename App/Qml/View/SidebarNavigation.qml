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
            iconSource: "qrc:/icons/library.svg"
            iconSize: 22
            onClicked: {
                currentKey = "library"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/project.svg"
            iconSize: 22
            onClicked: {
                currentKey = "project"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/bookmark.svg"
            iconSize: 22
            onClicked: {
                currentKey = "bookmark"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/rss.svg"
            iconSize: 22
            onClicked: {
                currentKey = "rss"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/checklist.svg"
            iconSize: 22
            onClicked: {
                currentKey = "checklist"
                librarySelected()
            }
        }

        DSIconButton {
            iconSource: "qrc:/icons/archive.svg"
            iconSize: 22
            onClicked: {
                currentKey = "archive"
                librarySelected()
            }
        }


    }
}

// DSIconButton {
//     iconSource: "qrc:/icons/zoom_in.svg"
//     iconSize: 22
//     onClicked: console.log("clicked")
// }
