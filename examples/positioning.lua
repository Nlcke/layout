local Sticker = Layout:with{
	bgrC = 0x000000, bgrA = 0.5,
	relW = 0.4, relH = 0.4,
	text = "",
	init = function(self)
		local a, b, c = self.text:match"(.+\n)(.+\n)(.+)"
		self:addChild(Layout.new{sprM = Layout.LETTERBOX, sprS = 0.9,
			relH = 1/3, relY = 0/3, TextField.new(font, a, "|")})
		self:addChild(Layout.new{sprM = Layout.LETTERBOX, sprS = 0.9,
			relH = 1/3, relY = 1/3, TextField.new(font, b, "|")})
		self:addChild(Layout.new{sprM = Layout.LETTERBOX, sprS = 0.9,
			relH = 1/3, relY = 2/3, TextField.new(font, c, "|")})
	end
}

local layout = Layout.new{
	cellRelW = 0.4, cellRelH = 0.4,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Sticker.new{text = "absolute\nabsX = 10\nabsY = 20",
		absX = 10, absY = 20, bgrC = 0x0000FF},
	Sticker.new{text = "relative\nrelX = 0.55\nrelY = 0.55",
		relX = 0.55, relY = 0.55, bgrC = 0xFF0000},
	Sticker.new{text = "anchored\nancX = 0.1\nancY = 0.85",
		ancX = 0.1, ancY = 0.85, bgrC = 0x000000},
	Sticker.new{text = "snapped\ncol = 1.25\nrow = 0.05",
		col = 1.25, row = 0.05, bgrC = 0x00FF00},
}

stage:addChild(layout)