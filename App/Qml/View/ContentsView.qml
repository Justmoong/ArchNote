import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {

    Rectangle {
        id: mainWindow
        anchors.fill: parent

        RowLayout {
            id: windowLayout
            anchors.fill: parent

            spacing: 0

            ColumnLayout {
                id: sideBarView
                Layout.fillHeight: true
                Layout.preferredWidth: 200
                Layout.minimumWidth: 100
                Layout.maximumWidth: 600

                LXButton {
                    mode: 1
                    labelText: "Hello World!"

                }
            }

            ColumnLayout {
                id: centerView
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 600
                Layout.minimumWidth: 400

                NotePadView {

                }

            }

            ColumnLayout {
                id: propertiesBarView
                Layout.fillHeight: true
                Layout.preferredWidth: 200
                Layout.minimumWidth: 100
                Layout.maximumWidth: 600
            }
        }
    }
}
