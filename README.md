# Layout
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
* Resource loader

## Table of Contents
* [Installation](#installation)
* [Hello, world!](#hello-world)
* [Layout API:](#layout-api)
  * [`Layout.new(p)`](#layout-new)
  * [`Layout:with(p)` and `Layout:with(old, new)`](#layout-with)
  * [`Layout:update([p]`)](#layout-update)
  * [`Layout(id)`](#layout-id)
  * [`Layout(col, row)`](#layout-col-row)
  * [`Layout.select(sprite)`](#layout-select)
  * [`Layout:play(animation [,state] [,callback])`](#layout-play)
  * [`Layout.newAnimation([frames] [,mark] [,strength] [,seed])`](#layout-new-animation)
* [Layout Keys](#layout-keys)
* [Resource Loader API](#resource-loader-api)
* [Animation:](#animation)
  * [Special Keys](#special-keys)
  * [Standard Keys](#standard-keys)
  * [Playing](#playing)
* [MIT License](#mit-license)

## <a name = "installation">Installation</a>
Copy `Layout.lua` file to your Gideros project and you will get access to `Layout` class without the need to require it. If you want to look at Layout examples then just download everything from this git and open `Layout.gproj` in Gideros Studio.

## <a name = "hello-world">Hello, world!</a>
```lua
layout = Layout.new{} -- create empty layout
stage:addChild(layout)      -- add it to the stage
textfield = TextField.new(nil, "Hello, World!", "|")
layout:update{textfield}            -- update layout
```
### <a name = "layout-api">Layout API</a>
#### <a name = "layout-new">Layout.new(p)</a>
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
#### <a name = "layout-with">Layout:with(p) and Layout:with(old, new)</a>
Extends Layout or Layout-based class with new settings and returns new class. Accepts one (`p`) or two parameters (`old`, `new`) which should be tables. Resulting class can be instantiated (`new`) or extended (`with`).

All existing settings will be silently overridden and new keys will be silently created when only one parameter `p` is used. If you don't know Layout structure well, it's recommended to use second form of `with` (`Layout:with(old, new)`) i.e. split parameters into two tables where first table `old` allows only override keys and second table `new` allows only create new keys.

There are 3 special callback-keys which you can optionally use in `p` table to make your classes more flexible:
* `init(self, p)` -- called at class instantiation
* `ext(self, child)` -- called at children adding
* `upd(self, p)` -- called at layout update

Examples:
```lua
Button = Layout:with{
	text = "BUTTON", textColor = 0xFFFFFF;
	absW = 200, absH = 100,
	absX = 0, absY = 0,
	bgrC = 0x0088AA,
	bgrA = 1.0,
	
	init = function(self, p)
		self.textfield = TextField.new(font, self.text, "|")
		self.textfield:setTextColor(self.textColor)
		table.insert(p, self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text, "|") end
	end,
	
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self) print(self.text, self.col, self.row) end
}

RedButton = Layout:with({ -- only for overridden keys
	bgrC = 0xFF0000,
	},{ -- only for new keys
	isRedButton = true
})

local button = Button.new{}
stage:addChild(button)

local redbutton = RedButton.new{}
stage:addChild(redbutton)
```
#### <a name = "layout-update">Layout:update([p])</a>
Updates existing layout with new settings from optional settings table `p` and/or adds children with numeric indexes from it. Most common way to use it:
```lua
layout:update{
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
Or you can pass a table with settings to it:
```lua
local settings = {child1, child2, ... childN, setting1 = value1, setting2 = value2, ... settingN = valueN}
layout:update(settings)
```
You should call `update` (without any arguments) after you finished modification of template grid database via `layout(col, row)` or `layout.database[i]` in order to update the cells:
```lua
local database = {{absX = 10}, {absX = 20}, {absX = 30}}
local layout = Layout.new{cols = 1, template = Layout, database = database}
stage:addChild(layout)
local cell = layout(1, 2)
cell.absX = 100
database[3].absX = 300
layout:update()
```
#### <a name = "layout-id">Layout(id)</a>
Each layout and sprite can have optional `id` key to access it from it's parent layout where `id` key can be any value. It's convenient if you want to create complex layout in declarative way (like HTML or XML):
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
editor "menu" "button2":update{bgrC = 0xFF00FF}
editor "menu" "button3":update{absX = 100}
```
#### <a name = "layout-col-row">Layout(col, row)</a>
Each layout and sprite can have optional `col` and `row` numeric keys when used as a cell inside parent layout so you can access them using that keys:
```lua
grid = Layout.new{
	cellAbsW = 200, cellAbsH = 100,
	Layout.new{col = 0, row = 0, TextField.new(nil, "Cell [0, 0]", "|")},
	Layout.new{col = 1, row = 0, TextField.new(nil, "Cell [1, 0]", "|")},
    Layout.new{col = 0, row = 1, TextField.new(nil, "Cell [0, 1]", "|")},
    Layout.new{col = 1, row = 1, TextField.new(nil, "Cell [1, 1]", "|")},
    Layout.new{col = 0.5, row = 0.5, TextField.new(nil, "Cell [0.5, 0.5]", "|")},
}
grid(0, 0):update{bgrA = 0.5}
grid(0.5, 0.5):update{bgrA = 0.8}
```
If template grid used then you will get a table from database, not an layout. In this case you need to call `updateTemplateGrid` method in order to update the scene.:
```
database = {}
for i = 1, 1000 * 1000 do
    database[i] = {bgrC = math.random(0, 0xFFFFFF), bgrA = 1.0}
end
grid = Layout.new{
    template = Layout, database = database,
    scroll = true,
    cellAbsW = 200, cellAbsH = 50,
    cols = 1000, rows = 1000,
}
grid(20, 10).bgrC = 0xFF0000
grid(10, 14).bgrC = 0x00FF00
grid:updateTemplateGrid()
```
NOTE: In Layout cols and rows are 0-based and can be floating point numbers i.e. you just define cell position (`col` as X and `row` as Y relative to cell definition in parent layout). This way you can place cells anywhere and in any order.
#### <a name = "layout-select">Layout.select(sprite)</a>
Sets focus on a sprite. You will the selector above the sprite. Selector will have colors and alphas defined in layout `selLineC`, `selLineA`, `selFillC`, `selFillA` keys.
Examples:
```lua
layout = Layout.new{}
Layout.select(layout)
```
#### <a name = "layout-play">Layout:play(animation [,state] [,callback])</a>
Plays an `animation` if it is a table, optionally can animate `state` transitions and if specified a `callback` function will be executed at the end of animation. See Animation section for full description of available `animation` parameters. If defined `state` must be a table with numeric keys supported by this Layout class.
Or instantly stops currently playing animation if `animation` is `false`.
Examples:
```lua
local layout = Layout.new{bgrA = 1.0, bgrC = 0xFF0000, absX = 0, absY = 200}
stage:addChild(layout)
local animation = Layout.newAnimation()
local state = {absX = 400, absY = 0}
local callback = function(self) print(self.absX, self.absY) end
layout: play(animation, state, callback)
```
#### <a name = "layout-new-animation">Layout.newAnimation([frames] [,mark] [,strength] [,seed])</a>
Creates new random animation. See description of `frames`, `mark` and `strength` keys at Animation section. `seed` parameter is a random seed which can be used to get same animation each time.
Examples:
```lua
local animation1 = Layout.newAnimation()
local animation1 = Layout.newAnimation(30)
local animation1 = Layout.newAnimation(20, 0.5)
local animation1 = Layout.newAnimation(60, 20, 0.3)
local animation1 = Layout.newAnimation(20, -1, 0.3, 343234234)
```
### <a name = "layout-keys">Layout Keys</a>
```lua
-- scale modes for Layout.texM and Layout.sprM
NO_SCALE   = 0,
LETTERBOX  = 1,
STRETCH    = 2,
FIT_WIDTH  = 3,
FIT_HEIGHT = 4,
CROP       = 5,

-- anchored (to width and height of parent) positioning
ancX = 0.5, -- anchored X, [number]
ancY = 0.5, -- anchored Y, [number]
-- relative (to width and height of parent) positioning
relX = false, -- relative X, [false|number]
relY = false, -- relative Y, [false|number]
-- absolute positioning (disables relative and anchored one)
absX = false, -- absolute X, [false|number]
absY = false, -- absolute X, [false|number]

-- relative (to width and height of parent) size
relW = 1.0,
relH = 1.0,
-- absolute size (disables relative and anchored one)
absW = false,
absH = false,
-- 	relative width/height restriction 
limW = false, -- maximal width/height aspect ratio, [0..]
limH = false, -- maximal height/width aspect ratio, [0..]

-- relative content size
conRelW = 1, -- content width relative to parent, [number]
conRelH = 1, -- content height relative to parent, [number]
-- absolute content size (disables relative width and/or height)
conAbsW = false, -- content absolute width (in pixels), [false|number]
conAbsH = false, -- content absolute height (in pixels), [false|number]

-- template grid (template and database should be both enabled)
template = false, -- Layout or Layout-based class
database = false, -- list of cells' parameters
colsFill = false, -- columns will be filled first if true

-- manual and template grid
cols = 0, -- grid cols number, [0..]
rows = 0, -- grid rows number, [0..]
cellBrdW = 0.0, -- cell border width in pixels
cellBrdH = 0.0, -- cell border height in pixels
cellRelW = 1.0, -- cell relative width for children layouts
cellRelH = 1.0, -- cell relative width for children layouts
cellAbsW = false, -- cell absolute width for children layouts
cellAbsH = false, -- cell absolute height for children layouts

-- grid cell settings
col = false, -- cell column number, [number|false]
row = false, -- cell row number, [number|false]
cellW = 1.0, -- cell width relative modifier
cellH = 1.0, -- cell height relative modifier

-- selector
selector = Layout.new{bgrA = 0.25}, -- [Layout]
selectable = true, -- can be selected by keyboard/joystick, [true|false]
selectedCol = 0, -- col to select grid cell
selectedRow = 0, -- row to select grid cell

-- background
bgrC = 0x000000, -- background color, [0x000000..0xFFFFFF]
bgrA =      0.0, -- background alpha, [0..1]

-- texture
texture = false, -- texture object, [Texture|false]
texC = 0xFFFFFF, -- texture color, [0x000000..0xFFFFFF]
texA    = 1.0,      -- texture alpha, [0..1]
texM    =   1, -- texture scale mode (default: LETTERBOX), [number]
texS    = 1.0,   -- texture scale, [number]
texAncX = 0.5,   -- texture anchored X, [0..1]
texAncY = 0.5,   -- texture anchored Y, [0..1]
texOffX = 0.0,   -- texture X offset (in pixels)
texOffY = 0.0,   -- texture Y offset (in pixels)

-- non-layout children sprites
sprM    =   1, -- sprite scale mode (default: LETTERBOX), [number]
sprS    = 1.0,   -- sprite scale
sprAncX = 0.5, -- sprite anchored X, [0..1]
sprAncY = 0.5, -- sprite anchored Y, [0..1]
sprOffX = 0.0, -- sprite X offset (in pixels)
sprOffY = 0.0, -- sprite Y offset (in pixels)

-- relative center (affects rotation and scaling)
centerX = 0.5, -- [0..1]
centerY = 0.5, -- [0..1]

-- identification
id = false, -- to get child by id with 'layout(id)' call

-- inheritance
init = false, -- callback at instantiation (useful for custom classes)
	-- [false|function(self, parameters)]
ext  = false, -- callback at children adding (to modify them)
	-- [false|function(self, child)]
upd  = false, -- callback at updating (useful for custom classes)
	-- [false|function(self, parameters)]

-- keyboard control, can have multiple keys for the same action
keys = { -- [realCode] = action
	[16777234] =   "LEFT", -- jump to leftward cell
	[16777235] =     "UP", -- jump to upward cell
	[16777236] =  "RIGHT", -- jump to rightward cell
	[16777237] =   "DOWN", -- jump to downward cell
	[16777220] = "SELECT", -- enter the layout or press it
	[16777219] =   "BACK", -- return to parent layout or stage
	
	-- mouse wheel for "UP" and "DOWN" actions
	mouseWheel = true,
},

-- gamepad control, can have multiple buttons for the same action
buttons = { -- [keyCode] = action
	[19] = "UP",
	[20] = "DOWN",
	[22] = "RIGHT",
	[21] = "LEFT",
	[96] = "SELECT",
	[97] = "BACK",
	
	-- left stick for "UP", "DOWN", "RIGHT", "LEFT" actions
	stickDeadzone = 0.5, -- [0..1], stick disabled at 1
},

-- moving/scrolling
moveReactionX =   1, -- reaction coefficient for X while layout dragged
moveReactionY =   1, -- reaction coefficient for Y while layout dragged
moveDeadzone  =   5, -- moving/scrolling starts outside this zone, [0..]
moveFriction  = 0.5, -- friction coefficient while layout dragged
moveDamping   = 0.9, -- damping coefficient while layout released
moveDelta     =   1, -- area side to detect moving/scrolling, [0..]

-- scrolling
scrollFrames = 20, -- animation frames for keyboard or joystick scroll

-- scaling
scaleMouseResp = 0.005, -- scale response for mouse
scaleTouchResp = 0.005, -- scale response for touch
scaleMin       =   0.2, -- scale minimal value
scaleMax       =   2.0, -- scale maximal value

-- tilting
tiltMouseResp = 1, -- tilt response for mouse
tiltTouchResp = 1, -- tilt response for touch

events = true, -- enable mouse/touch events, [false|true]

-- event callbacks
onAdd    = false, -- callback at added to stage event, [false|function]
onRemove = false, -- callback at removed from stage event, [false|function]
onHover  = false, -- callback at mouse hovering, [false|function]
onPress  = false, -- callback at LMB or touch press, [false|function]
onHold   = false, -- callback at LMB or touch while hold, [false|function]
onMove   = false, -- callback at layout moving, [false|function]
onScroll = false, -- callback at layout scrolling, [false|function]
onBack   = false, -- callback at "BACK" action, [false|function]
onResize = false, -- callback at changing size, [false|function]

-- built-in callbacks
scroll = false, -- move children with mouse or touch, [false|true]
move   = false, -- move layout with mouse or touch, [false|true]
scale  = false, -- scale layout with RMB or double touch, [false|true]
tilt   = false, -- tilt layout with RMB or double touch, [false|true]

-- animation
anAdd    = false, -- opening animation (mark=0)
anRemove = false, -- ending animation (mark=-1)
anPress  = false, -- press animation (mark>0)
anHover  = false, -- hover animation (mark>0)
```

### <a name = "resource-loader-api">Resource Loader API</a>
Layout has optional resource loader	to automatically load various resources.
From the box it supports .jpg, .png, .wav, .mp3, .ttf, .otf, .lua, .json.
Resource Loader returs a table with resources, their names and indexes where
resources can be accessed with t[integer_number] or t[resource_name] and
resource name can be received with negative index i.e. t[-integer_number].

It has following interface:

`Layout.newResources(p)` where `p` is a table with following parameters:
```lua
path    = string  -- path to directory with resources
subdirs = boolean -- load resources from subdirectories
names   = string  -- table of names to filter directory files
from    = number  -- index of first resource file to load
to      = number  -- index of last resource file to load
output  = boolean -- print list of resource files
namemod = function(name, path, base, ext, i) -- to filter file names
onlynames = boolean -- instead of resources return filenames

textureFiltering = boolean
textureOptions   = table
fontSize         = number
fontText         = text
fontFiltering    = boolean
```
Examples:
```lua
local examples = Layout.newResources{
	path = "|R|examples",
	namemod = function(name, path, base, ext, i) return base end
}
```
### <a name = "animation">Animation</a>
Animation should be a table and only the following special and standard keys are supported for it otherwise you will get an error.

#### <a name = "special-keys">Special keys:</a>
* `frames` defines animation length in frames. Should be an integer number greater than 0 or you will get an error message.
* `mark` defines the type of animation and accepts following values:
  * `-1` for ending animation from initial state to new one
  * `0` for opening animation from new state to initial one
  * `0..` for three-phase animation from initial state to new state and to initial state. If it is greater or equal to `1` then this number will be used as a mark at which animation will be reverted back. If it is between `0` and `1` then it will be multiplied on the number of `frames` first.
* `strength` is optional key which defines multiplier for time parameter (range of time is [0..1]) to change animation range. Equal to `1` if not defined.

#### <a name = "standard-keys">Standard keys:
* `x`
* `y`
* `anchorX`
* `anchorY`
* `rotationX`
* `rotationY`
* `scaleX`
* `scaleY`
* `rotation`
* `alpha`
* `redMultiplier`
* `greenMultiplier`
* `blueMultiplier`
* `alphaMultiplier`

They are standard because they are the same as for `Sprite.set` method. However they are not absolute as for Sprite. They are relative to _initial_ state of layout and some of them changed to better fit in `[0..1]` relative time range. For each of them `0` value means no change. For `x`, `y`, `anchorX`, `anchorY` values will be multiplied to width and height of animated layout and `rotation` will be multiplied by 360 degrees.

Each standard key is optional and can be either `number` or `function`.

If `function` key used it must receive one numeric value and return one numeric value. Most of standard `math` library functions are supported.

#### <a name = "playing">Playing</a>
Animation can be played via `Layout:play(animation, state, callback)` method or can be assigned to built-in animation events:
* `anAdd` -- opening animation when added to a parent
* `anRemove` -- ending animation when removed from a parent
* `anPress` -- three-phase animation when layout pressed
* `anHover` -- three-phase animation when layout hovered

NOTE: you can animate any numeric key of Layout if you pass a table with new `state` to `Layout.play` i.e. you can animate `absX`, `col`, `sprX` etc. This works for Layout-based classes too if they have defined their numeric keys in `upd` function. 

Examples:
```lua
-- rotates and changes X anchor position when added to parent
local layout1 = Layout.new{
    bgrA = 1.0,
    anAdd = {frames = 60, mark = 0, rotation = 1, anchorX = 1}
}
stage:addChild(layout1)

-- horizontally scales and changes alpha when removed from parent
local layout2 = Layout.new{
    bgrA = 1.0,
    anRemove = {frames = 60, mark = -1, scaleX = math.log, alpha = math.sqrt}
}
stage:addChild(layout2)
layout2:removeFromParent()

-- this layout get random animation which will be played with 'play' method
local layout3 = Layout.new{
    bgrA = 1.0,
}
stage:addChild(layout3)
local animation = Layout.newAnimation()
layout3: play(animation)
```
## <a name = "mit-license">MIT License</a>
Copyright (c) 2016 Nikolay Yevstakhov

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
