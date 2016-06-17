Button = Layout:with{
	text = "BUTTON", textColor = 0xFFFFFF;
	absW = 200, absH = 100,
	absX = 0, absY = 0,
	bgrC = 0x0088AA,
	bgrA = 1.0,
	
	init = function(self, p)
		self.textfield = TextArea.new(font, self.text, "|")
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

local database = {}
for i = 1, 1e6 do database[i] = {text = " Button "..i.." "} end

local layout = Layout.new{
	bringToFront = function() end,
	template = Button, database = database,
	scroll = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsW = 200, cellAbsH = 50,
	borderW = 5, borderH = 5,
	cols = 1000, rows = 0,
}

stage:addChild(layout)