"""CadQuery model for the right half of the UHK80 keyboard.

This script is a lightweight port of the OpenSCAD-based KeyV2 project. It
produces a simple set of keycaps using CadQuery so they can be previewed in
VSCode with the CadQuery extension or exported as an STL.
"""

import cadquery as cq

# Size of one keyboard unit in millimetres
UNIT = 19.05
# Approximate height of a keycap
KEY_HEIGHT = 10.0
# Simple mapping of row number to top tilt in degrees
ROW_TILT = {1: 7, 2: 5, 3: 3, 4: 1, 5: -2}

# Right-hand layout data: (row, unit width, legend, x, y, font_size)
RIGHT_LAYOUT = [
    (1, 1, "F7", 7.5, 0, 3),
    (1, 1, "F8", 8.5, 0, 3),
    (1, 1, "F9", 9.5, 0, 3),
    (1, 1, "F10", 10.5, 0, 3),
    (1, 1, "F11", 11.5, 0, 3),
    (1, 1, "F12", 12.5, 0, 3),
    (1, 1.5, "Print", 13.75, 0, 3),
    (1, 1, "ScrLk", 15.0, 0, 3),
    (1, 1, "Pause", 16.0, 0, 3),

    (2, 1, "7", 7.5, -1, 4),
    (2, 1, "8", 8.5, -1, 4),
    (2, 1, "9", 9.5, -1, 4),
    (2, 1, "0", 10.5, -1, 4),
    (2, 1, "-", 11.5, -1, 4),
    (2, 1, "=", 12.5, -1, 4),
    (1, 1.5, "Backspace", 13.75, -1, 4),
    (1, 1, "Ins", 15.0, -1, 4),
    (1, 1, "Del", 16.0, -1, 4),

    (3, 1, "Y", 7.0, -2, 4),
    (3, 1, "U", 8.0, -2, 4),
    (3, 1, "I", 9.0, -2, 4),
    (3, 1, "O", 10.0, -2, 4),
    (3, 1, "P", 11.0, -2, 4),
    (3, 1, "[", 12.0, -2, 4),
    (3, 1, "]", 13.0, -2, 4),
    (3, 1, "\\", 14.0, -2, 4),
    (2, 1, "Home", 15.0, -2, 4),
    (2, 1, "PgUp", 16.0, -2, 4),

    (4, 1, "H", 7.25, -3, 4),
    (4, 1, "J", 8.25, -3, 4),
    (4, 1, "K", 9.25, -3, 4),
    (4, 1, "L", 10.25, -3, 4),
    (4, 1, ";", 11.25, -3, 4),
    (4, 1, "'", 12.25, -3, 4),
    (4, 1.75, "Enter", 13.625, -3, 4),
    (4, 1, "End", 15.0, -3, 4),
    (4, 1, "PgDn", 16.0, -3, 4),

    (5, 1, "N", 7.75, -4, 4),
    (5, 1, "M", 8.75, -4, 4),
    (5, 1, ",", 9.75, -4, 4),
    (5, 1, ".", 10.75, -4, 4),
    (5, 1, "/", 11.75, -4, 4),
    (5, 1.25, "Shift", 12.85, -4, 4),
    (5, 1, "\u00AB", 14.0, -4, 4),
    (5, 1, "\u2191", 15.0, -4, 4),
    (5, 1, "\u00BB", 16.0, -4, 4),

    (5, 1.5, "Space", 7.5, -5, 4),
    (5, 1.5, "Super", 9.0, -5, 4),
    (5, 1.25, "Alt", 10.35, -5, 4),
    (5, 1.25, "Fn", 11.6, -5, 4),
    (5, 1.25, "Ctrl", 12.85, -5, 4),
    (5, 1, "\u2190", 14.0, -5, 4),
    (5, 1, "\u2193", 15.0, -5, 4),
    (5, 1, "\u2192", 16.0, -5, 4),
]


def keycap(row: int, width_u: float) -> cq.Workplane:
    """Create a very simple keycap.

    The model is intentionally lightweight; it lofts between bottom and
    slightly smaller top rectangles then subtracts a large sphere to form a
    shallow dish. Row tilt is approximated with a small rotation.
    """
    width = width_u * UNIT
    depth = UNIT
    top_w = width - 1.0
    top_d = depth - 1.0

    key = (
        cq.Workplane("XY")
        .rect(width, depth)
        .workplane(offset=KEY_HEIGHT)
        .rect(top_w, top_d)
        .loft(combine=True)
    )

    dish = cq.Workplane("XY").workplane(offset=KEY_HEIGHT + 4).sphere(40)
    key = key.cut(dish)
    key = key.rotate((0, 0, 0), (1, 0, 0), ROW_TILT.get(row, 0))
    return key


keyboard = cq.Assembly()
for i, (row, u, legend, x, y, font) in enumerate(RIGHT_LAYOUT):
    cap = keycap(row, u)
    cap = cap.translate((x * UNIT, -y * UNIT, 0))
    keyboard.add(cap, name=f"key_{i}")

if "show_object" in globals():
    show_object(keyboard)

if __name__ == "__main__":
    cq.exporters.export(keyboard.toCompound(), "cadquery/uhk80_right.stl")
    print("Exported cadquery/uhk80_right.stl")
