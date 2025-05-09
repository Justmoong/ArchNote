add_subdirectory(View)

file(GLOB_RECURSE QML_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")
qt_add_qml_module(ArchNoteAppQml
        URI Qml
        VERSION 1.0
        QML_FILES
        ${QML_SOURCES}
)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
)