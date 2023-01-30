# gpl-2-basepart

A very simple Roblox module that will convert a gpl palette into a set of baseparts (or a table if you wish to do that too).

The module comes with two functions, GPL2Table and GPL2Parts

## module.GPL2Table

In: StringValue object or String, this should be a valid gpl palette.
Out: Table with information regarding the palette, the information is as follows
PaletteName: PaletteName if it was able to fetch it, if not defaults to "No Name"
Description: Palette description if it's able to fetch it, if not defaults to "No Description"
Colors: The amount of colors the palette uses
PaletteValues: The meat of the whole table, contains every color in the palette in Color3

## module.GPL2Parts
In: StringValue object or String, this should be a valid gpl palette.
Out: A new model will appear in the workspace, the function will return a model

