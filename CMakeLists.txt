cmake_minimum_required(VERSION 3.24)
project(ArchNote LANGUAGES C CXX)

set (QT_MIN_VERSION 6.6.0)
set (KF_MIN_VERSION 6.3.0)

message (STATUS "SYSROOT=${CMAKE_OSX_SYSROOT}")

# macOS에서 WrapOpenGL 탐색 우회
if(APPLE)
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

    set (CMAKE_DISABLE_FIND_PACKAGE_OpenGL ON)
    set (OPENGL_LIBRARIES "-framework OpenGL" CACHE STRING "" FORCE)
    set (OPENGL_gl_LIBRARY "-framework OpenGL" CACHE STRING "" FORCE)
    set (OPENGL_opengl_LIBRARY "-framework OpenGL" CACHE STRING "" FORCE)
    set (OPENGL_INCLUDE_DIR "" CACHE PATH "" FORCE)

    set (CMAKE_DISABLE_FIND_PACKAGE_WrapOpenGL ON)
    add_library (WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
    target_link_libraries (WrapOpenGL::WrapOpenGL INTERFACE "-framework OpenGL")
    set (WrapOpenGL_FOUND TRUE)
endif ()

set (APPLE_SUPPRESS_X11_WARNING ON)

# 패키지 찾기
find_package (Qt6 6.0 REQUIRED COMPONENTS
        Core
        Gui
        Quick
        Qml
        QuickControls2
        Svg
)

find_package (ECM ${KF_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include (KDEInstallDirs)
include (KDECompilerSettings)
include (KDECMakeSettings)
include (ECMQmlModule)

find_package(KF6 REQUIRED COMPONENTS
        CoreAddons
        I18n
        Config
        Svg
        Kirigami
        KirigamiAddons
)

# Qt 프로젝트 설정
qt_standard_project_setup (REQUIRES 6.0)
qt_policy (SET QTP0001 NEW)

# 서브디렉토리 추가
add_subdirectory(App)

# 링크 라이브러리
target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Qml
        Qt6::Svg
)

target_link_libraries (ArchNote PRIVATE
        KF6::CoreAddons
        KF6::Svg
        KF6::I18n
        KF6::Kirigami
        #        KF6::KirigamiAddons
)

# 플랫폼별 실행파일 속성 설정
if (APPLE)
    set_target_properties(ArchNote PROPERTIES
            MACOSX_BUNDLE TRUE
            MACOSX_BUNDLE_GUI_IDENTIFIER "com.iisacc.ArchNote"
            MACOSX_BUNDLE_BUNDLE_NAME "ArchNote"
    )

elseif (WIN32)
    set_target_properties (ArchNote PROPERTIES
            WIN32_EXECUTABLE TRUE
    )
endif()

# 개발 편의를 위한 QML import 경로(옵션)
option (ARCHNOTE_ENABLE_DEV_QML_IMPORTS "Enable extra dev QML import paths" OFF)
set (ARCHNOTE_DEV_QML_IMPORTS "" CACHE STRING "Semicolon-separated list of extra QML import paths.")
if (ARCHNOTE_ENABLE_DEV_QML_IMPORTS AND ARCHNOTE_DEV_QML_IMPORTS)
    target_compile_definitions (ArchNote PRIVATE ARCHNOTE_DEV_QML_IMPORTS="${ARCHNOTE_DEV_QML_IMPORTS}")
endif ()

# 테스트 활성화
enable_testing()

# Formatting and lint helpers (optional)
find_program (CLANG_FORMAT NAMES clang-format)
if (CLANG_FORMAT)
    file (GLOB_RECURSE CXX_SOURCES
            "${CMAKE_SOURCE_DIR}/*.h" "${CMAKE_SOURCE_DIR}/*.hpp" "${CMAKE_SOURCE_DIR}/*.cpp"
            "${CMAKE_SOURCE_DIR}/App/*.h" "${CMAKE_SOURCE_DIR}/App/*.hpp" "${CMAKE_SOURCE_DIR}/App/*.cpp")
    add_custom_target (format
            COMMAND ${CLANG_FORMAT} -i ${CXX_SOURCES}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Formatting C++ sources with clang-format")
endif ()

find_program (QMLLINT NAMES qmllint)
if (QMLLINT)
    add_custom_target (qml_lint
            COMMAND ${QMLLINT} --builtins --recursive "${CMAKE_SOURCE_DIR}/App/Qml"
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Linting QML with qmllint")
    add_custom_target (lint DEPENDS qml_lint)
endif ()

find_program (QMLFORMAT NAMES qmlformat)
if (QMLFORMAT)
    file (GLOB_RECURSE QML_SOURCES "${CMAKE_SOURCE_DIR}/App/Qml/*.qml")
    if (QML_SOURCES)
        if (TARGET format)
            add_custom_target (qml_format
                    COMMAND ${QMLFORMAT} -i ${QML_SOURCES}
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                    COMMENT "Formatting QML with qmlformat")
            add_dependencies (format qml_format)
        else ()
            add_custom_target (format
                    COMMAND ${QMLFORMAT} -i ${QML_SOURCES}
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                    COMMENT "Formatting QML with qmlformat")
        endif ()
    endif ()
endif ()
