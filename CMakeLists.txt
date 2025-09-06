cmake_minimum_required(VERSION 3.24)
project(ArchNote LANGUAGES C CXX)


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

# 패키지 찾기
find_package (Qt6 6.0 REQUIRED COMPONENTS
        Core
        Gui
        Quick
        Qml
        QuickControls2
        Svg
)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

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
        KF6::Svg
        KF6::I18n
        KF6::Kirigami
        KF6::KirigamiAddons
)

# 리소스 추가
file (GLOB ICON_FILES "App/icons/*.svg")
if (ICON_FILES)
    qt_add_resources (ArchNote "resources"
            PREFIX "/Icons"
            BASE "App/icons"
            FILES ${ICON_FILES}
    )
endif ()

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

# 테스트 활성화
enable_testing()