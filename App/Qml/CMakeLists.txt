file(GLOB_RECURSE ALL_QML_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")

qt_add_resources (ArchNote "qml_resources"
        PREFIX "/qml"
        FILES
        Main.qml
        ContentsView.qml
)

qt_add_qml_module(ArchNoteAppQml
        URI Qml
        VERSION 1.0
        QML_FILES
        ${ALL_QML_FILES}
        DEPENDENCIES
)

