import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    TextArea {
        anchors.fill: parent
        placeholderText: "Enter your text here"
        wrapMode: TextEdit.Wrap

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton

        }
    }
}