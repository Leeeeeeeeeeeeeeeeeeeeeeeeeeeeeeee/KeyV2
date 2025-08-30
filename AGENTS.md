# Repository Guidelines

## Project Structure & Module Organization
- Purpose: customize KeyV2 for UHK80 and generate printable keycaps.
- `uhk80.scad`: Customization layer where we define UHK80‑specific rows, R values, U widths, legends, and defaults. Most changes happen here (often assisted by AI).
- `keys.scad`: Driver that calls into `uhk80.scad` to render a specific key, row, or the full set for preview/print.
- `src/`: Core OpenSCAD library (shapes, stems, dishes, layouts, profiles). Use `src/key.scad` and `src/settings.scad` when extending base behavior.
- Reference images: `layout.png` (legend map + physical layout), `uhk80-keycap-profiles.png` (side profiles and R values like R1, R4X), `uhk80-layout-iso.png` (per‑key R and U values). Split left/right layout images are available to focus edits on one half.
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
- Half‑specific review: use the split left/right layout images to validate only the active half (e.g., right‑side iteration).
- CLI: regenerate STL and inspect in your viewer.
- Collision: set `$clearance_check = true;` when testing clearances.
- Keep reproducible snippets in `examples/` with brief comments.

## Commit & Pull Request Guidelines
- Commits: Prefer Conventional Commits (`feat:`, `fix:`, `docs:`). Use imperative, present tense and focused diffs.
- PRs: Include purpose, before/after screenshots or renders, reproduction steps (OpenSCAD line snippet), and any default changes to `keys.scad`/settings. Link related issues.
- CI: None. Please verify locally (GUI preview + STL render) before requesting review.

## Repository Scope
- Fork‑only workflow: this fork is the canonical repo. Ignore upstream; do not open PRs or push there.
- Push target: use `origin` only. I will confirm with prompts like “push now?” before publishing.

## Security & Environment Tips
- Use a recent OpenSCAD (dev snapshot recommended for features/perf).
- Node/Gulp are only for auto‑compiles; OpenSCAD CLI/GUI is the source of truth.

---

## Python CAD Workflow (Build123d + Capistry)

This fork also includes an alternative Python path for quick previews and STL exports using Build123d and the Capistry library.

### Files
- `build123d/uhk80_right.py`: Python entrypoint. Currently renders a single F7 key (R1 1U) with an MX stem and an outset legend.
- `third_party/capistry/`: Vendored Capistry source to support Python 3.12 (upstream requires 3.13+). Do not edit upstream API here unless necessary.

### Setup
- Python: use the repo’s `.python-version` (3.12.x). Upstream Capistry needs 3.13+, so we vendor it instead.
- Install minimal dependencies in the active interpreter:
  - `pip install build123d rich attrs more-itertools mashumaro`
  - Optional: `pip install ocp_vscode vtk` (VTK only silences the viewer message)

### Viewer
- VS Code: install the “OCP CAD Viewer” extension.
- The script configures port `3939`. Open the viewer panel and ensure it shows “Connected 3939”.
- “VTK not installed” is informational; the WebGL backend still works.

### How the Python model maps the OpenSCAD settings
- Unit grid: `UNIT = 19.05` mm; a 1U bottom footprint is `18.16 × 18.16` mm.
- Top reductions from SCAD defaults: `width_diff = 6` mm, `height_diff = 4` mm.
- UHK row depth/tilt (from `src/key_profiles/dcs.scad`) with UHK adjustments:
  - Depth scale `1.5×` (e.g., R1 base depth 8.5 → ~12.75 mm total cap height)
  - Extra tilt adjust about `-2°`; bottom row sign may flip relative to others.
- Capistry build uses `RectangularCap(width, length, height, wall, roof, taper, stem)`:
  - Taper per side derived from the desired top reductions and final height: `angle = atan(delta_per_side / height)`.
  - `MXStem()` attaches automatically via an internal joint.
  - Fillets are handled by Capistry’s default strategy (robust for previews).

### Legend placement (centered and aligned)
- To keep legends centered and sitting on the top after any tilt/fillets:
  1) Get the cap’s top face and its center/normal.
  2) Create a `Plane` at that center with `z_dir = normal`.
  3) Sketch `Text("F7", font_size=...)` on that plane, offset down a small embed (e.g., 0.8–0.9 mm), then `extrude` a small thickness (e.g., 0.6 mm).
  4) Union the text part with the cap compound.
- This avoids guessing XY/Z and stays correct with row tilt and surface changes.

### Exporting
- Use build123d exporters on the final `Compound`:
  - `export_stl(part_or_compound, "out.stl")`
  - `export_step(...)` etc.

### Extending to full layout
- Start from `uhk80_right.py` and re‑introduce the row/half layout lists from `uhk80.scad`.
- Place keys on the grid with `Location((x * UNIT, -y * UNIT, 0))` and apply per‑key row/width.
- For top surface curvature beyond simple taper, use `capistry.Surface` and assign via the `surface=` argument to the cap.

### Notes
- Upstream Capistry docs: https://larssont.github.io/capistry/capistry.html
- If you upgrade to Python 3.13+, you can `pip install capistry` instead of using the vendored copy. Remove `third_party/capistry` and the `sys.path` shim in `build123d/uhk80_right.py` when doing so.

### Snippets (ready to paste)

