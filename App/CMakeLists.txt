# (필요 시) Qt Svg 모듈 찾기
find_package (Qt6 COMPONENTS Svg REQUIRED)

# 실행 파일
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

# KF6 Svg는 계속 사용하되, QSvgRenderer 해결을 위해 Qt6::Svg도 함께 링크
find_package (KF6 6.0 REQUIRED COMPONENTS Svg)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Qml
        Qt6::QuickControls2
        Qt6::Svg          # 추가: QSvgRenderer 심볼 제공
        ArchNoteAppQml
        ArchNoteAppQmlView
        ArchNoteAppQmlComponents
)

# ------- 아이콘 존재 검사(치명도 완화) 및 리소스 연결 -------

# 기준 경로 고정
set (APP_DIR "${CMAKE_CURRENT_LIST_DIR}")
set (ICON_DIR "${APP_DIR}/icons")

# 존재 검사: 실패 시 빌드 중단 대신 경고만 출력
if (EXISTS "${ICON_DIR}/checklist.svg")
    message (STATUS "[ArchNote] checklist.svg FOUND at ${ICON_DIR}/checklist.svg")
else ()
    message (WARNING "[ArchNote] checklist.svg NOT FOUND at ${ICON_DIR}/checklist.svg")
    if (EXISTS "${ICON_DIR}")
        file (GLOB _ls_icons "${ICON_DIR}/*")
        message (STATUS "[ArchNote] ICON_DIR listing: ${_ls_icons}")
    endif ()
endif ()

# QRC를 실제로 타깃에 포함 (App/resources.qrc가 icons/*를 참조)
qt_add_resources (ArchNote "app_icons"
        FILES
        resources.qrc
)
