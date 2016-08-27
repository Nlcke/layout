Button = Layout:with{
	text = "BUTTON", textColor = 0xFFFFFF;
	absW = 200, absH = 100,
	absX = 0, absY = 0,
	bgrC = 0x0088AA,
	bgrA = 1.0,
	
	init = function(self, p)
		self.textfield = TextField.new(font, self.text, "|")
		self.textfield:setTextColor(self.textColor)
		self:addChild(self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text) end
	end,
	
	selector = Layout.new{
		texture = rightbuttonTexture,
		texA = 0.5, texAncX = 0,
		anAdd = {frames = 10, scaleX = math.sin}
	},
	anAdd = Layout.newAnimation(),
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self) print(self.text, self.col, self.row) end
}

local database = {}
for i = 1, 1e6 do database[i] = {text = " Button "..i.." "} end

local layout = Layout.new{
	template = Button, database = database,
	colsFill = true,
	scroll = true,
	anRemove = Layout.newAnimation(),
	cellAbsW = 200, cellAbsH = 50,
	cellBrdW = 5, cellBrdH = 5,
	cols = 1000, rows = 0,
}

Layout.select(layout)

stage:addChild(layout)