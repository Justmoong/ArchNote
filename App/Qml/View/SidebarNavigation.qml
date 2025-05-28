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


        DSButton {
            labelText: "Library"
            onClicked: selectLibrary()
        }

        DSButton {
            labelText: "Projects"
            onClicked: selectProjects()
        }

        DSButton {
            labelText: "Bookmarks"
            onClicked: selectBookmarks()
        }

        DSButton {
            labelText: "RSS"
            onClicked: selectRSS()
        }

        DSButton {
            labelText: "Archive"
            onClicked: selectArchive()
        }

        DSButton {
            labelText: "Trash"
            onClicked: selectTrash()
        }

    }

}