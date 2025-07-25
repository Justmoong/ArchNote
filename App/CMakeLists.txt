# ArchNote 실행 파일 정의
qt_add_executable(ArchNote
    main.cpp
)

add_subdirectory(Qml)
add_subdirectory(File)

target_link_libraries(ArchNote PRIVATE
    Qt6::Core Qt6::Gui Qt6::Quick
    ArchNoteAppQml
)

qt_import_qml_plugins(ArchNote)
qt_finalize_executable(ArchNote)
