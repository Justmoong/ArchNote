cmake_minimum_required(VERSION 3.31)
project(ArchNote)

set(CMAKE_PREFIX_PATH "$HOME/Qt-6.8.3-static-install")
set(QT_BUILD_SHARED_LIBS OFF)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build static libs" FORCE)

message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

find_package (Qt6 REQUIRED COMPONENTS Core Gui Quick Qml QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

add_subdirectory(App)
add_subdirectory(Test EXCLUDE_FROM_ALL)

set_target_properties(ArchNote PROPERTIES
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

target_link_libraries (ArchNote PRIVATE Qt6::Core Qt6::Gui Qt6::Quick Qt6::QuickControls2)
target_include_directories (ArchNote PRIVATE
        ${CMAKE_SOURCE_DIR}/lib
)

file(GLOB ICON_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/Resources/Icons/*.png"
)
qt_add_resources(ArchNote "resources"
        PREFIX "/Icons"
        BASE Resources/Icons
        FILES ${ICON_FILES}
)
qt_import_qml_plugins (ArchNote)

enable_testing()