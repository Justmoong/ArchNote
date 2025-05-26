import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    // 배경 처리
    color: "#202020"

    // 전체 레이아웃 설정
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // 상단 네비게이션
        Item {
            Layout.fillWidth: true
            height: 50

            RowLayout {
                id: sidebarNavigation
                anchors.fill: parent
                anchors.rightMargin: 0
                anchors.bottomMargin: 212
                anchors.leftMargin: 0
                anchors.topMargin: -212
                alignment: "AlignCenter"

                Text {
                    id: name
                    text: qsTr("text")
                }

                Text {
                    id: name2
                    text: qsTr("text")
                }

                Text {
                    id: name3
                    text: qsTr("text")
                }
            }
        }

        // 콘텐츠 리스트
        Rectangle {
            id: contentBackground
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0
            }
        }
    }

    // 모델 선언
    property var contentModel: ["Item A", "Item B", "Item C"]
}
