import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {

    Rectangle {
        id: mainWindow
        anchors.fill: parent
        color: "#323232"

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

                Sidebar {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
