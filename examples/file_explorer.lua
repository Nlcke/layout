local lfs = require "lfs"

local roots = {}
for name in lfs.dir "/." do
	local root = "/"..name
	local att = lfs.attributes(root)
	if att and att.mode == "directory" then
		table.insert(roots, root)
	end
end
for i, name in ipairs(roots) do roots[-i] = name end

local function getDisks()
	local lfs = require "lfs"
	local disks = {}
	for i = 65, 90 do
		local letter = string.char(i)
		local att = lfs.attributes(letter..":/.")
		if att then table.insert(disks, letter..":") end
	end
	for i, name in ipairs(disks) do disks[-i] = name end
	return #disks > 0 and disks
end

local rootnames = getDisks() or roots
local path = ""
local filenames = rootnames
local database = path == "" and {} or {{text = ".."}}
for i = 1, #filenames do database[#database+1] = {text = filenames[-i]} end
local callback = print
local levels = {0}

local layout, panel1, panel2, slider

local Button = Layout:with{
	text = "",
	textColor = 0xFFFFFF,
	bgrC = 0x0088AA, bgrA = 1.0,
	
	init = function(self, p)
		self.textfield = TextField.new(font, self.text, "|")
		self.textfield:setTextColor(self.textColor)
		self:addChild(self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text, "|") end
	end,
	
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self)
		if filenames[self.text] and filenames[self.text]:sub(-1, -1) ~= "/" then
			return callback(path.."/"..self.text)
		end
		
		if self.text == ".." then
			if path:find"/" then
				path = path:sub(1, #path - path:reverse():find"/")
			else
				path = ""
			end
			levels[#levels] = nil
		elseif path == "" then
			path = self.text
			levels[#levels] = panel1.selectedRow
			levels[#levels+1] = 0
		else
			path = path .. "/" .. self.text
			levels[#levels] = panel1.selectedRow
			levels[#levels+1] = 0
		end
		
		filenames = Layout.newResources{
			path = path,
			onlynames = true,
			namemod = function(name, path, base, ext, i) return base..ext end
		} or ""
		
		if path == "" then filenames = rootnames end
		local database = path == "" and {} or {{text = ".."}}
		for i = 1, #filenames do database[#database+1] = {text = filenames[-i]} end
		
		panel1:removeFromParent()
		layout:addChild(panel2)
		panel2:update{database = database, selectedRow = levels[#levels]}
		slider"handle":update{
			ancY = panel2.offY / panel2.scrH,
			relH = panel2.h / panel2.conH
		}
		slider:play{frames = 60, mark = 0, x = 1, alpha = -1}
		Layout.select(panel2)
		
		panel1, panel2 = panel2, panel1
	end,
	
	onBack = function(self, parent)
		if path == "" then
			if stage:getNumChildren() == 2 then
				local l1, l2 = stage:getChildAt(1), stage:getChildAt(2)
				local backbutton = l1 ~= layout and l1 or l2
				backbutton:onPress()
			end
		else
			self.onPress{text = ".."}
		end
	end
}

local sliderWidth = 0.03

local Panel = Layout:with{
	template = Button,
	database = database,
	scroll = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsH = 50,
	cellBrdH = 5,
	cols = 1,
	relW = 1 - sliderWidth, relX = 0,
	onScroll = function(self)
		slider"handle":update{ancY = self.offY / self.scrH}
	end,
	onResize = function(self)
		slider"handle":update{relH = self.h / self.conH}
	end
}

panel1, panel2 = Panel.new{}, Panel.new{}

slider = Layout.new{
	bgrC = 0x000000, bgrA = 0.5,
	ancX = 1.0,
	relW = sliderWidth,
	
	Layout.new{
		id = "handle",
		ancX = 0, ancY = 0,
		relW = 1.00, relH = 0.05,
		bgrC = 0x00BBFF, bgrA = 1.0,
		move = true,
		onMove = function(self)
			panel1:update{offY = panel1.scrH * self.ancY}
		end,
	}
}

layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	panel1,
	slider
}

Layout.select(panel1)

stage:addChild(layout)