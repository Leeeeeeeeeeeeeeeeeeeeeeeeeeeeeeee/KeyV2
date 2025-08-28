SHELL := /bin/bash

# Configurable variables
SCAD ?= keys.scad
IMGSIZE ?= 1600,1200
# Vector camera (6 numbers) for compatibility with OpenSCAD 2021.01
CAMERA ?= 0,0,500,0,0,0
COLORSCHEME ?= Tomorrow
OPENSCAD ?= openscad

# macOS app auto-detect (override by passing OPENSCAD=...)
ifneq (,$(wildcard /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD))
  OPENSCAD := /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
else ifneq (,$(wildcard /Applications/OpenSCAD-nightly.app/Contents/MacOS/OpenSCAD))
  OPENSCAD := /Applications/OpenSCAD-nightly.app/Contents/MacOS/OpenSCAD
else ifneq (,$(wildcard /Applications/OpenSCAD-*.app/Contents/MacOS/OpenSCAD))
  OPENSCAD := $(firstword $(wildcard /Applications/OpenSCAD-*.app/Contents/MacOS/OpenSCAD))
else ifneq (,$(wildcard $(HOME)/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD))
  OPENSCAD := $(HOME)/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
endif

.PHONY: which_openscad
which_openscad:
	@echo Using OPENSCAD='$(OPENSCAD)'

.PHONY: test_top test_top_render test_top_clean

# Fast preview image (OpenCSG). Overwrites on each run.
test_top:
	$(OPENSCAD) -o test_top.png \
	  --imgsize=$(IMGSIZE) \
	  --autocenter --viewall \
	  --projection=o \
	  --camera=$(CAMERA) \
	  --colorscheme=$(COLORSCHEME) \
	  $(SCAD)

# Full CGAL render (F6-equivalent). Slower but accurate geometry.
test_top_render:
	$(OPENSCAD) -o test_top.png \
	  --render \
	  --imgsize=$(IMGSIZE) \
	  --autocenter --viewall \
	  --projection=o \
	  --camera=$(CAMERA) \
	  --colorscheme=$(COLORSCHEME) \
	  $(SCAD)

test_top_clean:
	rm -f test_top.png
