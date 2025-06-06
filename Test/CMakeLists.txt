file(GLOB_RECURSE CPP_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")
file(GLOB_RECURSE CPP_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.h")
qt6_add_executable(ArchNoteTests
        ${CPP_SOURCES}
        ${CPP_HEADERS}
)

set(CMAKE_AUTOMOC ON)
set (CMAKE_AUTORCC ON)
set (CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Test)

set_target_properties(ArchNoteTests PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "Test/.output"
)

target_sources(ArchNoteTests PRIVATE
        TestRegistry.cpp
)

target_link_libraries(ArchNoteTests PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Test
        ArchNoteAppQml
)