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

# 0) 현재 CMake가 바라보는 기준 경로를 명시적으로 고정
set (APP_DIR "${CMAKE_CURRENT_LIST_DIR}")                   # 이 파일이 있는 폴더
set (ICON_DIR "${APP_DIR}/icons")

# 1) 디버그 로그로 경로와 목록을 즉시 출력
message (STATUS "[ArchNote] APP_DIR=${APP_DIR}")
message (STATUS "[ArchNote] ICON_DIR=${ICON_DIR}")
if (EXISTS "${ICON_DIR}/checklist.svg")
    message (STATUS "[ArchNote] checklist.svg FOUND at ${ICON_DIR}/checklist.svg")
else ()
    message (STATUS "[ArchNote] checklist.svg NOT FOUND at ${ICON_DIR}/checklist.svg")
    if (EXISTS "${APP_DIR}")
        file (GLOB _ls_icons "${ICON_DIR}/*")
        message (STATUS "[ArchNote] ICON_DIR listing: ${_ls_icons}")
    endif ()
    message (FATAL_ERROR "Missing required icon at: ${ICON_DIR}/checklist.svg")
endif ()

# 2) 파일 수집은 CONFIGURE_DEPENDS로 추적
file (GLOB ICON_FILES CONFIGURE_DEPENDS "${ICON_DIR}/*.svg")

# 3) 리소스 등록: BASE를 ICON_DIR로 고정하면 런타임 경로는 :/icons/이 됨
qt_add_resources (ArchNote app_icons
        PREFIX "/icons"
        BASE "${ICON_DIR}"
        FILES ${ICON_FILES})