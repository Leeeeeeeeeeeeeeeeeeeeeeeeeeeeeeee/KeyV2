# Repository Guidelines

## Project Structure & Module Organization
- Purpose: customize KeyV2 for UHK80 and generate printable keycaps.
- `uhk80.scad`: Customization layer where we define UHK80‑specific rows, R values, U widths, legends, and defaults. Most changes happen here (often assisted by AI).
- `keys.scad`: Driver that calls into `uhk80.scad` to render a specific key, row, or the full set for preview/print.
- `src/`: Core OpenSCAD library (shapes, stems, dishes, layouts, profiles). Use `src/key.scad` and `src/settings.scad` when extending base behavior.
- Reference images: `layout.png` (legend map + physical layout), `uhk80-keycap-profiles.png` (side profiles and R values like R1, R4X), `uhk80-layout-iso.png` (per‑key R and U values).
- Outputs: CLI/gulp writes `.stl` next to the source `.scad` (e.g., `keys.scad.stl`).

## Build, Test, and Development Commands
- `openscad keys.scad -o keys.stl`: Render keys defined via `uhk80.scad` entrypoints.
- `openscad uhk80.scad -o uhk80.stl`: Render directly from the customization file if desired.
- `npm install`: Install build tooling (gulp and plugins).
- `npx gulp` (or `gulp`): Watch and auto‑compile changed root `.scad` files to `.stl`.
- GUI tip: Open `keys.scad` and enable Design → Automatic Reload and Preview for rapid layout checks.

## Coding Style & Naming Conventions
- OpenSCAD: 2‑space indentation; lower_snake_case module/variable names; settings use `$setting_name` and are documented in `src/settings.scad`.
- File names: lower_snake_case, one module family per file (e.g., `src/shapes/*.scad`).
- JavaScript (gulpfile): 2 spaces, semicolons; keep tasks small and composable.
- Ruby utilities: 2 spaces, snake_case; keep scripts idempotent.

## Testing Guidelines
- Visual: Open `keys.scad` to preview rows/sets produced by `uhk80.scad`.
- Validate mappings: use `layout.png` for legend placement; `uhk80-keycap-profiles.png` for profile and R checks; `uhk80-layout-iso.png` for per‑key R and U verification.
- CLI: regenerate STL and inspect in your viewer.
- Collision: set `$clearance_check = true;` when testing clearances.
- Keep reproducible snippets in `examples/` with brief comments.

## Commit & Pull Request Guidelines
- Commits: Prefer Conventional Commits (`feat:`, `fix:`, `docs:`). Use imperative, present tense and focused diffs.
- PRs: Include purpose, before/after screenshots or renders, reproduction steps (OpenSCAD line snippet), and any default changes to `keys.scad`/settings. Link related issues.
- CI: None. Please verify locally (GUI preview + STL render) before requesting review.

## Security & Environment Tips
- Use a recent OpenSCAD (dev snapshot recommended for features/perf).
- Node/Gulp are only for auto‑compiles; OpenSCAD CLI/GUI is the source of truth.
