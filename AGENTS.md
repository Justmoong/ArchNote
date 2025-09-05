# Repository Guidelines

## Project Structure & Modules

- App: C++ sources and QML. Entry in `App/main.cpp`; QML under `App/Qml/`; icons in `App/icons/` (bundled to `:/icons`).
  Custom item: `SvgIconItem.*`.
- Test: Qt Test suite. Sources in `Test/` and `Test/TestFile/`. Test runner target: `ArchNoteTests` (outputs to
  `build/Test/.output/`).
- UI: Standalone Qt Design Studio project for prototyping; not required to build the main app.
- CMakeLists.txt: Top-level config; adds `App/` and `Test/`.

## Build, Test, and Development

- Prereqs: CMake ≥ 3.24, Qt 6, KF6 (KSvg), C++17 toolchain.
- Configure: `cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug`
- Build app: `cmake --build build -j`
- Run app:
    - macOS: `open build/ArchNote.app` (or `build/ArchNote.app/Contents/MacOS/ArchNote`)
    - Linux: `./build/ArchNote`
- Build tests: `cmake --build build --target ArchNoteTests`
- Run tests: `./build/Test/.output/ArchNoteTests -vs`

## Coding Style & Naming

- C++: 4‑space indent; brace on same line; `PascalCase` types, `camelCase` methods/vars; headers `.h`, impl `.cpp`
  matching class name. Prefer Qt types (`QString`, `QVector`). Signals/slots use `camelCase`.
- QML: Components `UpperCamelCase`; properties `camelCase`; keep imports explicit; reference icons via
  `:/icons/<name>.svg`.
- Formatting: Use repo style; if `clang-format` is configured, apply it before commits.

## Testing Guidelines

- Framework: Qt Test with a central registry (`Test/TestRegistry.cpp`).
- Add tests: create `Test/TestFile/Test<Feature>.h` with `Q_OBJECT` and private slots; include and register in
  `TestRegistry.cpp` via `QTest::qExec`.
- Naming: `Test<Feature>` per unit; one concern per class. Keep tests deterministic and headless.

## Commit & Pull Requests

- Commits: imperative present (“Fix”, “Refactor”, “Add …”); small, focused; reference issues (e.g., `#123`).
- PRs: clear description, rationale, and scope; include build/test results and relevant screenshots for UI; list
  platforms tested (macOS/Linux); link issues.

## Configuration Tips

- Qt/KF6: On Linux, CMake auto-detects `~/Qt/6.*/gcc_64`. Otherwise set `CMAKE_PREFIX_PATH` to your Qt install. Ensure
  KF6 (KSvg) is installed and discoverable.
