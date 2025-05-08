add_subdirectory(View)

qt6_add_qml_module(ArchNoteAppQml
        URI ArchNote
        VERSION 1.0
        TARGET_PATH Qml
        STATIC
        QML_FILES
        Main.qml
        OUTPUT_TARGETS ArchNoteAppQmlPluginSources
)

add_library(ArchNoteAppQml STATIC $<TARGET_OBJECTS:ArchNoteAppQmlPluginSources>)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
)