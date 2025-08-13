qt_add_executable(ArchNote
        main.cpp
)

if (APPLE)
    target_sources(ArchNote PRIVATE
            SvgIconItem.cpp
            SvgIconItem.h
    )
endif ()

add_subdirectory(Qml)

find_package (KF6 6.0 REQUIRED COMPONENTS Svg)

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
