cmake_minimum_required(VERSION 3.31)
project(ArchNote)

set(CMAKE_PREFIX_PATH "$HOME/Qt-6.8.3-static-install")
set(QT_BUILD_SHARED_LIBS OFF)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build static libs" FORCE)

message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml)

qt_standard_project_setup(REQUIRES 6.8)

add_subdirectory(App)
add_subdirectory(Test EXCLUDE_FROM_ALL)

set_target_properties(ArchNote PROPERTIES
        MACOSX_BUNDLE TRUE
#        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_SOURCE_DIR}/App/Info.plist"
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

target_link_libraries(ArchNote PRIVATE Qt6::Core Qt6::Gui Qt6::Quick)

enable_testing()