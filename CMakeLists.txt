cmake_minimum_required(VERSION 3.31)
project(ArchNote)

set(CMAKE_PREFIX_PATH "/Users/ymy/Qt/6.8.3/macos")
message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

find_package(Qt6 COMPONENTS
        Core
        Gui
        Widgets
        Quick
        REQUIRED)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(ArchNoteApp
    App/main.cpp
)

qt_add_qml_module(ArchNoteApp
    URI ArchNote
    VERSION 1.0
    QML_FILES
        App/qml/Main.qml
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

target_link_libraries(ArchNoteApp PRIVATE Qt6::Core Qt6::Gui Qt6::Quick)