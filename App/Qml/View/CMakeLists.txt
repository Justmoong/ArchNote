qt6_add_qml_module(ArchNoteAppQmlView
        URI ArchNote.View
        VERSION 1.0
        TARGET_PATH View
        STATIC
        QML_FILES
        ContentsView.qml
)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
)