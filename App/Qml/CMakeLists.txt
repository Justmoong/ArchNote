add_subdirectory(View)
add_subdirectory (Components)

file(GLOB_RECURSE QML_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")
qt_add_qml_module(ArchNoteAppQml
        URI Qml
        VERSION 1.0
        RESOURCE_PREFIX "/"
        QML_FILES
        ${QML_SOURCES}
)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
)

set(qml_dest "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/qml")
set_target_properties(ArchNoteAppQml PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY  "${qml_dest}"
    RUNTIME_OUTPUT_DIRECTORY  "${qml_dest}"
)