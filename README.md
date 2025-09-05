# ArchNote

Qt 6 + QML note-taking app using CMake and KF6 (KSvg). Builds on macOS and Linux.

## Quick Start

- Prerequisites: CMake ≥ 3.24, C++17 toolchain, Qt 6 (Core/Gui/Quick/Qml/QuickControls2/Svg), KDE Frameworks 6 (Svg,
  CoreAddons, I18n, Config).
- Configure (Debug):
    - Default: `cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug`
    - If Qt isn’t auto-detected: `cmake -S . -B build -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x/gcc_64`
- Build: `cmake --build build -j`
- Run:
    - macOS: `open build/ArchNote.app` (or `build/ArchNote.app/Contents/MacOS/ArchNote`)
    - Linux: `./build/ArchNote`

## Tests

- Build tests: `cmake --build build --target ArchNoteTests`
- Run tests: `./build/Test/.output/ArchNoteTests -vs`

## Project Layout

- `App/`: C++ sources and app QML.
    - `App/Qml/`: Views, components, and main QML (`App/Qml/Main.qml`).
    - `App/icons/`: SVG assets bundled to `:/icons`.
    - `App/SvgIconItem.*`: Custom QQuickPaintedItem for SVG rendering.
- `Test/`: Qt Test suite with a registry runner.
- `UI/`: Qt Design Studio project (for prototyping), not required for main build.
- `CMakeLists.txt`: Top-level config; adds `App/` and `Test/`.

## Notes & Troubleshooting

- Linux Qt discovery: the build searches `~/Qt/6.*/gcc_64`. Override with `CMAKE_PREFIX_PATH` if needed.
- KF6 (KSvg) must be installed and discoverable by CMake.

## Contributing

See `AGENTS.md` for coding style, testing, and PR guidelines.
