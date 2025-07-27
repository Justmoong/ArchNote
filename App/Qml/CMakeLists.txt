add_subdirectory(View)
add_subdirectory(Components)

file(GLOB_RECURSE ALL_QML_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")

qt_add_qml_module(ArchNoteAppQml
        URI Qml
        VERSION 1.0
        QML_FILES
        ${ALL_QML_FILES}
        DEPENDENCIES
        View
        Components
)

qt_add_resources(ArchNote "qml_resources"
        PREFIX "/qml"
        FILES
        Main.qml
)

#target_link_libraries(ArchNote PRIVATE
#        Qt6::Core
#        Qt6::Gui
#        Qt6::Quick
#        ArchNoteAppQml
#        ArchNoteAppQmlView
#        ArchNoteAppQmlComponents
#)
#
#set(qml_dest "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Qml")
#set_target_properties(ArchNoteAppQml PROPERTIES
#        LIBRARY_OUTPUT_DIRECTORY "${qml_dest}"
#        RUNTIME_OUTPUT_DIRECTORY "${qml_dest}"
#)
#
## View와 Components 모듈도 같은 위치에 설정
#set_target_properties(ArchNoteAppQmlView PROPERTIES
#        LIBRARY_OUTPUT_DIRECTORY "${qml_dest}"
#        RUNTIME_OUTPUT_DIRECTORY "${qml_dest}"
#)

set_target_properties(ArchNoteAppQmlComponents PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY  "${qml_dest}"
    RUNTIME_OUTPUT_DIRECTORY  "${qml_dest}"
)