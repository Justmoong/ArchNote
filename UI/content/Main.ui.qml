

/*
This is a UI file (.ui.TestQml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.TestQml files.
*/
import QtQuick
import QtQuick.Controls
import UI
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
            }

            ColumnLayout {
                id: centerView
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 600
                Layout.minimumWidth: 400

                //                NotePadView {
                //                }
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
