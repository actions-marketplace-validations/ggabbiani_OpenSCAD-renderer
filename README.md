# OpenSCAD-renderer

HiRes rendering of OpenSCAD scripts.

## Inputs

| name      | required  | default       | description
| ---       | ---       | ---           | ---
| camera    | false     | -             | OpenSCAD camera position (see [^1])
| picture   | false     | [^2]          | Target picture name (e.g. pictures/pic_1.png)
| projection| false     | 'perspective' | 'ortho' or 'perspective'
| resolution| false     | 800x600       | Target image resolution in 'openscad' format (e.g. 1024x768)
| script    | true      | -             | OpenSCAD script

[^1]: OpenSCAD camera settings in the format `tx,ty,tz,rx,ry,rz,d`
  with `tx,ty,tz` for translations, `rx,ry,rz` for rotations and `d` for the distance

[^2]: the default is formed by the OpenSCAD script name with suffix replaced by `.png`.

## Usage examples

### Using defaults

    uses: ggabbiani/OpenSCAD-renderer@v1
    with:
      script: 'tests/logo.scad' # Path relative to the git repo root

The resulting picture will be saved as `tests/logo.png` with te default 800x600 resolution.

### Overriden imputs

    uses: ggabbiani/OpenSCAD-renderer@v1
    with:
      resolution: '1024x768'
      script: 'tests/logo.scad'
      picture: 'tests/logo-overridden.png'
      projection: 'ortho'
