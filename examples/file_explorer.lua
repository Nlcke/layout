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


local layout, panel1, panel2

Button = Layout:with{
	text = "BUTTON",
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
		elseif path == "" then
			path = self.text
		else
			path = path .. "/" .. self.text
		end
		
		filenames = Layout.newResources{
			path = path,
			onlynames = true,
			namemod = function(name, path, base, ext, i) return base..ext end
		} or ""
		
		if path == "" then filenames = rootnames end
		local database = path == "" and {} or {{text = ".."}}
		for i = 1, #filenames do database[#database+1] = {text = filenames[-i]} end
		
		panel2:update{database = database}
		panel1:removeFromParent()
		layout:addChild(panel2)
		panel1, panel2 = panel2, panel1
		Layout.select(panel1)
	end,
	
	onBack = function(self, parent)
		if path == "" then
			
		else
			self.onPress{text = ".."}
		end
	end
}

panel1 = Layout.new{
	template = Button,
	database = database,
	bringToFront = function() end,
	scroll = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsH = 50,
	borderW = 5, borderH = 5,
	cols = 1,
}

panel2 = Layout.new{
	template = Button,
	database = database,
	bringToFront = function() end,
	scroll = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsH = 50,
	borderW = 5, borderH = 5,
	cols = 1,
}

Layout.select(panel1)

layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	panel1
}

stage:addChild(layout)