file(GLOB_RECURSE QML_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")

qt_add_qml_module(ArchNoteAppQmlView
    URI View
    VERSION 1.0
    QML_FILES
        ${QML_SOURCES}
    DEPENDENCIES
        QtQuick
        QtQuick.Controls
        QtQuick.Dialogs
        org.kde.kirigami
)
