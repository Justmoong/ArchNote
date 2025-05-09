file(GLOB_RECURSE CPP_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")
add_executable(ArchNoteTests
        ${CPP_SOURCES}
)

# 테스트 전용 출력 디렉토리 설정 (예: build/tests/)
set_target_properties(ArchNoteTests PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "Test/output"
)

target_link_libraries(ArchNoteTests PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Test
        ArchNoteAppQml
)