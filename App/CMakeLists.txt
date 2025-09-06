# (필요 시) Qt Svg 모듈 찾기
find_package (Qt6 COMPONENTS Svg REQUIRED)

# 실행 파일
qt_add_executable(ArchNote
        main.cpp
)

if (APPLE)
    target_sources(ArchNote PRIVATE

    )
endif ()

add_subdirectory(Qml)

find_package (KF6 6.0 REQUIRED COMPONENTS Svg)

## 기준 경로 고정
#set (APP_DIR "${CMAKE_CURRENT_LIST_DIR}")
#set (ICON_DIR "${APP_DIR}/icons")
#

# QRC를 실제로 타깃에 포함 (App/resources.qrc가 icons/*를 참조)
qt_add_resources (ArchNote "app_icons"
        FILES
        resources.qrc
)
