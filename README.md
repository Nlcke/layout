--# Layout
Layout is GUI framework for Gideros game engine.

## Features:
* User-friendly interface
* Fully customizable
* Mouse, touch, keyboard, joystick support
* Powerful animations
* Predefined events
* Easy-to-use inheritance
* Various scale modes
* Advanced positioning and sizing
* Template grids
* Kinetic scrolling and moving
* Move/Scale/Rotate for images' preview
* TextArea class as TextField replacement
* Resource loader

## Installation
Copy `Layout.lua` file to your Gideros project and you will get access to `Layout` and `TextArea` classes.

## Hello, world!
```lua
layout = Layout.new{} -- create empty layout
stage:addChild(layout)      -- add it to the stage
textarea = TextArea.new(nil, "Hello, World!")
layout{textarea}            -- update layout
```
### Layout API
#### Layout.new(p)
Creates new layout. Accepts only one parameter which must be a table with layout settings. Most common way to use it:
```lua
layout = Layout.new{
    child1,
    child2,
    ...
    childN,
    setting1 = value1,
    setting2 = value2,
    ...
    settingN = valueN
}
```
Alternatively you can create a table with settings and pass it to layouts later:
```lua
settings = {child1, child2, ... childN, setting1 = value1, setting2 = value2, ... settingN = valueN}
layout1 = Layout.new(settings)
layout2 = Layout.new(settings)
```
Or you can create empty layout with default settings and update it afterwards:
```lua
layout = Layout.new{}
layout{child1, child2, ... childN, setting1 = value1, setting2 = value2, ... settingN = valueN}
```
Each integer key will be treated as a child to add and other keys will be treated as settings.
NOTE: It is an error to use it without any parameters (`Layout.new()`) or call it with multiple arguments (`Layout.new(a, b, c)`).
#### Layout:with(p)
Extends Layout or Layout-based class with new settings and returns new class. Accepts only one parameter `p` which should be a table. All settings from this table will override existing parameters or create new ones. Resulting class can be instantiated (`new`) or extended (`with`).

There are 3 special callback-keys which you can optionally use in `p` table to make your classes more flexible:
* `init(self, p)` -- called at class instantiation
* `ext(self, child)` -- called at children adding
* `upd(self, p)` -- called at layout update

All existing settings will be overridden silently so it's recommended to check parent class first if you don't know it's structure well. For example, if you want to add `buttonText` key to `Layout` class you can do `assert(Layout.buttonText)` to check if it exists.

Examples:
```lua

```
#### Layout(p)
Updates existing layout with new settings if parameter `p` is a table. Most common way to use it:
```lua
layout{
    child1,
    child2,
    ...
    childN,
    setting1 = value1,
    setting2 = value2,
    ...
    settingN = valueN
}
```
Or pass a table with settings to it:
```lua
local settings = {child1, child2, ... childN, setting1 = value1, setting2 = value2, ... settingN = valueN}
layout(settings)
```
#### Layout(id)
Each layout can have optional `id` key to access it from it's parent where `id` can be any value except a table (or it will be updated instead!). It's convenient if you want to create complex layout in declarative way (like HTML or XML):
```lua
editor = Layout.new{
	Layout.new{id = "menu",
    	Layout.new{id = "button1"},
        Layout.new{id = "button2"},
        Layout.new{id = "button3"}
    },
    Layout.new{id = "textfield"},
    Layout.new{id = "statusbar"},
}
editor "menu" "button2" {bgrC = 0xFF00FF}
editor "menu" "button3" {absX = 100}
```
#### Layout(col, row)
Each layout can have optional `col` and `row` numeric keys when used as a cell inside parent layout so you can access them using that keys:
```lua
grid = Layout.new{
	cellAbsW = 200, cellAbsH = 100,
	Layout.new{col = 0, row = 0, TextArea.new(nil, "Cell [0, 0]"},
	Layout.new{col = 1, row = 0, TextArea.new(nil, "Cell [1, 0]"},
    Layout.new{col = 0, row = 1, TextArea.new(nil, "Cell [0, 1]"},
    Layout.new{col = 1, row = 1, TextArea.new(nil, "Cell [1, 1]"},
    Layout.new{col = 0.5, row = 0.5, TextArea.new(nil, "Cell [0.5, 0.5]"},
}
grid(0, 0){bgrA = 0.5}
grid(0.5, 0.5){bgrA = 0.8}
```
If template grid used then you will get a table from database, not an layout:
```
database = {}
for i = 1, 1000 * 1000 do
    database[i] = {bgrC = math.random(0, 0xFFFFFF), bgrA = 1.0}
end
grid = Layout.new{
    template = Layout, database = database,
    scroll = true, content = true,
    cellAbsW = 200, cellAbsH = 50,
    cols = 1000, rows = 1000,
}
grid(20, 10).bgrC = 0xFF0000
grid(10, 14).bgrC = 0x00FF00
grid:updateTemplateGrid()
```
I this case you need to call `updateTemplateGrid` method in order to update the scene.

