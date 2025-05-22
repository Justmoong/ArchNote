import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    color: "red"

    // 사전 정의된 두 개의 모델
    property var libraryModel: ["Doc 1", "Doc 2", "Doc 3"]

    // 현재 표시할 모델
    property var contentModel: libraryModel

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        SidebarNavigation {
            onSelectLibrary: contentModel = libraryModel
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "black"

            ListView {
                anchors.fill: parent
                model: contentModel

                delegate: Text {
                    text: modelData
                    color: "white"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}