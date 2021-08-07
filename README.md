
# Stereo Quake

This project fixes minor bugs in Quake's stereoscopic rendering modes (crosshair in the wrong position, corrupt display in full-screen and excessive stereo separation of the player's weapon) and adds row-interleaved stereoscopic support to Quake 2's software renderer.

## Installation

This project provides replacement executables and DLLs for Quake and Quake II; you can simply overwrite your existing executables with these. Alternatively, copy the updated executables to a new folder, and copy the `id1` (Quake) or `baseq2` (Quake II) directories over from an existing installation.

The new executables have been built with Visual Studio 2008 SP1, so you will also need the Microsoft Visual C++ 2008 SP1 Redistributable Package if you have not already installed it.

## Modifications

These versions of Quake and Quake II have been designed to be simple tweaks to the stereoscopic rendering modes, and not feature-packed source ports. As such, the modifications have been relatively minor.

### Quake

* Crosshair is drawn in the correct location.
* Non-DIB modes should work. Regular WinQuake displays a distorted image in fullscreen unless you pass the -dibonly command-line switch.
* Stereo separation of the player's weapon can be adjusted with a new console variable.
* The 3D effect is reversed if the top row appears on an odd-numbered scanline in windowed mode.
* Particles are drawn at the correct height, not double height. 

### Quake II

* Row interleaved stereoscopic mode added to the software renderer.
* Row interleaved, column interleaved, pixel interleaved and anaglyph stereoscopic modes added to the OpenGL renderer.
* The mouse works in windowed mode when you have multiple monitors. 

## Enabling the stereoscopic rendering mode

Both Quake and Quake II are capable of generating row-interleaved 3D output via console variables. Bring down the console by pressing the key to the left of 1 on your keyboard (on a US layout, this will be the `~` key; on a UK layout, this is the `\`` key), type the variable name, a space, then the value you wish to assign to the variable.

### Quake

* `LCD_X` Camera offset
* `LCD_YAW` Camera rotation
* `LCD_VIEWMODEL_SCALE` Strength of the 3D effect applied to the player's weapon

To enable the stereoscopic rendering mode, set `LCD_X` to any value other than its default zero. This controls the offset of the camera; the larger the value, the further the camera is moved between the generating the view from each eye. A negative value swaps the left and right eyes.

You can control the rotation of the camera between each eye with the `LCD_YAW` value.

An additional console variable `LCD_VIEWMODEL_SCALE` has been added to override the stereo separation of the weapon model. As this is very close to the camera, it can be difficult to focus on at all but the most conservative `LCD_X` values. When `LCD_VIEWMODEL_SCALE` is set to 1 (the default), it appears in full 3D as per regular Quake. By setting it to 0, the 3D effect is completely removed, and the weapon is fixed in the middle of the display as when playing Quake with the stereoscopic rendering mode disabled. Setting the value to somewhere between 0 and 1 will preserve the weapon's 3D appearance, without making the game unpleasant to play.

### Quake 2

* `cl_stereo` Selects the stereoscopic rendering mode
* `cl_stereo_separation` Camera offset
* `cl_stereo_anaglyph_colors` Colour of the anaglyph glasses

The software renderer and OpenGL renderer both support row interleaved 3D. The OpenGL renderer also supports native stereoscopic rendering if the hardware supports along with column interleaved, pixel interleaved and anaglyph modes.

When using the software renderer, set cl_stereo to 0 to render normally and non-zero (e.g. 1) to enable the row interleaved mode.

The modes are as follows for the OpenGL renderer:

|`cl_stereo` value|Mode|
|-----------------|----|
|0|Stereoscopic rendering disabled|
|1|OpenGL native stereoscopic rendering (hardware permitting)|
|2|Anaglyph (coloured glasses)|
|3|Row interleaved|
|4|Column interleaved|
|5|Pixel interleaved|

When using the anaglyph mode (`cl_stereo` set to 2) you can set the colour of the glasses with the `cl_stereo_anaglyph_colors` variable. This is a two-character string that specifies the initials of the colours of the two lenses. The default setting is `rc`, which corresponds to glasses with a red filter on the left eye and a cyan filter on the right eye. The available colours are **b**lue, **c**yan, **g**reen, **m**agenta, **r**ed and **y**ellow. The `cl_stereo_anaglyph_colors` variable is not case sensitive.

`cl_stereo_separation` controls the offset of the camera; the larger the value, the further the camera is moved between the generating the view from each eye. A negative value swaps the left and right eyes.

## Known issues

Quake and Quake II use an 8-bit video mode. When played full-screen, they assume that they are in full control of the palette; Windows, however, will sometimes overwrite the palette, resulting in scrambled colours. In Quake you may be able to avoid the issue by passing the `-dibonly` command-line switch and disabling multi-monitor modes if you are using them (consult the original WinQuake documentation for further information about video card compatibility). Typing `vid_restart` into Quake II's console may also help, though not always the first time you type it in.

Users of other games that have the same palette issues when using DirectDraw claim that terminating all instances of explorer.exe before running the game may also help, though this is a bit drastic.
