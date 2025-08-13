cmake_minimum_required (VERSION 3.24)
project(ArchNote)

project (ArchNote LANGUAGES C CXX)

message (STATUS "SYSROOT=${CMAKE_OSX_SYSROOT}")

set (_sdk_gl "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/OpenGL.framework/Headers/gl.h")
if (EXISTS "${_sdk_gl}")
    message (STATUS "OpenGL.h in SDK: YES -> ${_sdk_gl}")
else ()
    message (STATUS "OpenGL.h in SDK: NO")
endif ()

message (STATUS "GL.h exists? " $<BOOL:$ENV{SDK_GL_H_EXISTS}>)

set (CMAKE_FIND_FRAMEWORK FIRST)
list (PREPEND CMAKE_SYSTEM_FRAMEWORK_PATH
        "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks"
        "${CMAKE_OSX_SYSROOT}/Library/Frameworks")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/bin")

set (CMAKE_DISABLE_FIND_PACKAGE_OpenGL ON)
set (OPENGL_LIBRARIES "-framework OpenGL" CACHE STRING "" FORCE)
set (OPENGL_gl_LIBRARY "-framework OpenGL" CACHE STRING "" FORCE)
set (OPENGL_opengl_LIBRARY "-framework OpenGL" CACHE STRING "" FORCE)
set (OPENGL_INCLUDE_DIR "" CACHE PATH "" FORCE)

set (CMAKE_DISABLE_FIND_PACKAGE_WrapOpenGL ON)
add_library (WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
target_link_libraries (WrapOpenGL::WrapOpenGL INTERFACE "-framework OpenGL")
set (WrapOpenGL_FOUND TRUE)

message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

find_package (ECM REQUIRED NO_MODULE)
set (CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(Qt6 REQUIRED COMPONENTS
        Core
        Gui
        Quick
        Qml
        QuickControls2
        QuickTemplates2
        QuickLayouts
)

find_package (KF6 REQUIRED COMPONENTS
        CoreAddons
        I18n
        Config
        Svg
)

qt_standard_project_setup(REQUIRES 6.8)
set (CMAKE_DISABLE_FIND_PACKAGE_OpenGL ON)

add_subdirectory(App)
add_subdirectory(Test EXCLUDE_FROM_ALL)

if (APPLE)
    set_target_properties(ArchNote PROPERTIES
            MACOSX_BUNDLE TRUE
    )
elseif (WIN32)
    set_target_properties(ArchNote PROPERTIES
            WIN32_EXECUTABLE TRUE
    )
elseif (UNIX)
    set_target_properties(ArchNote PROPERTIES
            OUTPUT_NAME "Arch Note"
    )
endif ()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::QuickTemplates2
        Qt6::QuickLayouts
)

target_link_libraries (ArchNote PRIVATE
        KF6::Svg
)

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

enable_testing()

