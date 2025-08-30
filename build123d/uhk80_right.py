"""
Build123d + Capistry model helpers for UHK80 right half.

This script provides small helpers to construct UHK80 keycaps using Capistry,
place them on the unit grid, and add centered legends. It includes an example
that builds the top row on the right half (F7..Pause).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import cast

from build123d import *
from ocp_vscode import set_port, set_defaults, reset_show, show, Camera
import sys
from pathlib import Path

# Prefer vendored Capistry if available (Python 3.12 compatible)
VENDOR_DIR = Path(__file__).resolve().parent.parent / "third_party"
if (VENDOR_DIR / "capistry").exists():
    sys.path.insert(0, str(VENDOR_DIR))
from capistry import RectangularCap, Taper, MXStem  # type: ignore


# -----------------------------------------------------------------------------
# Constants mirroring key OpenSCAD defaults
# -----------------------------------------------------------------------------
UNIT = 19.05  # keyboard unit in mm
BOTTOM_1U = 18.16  # bottom footprint of a 1U key (both width and depth)
WIDTH_DIFF = 6.0  # top width is smaller by this many mm (constant across U)
HEIGHT_DIFF = 4.0  # top depth is smaller by this many mm (constant across U)

# UHK80 adjustments
UHK_DEPTH_SCALE = 1.5
UHK_DISH_DEPTH = 0.75
UHK_TILT_ADJUST = -2.0  # additional forward tilt (deg)

# Cherry MX socket approximations (based on src/functions.scad)
STEM_THROW = 4.0  # depth of cross cut
STEM_SLOP_OUTER = 0.35  # slop for boss outside dims (outer_cherry_stem)
STEM_SLOP_INNER = 0.20  # slop for cross hole
STEM_BOSS_RADIUS = 1.0  # rounding radius for boss corners (approx)
STEM_BOSS_HEIGHT = 6.0  # height of the boss from the underside into the cap
ENABLE_STEM_CROSS = True  # set False to isolate/diagnose boolean issues


# -----------------------------------------------------------------------------
# Row profile (depth and base tilt) as in src/key_profiles/dcs.scad
# -----------------------------------------------------------------------------
@dataclass(frozen=True)
class RowProfile:
    base_depth: float  # mm, before UHK scaling
    top_tilt: float  # degrees


# DCS-like baselines used by uhk80.scad; all rows available
ROW_PROFILE: dict[int, RowProfile] = {
    1: RowProfile(8.5, -1),
    2: RowProfile(7.5, 3),
    3: RowProfile(6.0, 7),
    4: RowProfile(6.0, 16),
    5: RowProfile(11.5, -6),
}


def unit_length(u: float) -> float:
    """Bottom size (mm) for a key of width u, matching SCAD's unit_length()."""
    return BOTTOM_1U + UNIT * (u - 1)


def uhk_depth_and_tilt(row: int) -> tuple[float, float]:
    """Apply UHK80 adjustments to DCS row profile.

    - Depth is scaled by 1.5×.
    - Tilt flips sign for bottom row (5), then gets an extra -2°.
    """
    rp = ROW_PROFILE.get(row, RowProfile(8.5, -1))
    depth = rp.base_depth * UHK_DEPTH_SCALE
    tilt = (-rp.top_tilt if row == 5 else rp.top_tilt) + UHK_TILT_ADJUST
    return depth, tilt


def cylindrical_dish_radius(chord: float, sagitta: float) -> float:
    """Utility kept for reference; not used by Capistry path."""
    a = chord / 2.0
    return (a * a + sagitta * sagitta) / (2.0 * sagitta)


def keycap(row: int, u: float) -> Part:
    """Create a printable UHK80 keycap using Capistry.

    Uses RectangularCap + per-side taper matching the SCAD top reductions.
    """
    bottom_w = unit_length(u)
    bottom_d = BOTTOM_1U
    total_depth, row_tilt = uhk_depth_and_tilt(row)

    # Compute taper angles (deg) so top is smaller by WIDTH/HEIGHT_DIFF
    # per-side reduction = diff/2
    from math import degrees, atan

    left_right_angle = degrees(atan((WIDTH_DIFF / 2.0) / total_depth))
    front_back_angle = degrees(atan((HEIGHT_DIFF / 2.0) / total_depth))

    cap_obj = RectangularCap(
        width=bottom_w,
        length=bottom_d,
        height=total_depth,
        wall=1.5,
        roof=1.0,
        taper=Taper(front=front_back_angle, back=front_back_angle, left=left_right_angle, right=left_right_angle),
        stem=MXStem(),
    )

    cap: Part = cap_obj.compound
    return cap.rotate(Axis.X, row_tilt) if row_tilt else cap


def make_centered_legend(cap: Part, text: str, font_size: float = 3.0, thickness: float = 0.6, embed: float = 0.8) -> Part:
    """Create an outset legend centered on the cap's top face (returns separate Part).

    Finds the top-most face, builds a plane at its center with the face normal as z_dir,
    offsets down by `embed`, sketches text, extrudes, and returns the legend Part.
    """
    topf = cap.faces().sort_by(Axis.Z)[-1]
    center = topf.center(CenterOf.BOUNDING_BOX)
    normal = topf.normal_at()
    plane = Plane(origin=center, x_dir=Vector(1, 0, 0), z_dir=normal).offset(-embed)
    with BuildPart() as bp:
        with BuildSketch(plane):
            Text(text, font_size=font_size, align=(Align.CENTER, Align.CENTER))
        extrude(amount=thickness)
    return cast(Part, bp.part)


def place_on_grid(p: Part, x_u: float, y_u: float) -> Part:
    """Place a part on the UHK unit grid (x right, y down)."""
    return p.moved(Location((x_u * UNIT, -y_u * UNIT, 0)))


# Top row (right half) from uhk80.scad
FROW_LAYOUT: list[tuple[int, float, str, float, float, int]] = [
    (1, 1, "F7", 7.5, 0, 3),
    (1, 1, "F8", 8.5, 0, 3),
    (1, 1, "F9", 9.5, 0, 3),
    (1, 1, "F10", 10.5, 0, 3),
    (1, 1, "F11", 11.5, 0, 3),
    (1, 1, "F12", 12.5, 0, 3),
    (1, 1.5, "Print", 13.75, 0, 3),
    (1, 1, "ScrlLk", 15.0, 0, 3),
    (1, 1, "Pause", 16.0, 0, 3),
]


CAP_COLOR = (1.0, 0.85, 0.2)
LEGEND_COLOR = (0.15, 0.15, 0.15)


def build_top_row_parts_and_colors() -> tuple[list[Part], list]:
    parts: list[Part] = []
    colors: list = []
    for row, u, legend, x, y, font_sz in FROW_LAYOUT:
        cap = keycap(row, u)
        legend_part = make_centered_legend(cap, legend, font_size=float(font_sz))
        cap = place_on_grid(cap, x, y)
        legend_part = place_on_grid(legend_part, x, y)
        parts.extend([cap, legend_part])
        colors.extend([CAP_COLOR, LEGEND_COLOR])
    return parts, colors


# -----------------------------------------------------------------------------
# Viewer entrypoint
# -----------------------------------------------------------------------------
set_port(3939)
set_defaults(reset_camera=Camera.CENTER, helper_scale=5)


if __name__ == "__main__":
    reset_show()
    # Example: build and show the top row (F7..Pause) with colored legends
    parts, colors = build_top_row_parts_and_colors()
    show(
        *parts,
        colors=colors,
        axes=False,
        axes0=False,
        grid=(False, False, False),
        reset_camera=Camera.CENTER,
    )
