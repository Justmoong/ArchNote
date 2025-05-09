add_executable(ArchNote
        main.cpp
)

add_subdirectory(Qml)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        ArchNoteAppQml
)
qt_import_qml_plugins(ArchNote)