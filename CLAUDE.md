# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Development Commands

### Core Build Commands

- **Configure**: `cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug`
- **Build application**: `cmake --build build -j`
- **Build tests**: `cmake --build build --target ArchNoteTests`

### Running

- **macOS**: `open build/ArchNote.app` or `build/ArchNote.app/Contents/MacOS/ArchNote`
- **Linux**: `./build/ArchNote`
- **Tests**: `./build/Test/.output/ArchNoteTests -vs`

### Qt Path Configuration

- **Linux**: CMake auto-detects `~/Qt/6.*/gcc_64`. Override with `CMAKE_PREFIX_PATH=/path/to/Qt/6.x/gcc_64` if needed
- **macOS**: Uses system framework paths automatically

## Architecture Overview

### Project Structure

- **App/**: Main application source code and QML files
    - `main.cpp`: Application entry point
    - `Qml/`: QML views and components (Main.qml is the root)
    - `icons/`: SVG assets bundled as `:/icons/<name>.svg` resources
    - `SvgIconItem.*`: Custom QQuickPaintedItem for SVG rendering (macOS only)
- **Test/**: Qt Test framework with registry-based runner
    - `TestRegistry.*`: Central test registration system
    - `TestFile/`: Individual test classes (Test<Feature>.h pattern)
- **UI/**: Qt Design Studio project for prototyping (optional)

### Technology Stack

- **Frontend**: Qt 6.8+ (Core, Gui, Quick, QML, QuickControls2, Svg)
- **Backend**: C++17 with Qt framework integration
- **UI Framework**: KDE Frameworks 6 (KSvg for SVG handling)
- **Build System**: CMake 3.24+ with qt_standard_project_setup

### Key Components

- **SVG Icon System**: Icons stored in `App/icons/` and accessed via `:/icons/<name>.svg`
- **QML Architecture**: Component-based UI with explicit imports
- **Test Framework**: Qt Test with centralized registry in `TestRegistry.cpp`

### Platform-Specific Notes

- **macOS**: Uses framework-based linking, includes SvgIconItem for custom SVG rendering
- **Linux**: Requires KF6 installation, searches for Qt in `~/Qt/` by default
- **Cross-platform**: SVG resources and QML components work identically across platforms

### Code Style (from AGENTS.md)

- **C++**: 4-space indent, same-line braces, PascalCase types, camelCase methods/vars
- **QML**: UpperCamelCase components, camelCase properties, explicit imports
- **Headers**: `.h` files match class names, prefer Qt types (QString, QVector)

### Testing Strategy

- Create `Test/TestFile/Test<Feature>.h` with Q_OBJECT and private slots
- Register tests in `TestRegistry.cpp` using `QTest::qExec`
- Keep tests deterministic and headless
- One test class per feature/concern