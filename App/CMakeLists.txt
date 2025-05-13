qt_add_executable(ArchNote
        main.cpp
)

add_subdirectory(Qml)
add_subdirectory (File)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        ArchNoteAppQml
)

target_sources (ArchNote PRIVATE
        main.cpp
        MacTitleBarTransparent.mm
        MacTitleBarTransparent.h
)

qt_import_qml_plugins(ArchNote)