Quick start: one rectangular cap with MX stem
```python
from build123d import *
from capistry import RectangularCap, Taper, MXStem, fillet_safe

# Standard 1U bottom + UHK R1 height
BOTTOM_1U = 18.16
height = 8.5 * 1.5  # DCS R1 base * UHK scale

# Top smaller by 6 mm (X) and 4 mm (Y)
from math import atan, degrees
ang_x = degrees(atan((6/2)/height))
ang_y = degrees(atan((4/2)/height))

cap = RectangularCap(
    width=BOTTOM_1U,
    length=BOTTOM_1U,
    height=height,
    wall=1.5,
    roof=1.0,
    taper=Taper(front=ang_y, back=ang_y, left=ang_x, right=ang_x),
    stem=MXStem(),
)

# Optional viewer: ocp_vscode
from ocp_vscode import show
show(cap.compound)
```

Centered legend (robust against tilt/fillets)
```python
from build123d import *

part = cap.compound
topf = part.faces().filter_by(Axis.Z).sort_by(Axis.Z)[-1]
center = topf.center(CenterOf.BOUNDING_BOX)
normal = topf.normal_at()

# Plane at top center, embedded a bit into the roof
embed, thickness = 0.8, 0.6
plane = Plane(origin=center, x_dir=Vector(1, 0, 0), z_dir=normal).offset(-embed)

with BuildPart() as bp:
    with BuildSketch(plane):
        Text("F7", font_size=3.0, align=(Align.CENTER, Align.CENTER))
    extrude(amount=thickness)

cap_with_legend = part + bp.part
```

Surface (simple dish) and apply to cap
```python
from capistry import Surface

# 3x3 offset grid, center depressed ~0.7 mm
surface = Surface(
    [
        [0.2, 0.3, 0.2],
        [0.3, -0.7, 0.3],
        [0.2, 0.3, 0.2],
    ]
)

cap = RectangularCap(
    width=BOTTOM_1U,
    length=BOTTOM_1U,
    height=height,
    wall=1.5,
    roof=1.0,
    taper=Taper(front=ang_y, back=ang_y, left=ang_x, right=ang_x),
    stem=MXStem(),
    surface=surface,
)
```

Place by UHK grid and rotate by row tilt
```python
UNIT = 19.05
def place(cap_compound: Part, x_u: float, y_u: float, tilt_deg: float) -> Part:
    p = cap_compound.moved(Location((x_u * UNIT, -y_u * UNIT, 0)))
    return p.rotate(Axis.X, tilt_deg)

cap_p = place(cap.compound, x_u=7.5, y_u=0, tilt_deg=-3)  # F7
```

Panel for printing (sprued grid)
```python
from capistry import Panel, PanelItem, SprueCylinder

panel = Panel(
    items=[PanelItem(cap, quantity=9)],
    sprue=SprueCylinder(),
    cols=9,
)

from build123d import export_stl
export_stl(panel.compound, "panel_R1_frow.stl")
```

Export individual STL
```python
from build123d import export_stl
export_stl(cap_with_legend, "F7.stl")
```

Row profiles + small subset of the right half
```python
from math import atan, degrees
from build123d import *
from capistry import RectangularCap, Taper, MXStem

UNIT = 19.05
BOTTOM_1U = 18.16
WIDTH_DIFF = 6.0
HEIGHT_DIFF = 4.0
UHK_DEPTH_SCALE = 1.5
UHK_TILT_ADJUST = -2.0

# DCS-like base depths/tilts, then apply UHK rules
ROW_PROFILE = {
    1: (8.5, -1),
    2: (7.5, 3),
    3: (6.0, 7),
    4: (6.0, 16),
    5: (11.5, -6),
}

def uhk_depth_and_tilt(row: int) -> tuple[float, float]:
    d0, t0 = ROW_PROFILE.get(row, ROW_PROFILE[3])
    depth = d0 * UHK_DEPTH_SCALE
    tilt = (-t0 if row == 5 else t0) + UHK_TILT_ADJUST
    return depth, tilt

def taper_for_top_delta(height: float) -> Taper:
    ax = degrees(atan((WIDTH_DIFF / 2.0) / height))
    ay = degrees(atan((HEIGHT_DIFF / 2.0) / height))
    return Taper(front=ay, back=ay, left=ax, right=ax)

def build_key(row: int, u: float, legend_text: str) -> Part:
    depth, tilt = uhk_depth_and_tilt(row)
    width = BOTTOM_1U + UNIT * (u - 1)
    cap = RectangularCap(
        width=width,
        length=BOTTOM_1U,
        height=depth,
        wall=1.5,
        roof=1.0,
        taper=taper_for_top_delta(depth),
        stem=MXStem(),
    ).compound.rotate(Axis.X, tilt)

    # Centered outset legend on the rotated cap
    topf = cap.faces().filter_by(Axis.Z).sort_by(Axis.Z)[-1]
    center = topf.center(CenterOf.BOUNDING_BOX)
    normal = topf.normal_at()
    plane = Plane(origin=center, x_dir=Vector(1, 0, 0), z_dir=normal).offset(-0.8)
    with BuildPart() as bp:
        with BuildSketch(plane):
            Text(legend_text, font_size=3.0, align=(Align.CENTER, Align.CENTER))
        extrude(amount=0.6)
    return cap + bp.part

def place(part: Part, x_u: float, y_u: float) -> Part:
    return part.moved(Location((x_u * UNIT, -y_u * UNIT, 0)))

# Small subset: first column of the right half (F7, 7, Y, H, N)
subset = [
    (1, 1.0, "F7", 7.5, 0.0),
    (2, 1.0, "7", 7.5, -1.0),
    (3, 1.0, "Y", 7.0, -2.0),
    (4, 1.0, "H", 7.25, -3.0),
    (5, 1.0, "N", 7.75, -4.0),
]

caps = [place(build_key(r, u, txt), x, y) for r, u, txt, x, y in subset]

# Preview (ocp_vscode):
from ocp_vscode import show
show(*caps, axes=False, axes0=False, grid=(False, False, False))
```
