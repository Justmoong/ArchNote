qt_add_executable(ArchNote
        main.cpp
)

if (APPLE)
    target_sources(ArchNote PRIVATE
            MacTitleBarTransparent.h
            MacTitleBarTransparent.mm
    )
endif ()

add_subdirectory(Qml)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Qml
        Qt6::QuickControls2
        ArchNoteAppQml
        ArchNoteAppQmlView
        ArchNoteAppQmlComponents
)

qt_import_qml_plugins(ArchNote)
