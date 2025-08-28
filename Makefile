SHELL := /bin/bash

# Configurable variables
SCAD ?= keys.scad
IMGSIZE ?= 1600,1200
CAMERA ?= 0,0,500,0,0,0,0,1,0
COLORSCHEME ?= Tomorrow

.PHONY: test_top test_top_render test_top_clean

# Fast preview image (OpenCSG). Overwrites on each run.
test_top:
	openscad -o test_top.png \
	  --imgsize=$(IMGSIZE) \
	  --autocenter --viewall \
	  --projection=orthographic \
	  --camera=$(CAMERA) \
	  --colorscheme=$(COLORSCHEME) \
	  $(SCAD)

# Full CGAL render (F6-equivalent). Slower but accurate geometry.
test_top_render:
	openscad -o test_top.png \
	  --render \
	  --imgsize=$(IMGSIZE) \
	  --autocenter --viewall \
	  --projection=orthographic \
	  --camera=$(CAMERA) \
	  --colorscheme=$(COLORSCHEME) \
	  $(SCAD)

test_top_clean:
	rm -f test_top.png

