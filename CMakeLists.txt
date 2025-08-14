cmake_minimum_required(VERSION 3.24)
project(ArchNote LANGUAGES C CXX)

# 빌드 출력 디렉토리 설정
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# C++ 표준 설정
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt 자동화 도구 설정
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# OpenGL 완전 비활성화
set(CMAKE_DISABLE_FIND_PACKAGE_OpenGL ON)
set(QT_FEATURE_opengl OFF)

# Qt 설치 경로 설정
if(UNIX AND NOT APPLE)
    # 시스템 Qt 경로 제거
    list(REMOVE_ITEM CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake")
    list(REMOVE_ITEM CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake/Qt6")

    # 홈 디렉토리의 Qt 찾기
    set(QT_DIR "$ENV{HOME}/Qt")
    file(GLOB QT_VERSIONS "${QT_DIR}/6.*/gcc_64")
    if(QT_VERSIONS)
        list(SORT QT_VERSIONS)
        list(REVERSE QT_VERSIONS)
        list(GET QT_VERSIONS 0 QT_VERSION_PATH)
        set(CMAKE_PREFIX_PATH "${QT_VERSION_PATH}" CACHE PATH "Qt installation path" FORCE)
        message(STATUS "Using Qt from: ${QT_VERSION_PATH}")
    else()
        message(FATAL_ERROR "Qt not found in ${QT_DIR}. Please install Qt in your home directory.")
    endif()
elseif(APPLE)
    set(CMAKE_FIND_FRAMEWORK FIRST)
    list(PREPEND CMAKE_SYSTEM_FRAMEWORK_PATH
            "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks"
            "${CMAKE_OSX_SYSROOT}/Library/Frameworks"
    )
endif()

# 패키지 찾기
find_package(Qt6 REQUIRED COMPONENTS
        Core
        Gui
        Quick
        Qml
        QuickControls2
)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF6 REQUIRED COMPONENTS
        CoreAddons
        I18n
        Config
        Svg
)

# Qt 프로젝트 설정
qt_standard_project_setup(REQUIRES 6.5)

# 서브디렉토리 추가
add_subdirectory(App)
add_subdirectory(Test EXCLUDE_FROM_ALL)

# 링크 라이브러리
target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Qml
        Qt6::QuickControls2
        KF6::Svg
)

# 리소스 추가
file(GLOB ICON_FILES "${CMAKE_CURRENT_SOURCE_DIR}/Resources/Icons/*.png")
if(ICON_FILES)
    qt_add_resources(ArchNote "resources"
            PREFIX "/Icons"
            BASE "Resources/Icons"
            FILES ${ICON_FILES}
    )
endif()

# 플랫폼별 실행파일 속성 설정
if(APPLE)
    set_target_properties(ArchNote PROPERTIES
            MACOSX_BUNDLE TRUE
    )
elseif(WIN32)
    set_target_properties(ArchNote PROPERTIES
            WIN32_EXECUTABLE TRUE
    )
elseif(UNIX)
    set_target_properties(ArchNote PROPERTIES
            OUTPUT_NAME "ArchNote"
    )
endif()

# 테스트 활성화
enable_testing()