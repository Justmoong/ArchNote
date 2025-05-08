

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import UI

Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    Column {
        id: column
        width: mainWindow.width
        height: mainWindow.height

        Row {
            id: navigationBar
            width: column.width
            height: 50

            Rectangle {
                id: navigationBarBackground
                width: navigationBar.width
                height: navigationBar.height
                color: "#7c7b7b"
            }
        }
    }
}
