import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: lxButton
    width: buttonText.implicitWidth + 8
    height: 22
    radius: 6

    property int mode: 0 // 0: Normal, 1: Accent, 2: Warning, 3: Disabled
    readonly property var modes: ["Normal", "Accent", "Warning", "Disabled"]
    property bool enabled: mode !== 3
    property string labelText: "Button"

    signal clicked()

    color: {
        if (lxButton.mode === 3) { // Disabled
            return "#BDBDBD";
        }
        if (mouseArea.pressed) { // 클릭 상태
            switch (lxButton.mode) {
                case 0:
                    return "#C0C0C0";
                case 1:
                    return "#3074D2";
                case 2:
                    return "#E08C00";
                default:
                    return "#E0E0E0";
            }
        }
        if (mouseArea.containsMouse) { // 호버 상태
            switch (lxButton.mode) {
                case 0:
                    return "#D6D6D6";
                case 1:
                    return "#3A7FE6";
                case 2:
                    return "#F09600";
                default:
                    return "#E0E0E0";
            }
        }
        // 기본 상태
        switch (lxButton.mode) {
            case 0:
                return "#E0E0E0";
            case 1:
                return "#448AFF";
            case 2:
                return "#FFA000";
            default:
                return "#E0E0E0";
        }
    }

    Text {
        id: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        text: lxButton.labelText
        font.pixelSize: 12
        color: { // 텍스트 색상은 모드에 따라 결정
            if (lxButton.mode === 1) return "white"; // Accent 모드
            if (lxButton.mode === 3) return "#757575"; // Disabled 모드
            return "black"; // Normal, Warning 모드
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: lxButton.enabled
        hoverEnabled: true

        onClicked: {
            lxButton.clicked();
        }
    }
}