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
        id: sidebarNavigation
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        // spacing:     // 버튼 사이의 수평 간격(원하는 값으로 조정)


        LXButton {
            labelText: "Library"
            onClicked: selectLibrary()
        }

        LXButton {
            labelText: "Projects"
            onClicked: selectProjects()
        }

        LXButton {
            labelText: "Bookmarks"
            onClicked: selectBookmarks()
        }

        LXButton {
            labelText: "RSS"
            onClicked: selectRSS()
        }

        LXButton {
            labelText: "Archive"
            onClicked: selectArchive()
        }

        LXButton {
            labelText: "Trash"
            onClicked: selectTrash()
        }

    }

}