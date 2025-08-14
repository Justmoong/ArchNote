import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import View
import Components

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    visible: true
    minimumWidth: 720
    minimumHeight: 480

    // macOS 상단 투명 처리를 위해 창 클리어 컬러를 투명으로
    color: "transparent"

    // 상단 드래그/버튼 영역: header를 사용
    header: Rectangle {
        id: titleBar
        height: 40
        color: "#373737"

        // 필요시 좌측 상단에 앱 버튼/탭 등을 배치
        // Row { anchors.fill: parent; ... }

        MouseArea {
            id: dragArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            hoverEnabled: false
            // 드래그는 onPressed에서 즉시 시작하는 것이 안정적
            onPressed: {
                if (mouse.button === Qt.LeftButton) {
                    window.startSystemMove()
                }
            }
            // 더블클릭 동작을 커스텀으로 넣고 싶다면 여기서 처리
            // onDoubleClicked: { /* 필요 시 최대화/복원 등 */ }
        }
    }

    // 배경은 전체로 깔고, 상단은 투명 header가 덮는 구조
    Rectangle {
        id: windowBackground
        anchors.fill: parent
        color: "#373737"

        ContentsView {
            anchors.fill: parent
        }
    }
}