NOTE: In Layout cols and rows are 0-based and can be floating point numbers i.e. you just define cell position (`col` as X and `row` as Y relative to cell definition in parent layout). This way you can place cells anywhere and in any order.

#### Layout:play(animation [,state] [,callback])


#### Layout:updateTemplateGrid()
Visual update of template grid. Must be called after you updated it's cells.

#### Layout.select(sprite)
Sets focus on a sprite.

#### Layout.newAnimation([frames] [,mark] [,strength] [,seed])
Creates new random animation. 

### TextArea API
```lua
TextArea class is superpowered version of TextField.
TextArea has normal anchoring as opposed to TextField and supports multiline
text with different alignment modes and first-line indentation.
TextArea can be created with:
TextArea.new(font, text, sample, align, width, letterspace, linespace)
where
	font        = TTFont | Font
	text        = string
	sample      = string | nil
	align       = "L" | "C" | "R" | "J" | nil
	width       = number | nil
	letterspace = number | nil
	linespace   = number | nil
TextArea has following setters and getters:
	setText          - getText
	setSample        - getSample
	setAlignment     - getAlignment
	setLetterSpacing - getLetterSpacing
	setLineSpacing   - getLineSpacing
	setTextColor     - getTextColor
```

### Resource Loader API
```lua
Layout.loadFromPath(p)

Layout has optional resource loader	to automatically load various resources.
From the box it supports .jpg, .png, .wav, .mp3, .ttf, .otf, .lua, .json.
Resource Loader returs a table with resources, their names and indexes where
resources can be accessed with t[integer_number] or t[resource_name] and
resource name can be received with negative index i.e. t[-integer_number].
It has following interface:
Layout.loadFromPath{...} where {...} is a table with following parameters:
	path    = string  -- path to directory with resources
	subdirs = boolean -- load resources from subdirectories
	names   = string  -- table of names to filter directory files
	from    = number  -- index of first resource file to load
	to      = number  -- index of last resource file to load
	output  = boolean -- print list of resource files
	namemod = function(name, path, base, ext, i) -- to filter file names
	textureFiltering = boolean
	textureOptions   = table
	fontSize         = number
	fontText         = text
	fontFiltering    = boolean
``` 
    
### Animation
```lua
to describe animation a table with the following keys must be used:
-- 'frames' key --
defines animation length
if 'frames' is not exist or is 0 or less then you will get error message

-- 'mark' key --
defines the type of animation
it accepts following values: [-1|0|0..1|1..]
if 'mark' is -1 then it's ending animation (from initial state to new)
if 'mark' is 0 then it's opening animation (from new state to initial)
if 'mark' is greater than 0 then animation will be played as
initial -> new -> initial and 'mark' defines 'initial -> new' length
if 'mark' is in [0..1] range then it will relative to 'frames'
if 'mark' is in [1..frames] then it will be used as is
if 'mark' is in [frames..] then their values will be swapped

-- 'strength' key --
defines multiplier for t (time) parameter to change animation range
equal to 1 if not defined

-- other animation keys --
key names are same as Sprite.set accepts:
	x, y, rotation, rotationX, rotationY, scaleX, scaleY, alpha,
	redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier
key values can be [nil|number|function]
all keys are relative to initial state of layout i.e. 0 means no change

-- numeric keys --
each number will be multiplied by t (time) and added to origin,
where t is time (frame / frames) in range [0..1]

-- function-keys --
function must accept one parameter t (time), where t = [0..1]
function must return a number (delta) based on that parameter t
result of function will be multiplied by t and added to original value

-- x, y, anchorX, anchorY --
this parameters are relative to width and height of the layout

-- rotation --
rotation will be multiplied by 360 (1.0 = 360, -0.5 = -180, etc)
```