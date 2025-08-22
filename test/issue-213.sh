#!/usr/bin/env bash
set -e
if ! command -v openscad >/dev/null 2>&1; then
  echo "openscad not found; skipping test" >&2
  exit 0
fi
repo_root=$(pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cat >"$tmp/key_test.scad" <<SCAD
include <${repo_root}/includes.scad>;
legend_text = "";
module test_key(){
  translate_u(0,0) 2u() dsa_row() stabilized() cherry() legend(legend_text, [0,0,6]) key();
}
if (legend_text != "") test_key();
SCAD
declare -A hashes
for legend in Enter Escape Tab Shift; do
  openscad -o "$tmp/$legend.csg" -D "legend_text=\"$legend\"" -D '$fn=1' "$tmp/key_test.scad" >/dev/null 2>&1 || true
  [ -s "$tmp/$legend.csg" ] || { echo "Failed to generate $legend.csg" >&2; exit 1; }
  hash=$(sha256sum "$tmp/$legend.csg" | cut -d' ' -f1)
  hashes[$hash]=1
done
if [ "${#hashes[@]}" -ne 4 ]; then
  echo "Expected 4 distinct key outputs, got ${#hashes[@]}" >&2
  exit 1
fi
echo "Test passed: generated keys are distinct."
