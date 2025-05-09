file(GLOB_RECURSE CPP_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")
add_executable(ArchNoteTests
        ${CPP_SOURCES}
)

find_package(Qt6 REQUIRED COMPONENTS Test)

set_target_properties(ArchNoteTests PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "Test/output"
)

target_link_libraries(ArchNoteTests PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Test
        ArchNoteAppQml
)