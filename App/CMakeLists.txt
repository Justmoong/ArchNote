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
)

qt_import_qml_plugins(ArchNote)

if(APPLE)
    target_sources(ArchNote PRIVATE
            MacTitleBarTransparent.mm
            MacTitleBarTransparent.h
    )
endif()
