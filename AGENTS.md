# Repository Guidelines

## Project Structure & Module Organization

- `CMakeLists.txt` (root): Configures Qt 6.6+ and KF6; adds `App/` and target `ArchNote`.
- `App/main.cpp`: Qt entry point; loads `qrc:/qml/Main.qml`.
- `App/Qml/`: QML UI (e.g., `Main.qml`, `ContentsView.qml`). QML is bundled via `qt_add_qml_module` and accessed with
  `qrc:/qml/...`.
- `App/icons/`: SVG assets. Add new files to `App/resources.qrc`.
- Out-of-source builds only (use a `build/` directory).

## Build, Test, and Development Commands

- Configure: `cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug`
- Build: `cmake --build build -j`
- Run (macOS): `open build/ArchNote.app` or `build/ArchNote.app/Contents/MacOS/ArchNote`
- Run (Linux): `./build/ArchNote`
- Tests: `ctest --test-dir build` (when tests are added).

## Coding Style & Naming Conventions

- C++: 4 spaces, no tabs. Classes `CamelCase`; methods/variables `lowerCamelCase`; files `ClassName.h/.cpp`. Prefer Qt
  types and string literals (`u"..."_s`, `QStringLiteral`). Avoid hard‑coded absolute paths.
- QML: One component per file. File names `PascalCase.qml`; properties/ids `lowerCamelCase`. Keep imports explicit (
  `org.kde.kirigami`, addons).
- Formatting: Use `clang-format` (LLVM style acceptable if no repo config). QML: run `qmllint` locally before PRs.

## Testing Guidelines

- Frameworks: Qt Test for C++; `qmltestrunner` for QML.
- Location: place tests under `tests/`. C++: `*_test.cpp`; QML: `tst_*.qml`.
- Running: add tests to CMake, then run `ctest -V --test-dir build`. Aim to cover new logic and a startup smoke test.

## Commit & Pull Request Guidelines

- Commits: imperative mood with optional scope, e.g., `Qml: add ContentsView layout`, `CMake: fix Qt paths`.
- PRs: include a clear description, linked issues, screenshots/GIFs for UI, platform + Qt/KF versions, and manual test
  notes.

## Security & Configuration Tips

- Do not commit local, user‑specific paths. Prefer `QML_IMPORT_PATH`/`CMAKE_PREFIX_PATH` over
  `engine.addImportPath(...)` for portability.
- New assets must be referenced via `App/resources.qrc` and used with `qrc:/` URLs.

