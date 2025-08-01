cmake_minimum_required(VERSION 3.31)
project(ArchNote)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/bin")

message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

find_package(Qt6 REQUIRED COMPONENTS
        Core
        Gui
        Quick
        Qml
        QuickControls2
        QuickTemplates2
        QuickLayouts
)


qt_standard_project_setup(REQUIRES 6.8)

add_subdirectory(App)
add_subdirectory(Test EXCLUDE_FROM_ALL)

if (APPLE)
    set_target_properties(ArchNote PROPERTIES
            MACOSX_BUNDLE TRUE
    )
elseif (WIN32)
    set_target_properties(ArchNote PROPERTIES
            WIN32_EXECUTABLE TRUE
    )
elseif (UNIX)
    set_target_properties(ArchNote PROPERTIES
            OUTPUT_NAME "Arch Note"
    )
endif ()


if (APPLE)
    set_target_properties(ArchNote PROPERTIES
            MACOSX_BUNDLE TRUE
    )
elseif (WIN32)
    set_target_properties(ArchNote PROPERTIES
            WIN32_EXECUTABLE TRUE
    )
elseif (UNIX)
    set_target_properties(ArchNote PROPERTIES
            OUTPUT_NAME "Arch Note"
    )
endif ()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

target_link_libraries(ArchNote PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::QuickTemplates2
        Qt6::QuickLayouts
)

target_include_directories (ArchNote PRIVATE
        ${CMAKE_SOURCE_DIR}/lib
)

file(GLOB ICON_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/Resources/Icons/*.png"
)
qt_add_resources(ArchNote "resources"
        PREFIX "/Icons"
        BASE Resources/Icons
        FILES ${ICON_FILES}
)

enable_testing()

function (_strip_agl target)
    if (NOT TARGET ${target})
        return ()
    endif ()

    get_target_property (_libs ${target} LINK_LIBRARIES)
    if (_libs)
        list (REMOVE_ITEM _libs "-framework" "AGL" AGL)
        if (_libs)
            string (JOIN ";" _libs_join ${_libs})
            set_target_property (${target}
                    ${target} LINK_LIBRARIES "${_libs_join}")
        endif ()
    endif ()

    get_target_property (_opts ${target} LINK_OPTIONS)
    if (_opts)
        list (REMOVE_ITEM _opts "-framework" "AGL")
        if (_opts)
            string (JOIN ";" _opts_join ${_opts})
            set_target_property (${target} LINK_OPTIONS "${_opts_join}")
        endif ()
    endif ()
endfunction ()