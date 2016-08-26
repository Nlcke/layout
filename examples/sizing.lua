local Sticker = Layout:with{
	anAdd = Layout.newAnimation(),
	bgrC = 0x000000, bgrA = 1.0,
	relX = 0.0, relY = 0.0,
	move = true,
	text = "",
	init = function(self)
		local a, b, c = self.text:match"(.+\n)(.+\n)(.+)"
		self:addChild(Layout.new{sprS = 0.9,
			relH = 1/3, relY = 0/3, TextField.new(font, a, "|")})
		self:addChild(Layout.new{sprS = 0.9,
			relH = 1/3, relY = 1/3, TextField.new(font, b, "|")})
		self:addChild(Layout.new{sprS = 0.9,
			relH = 1/3, relY = 2/3, TextField.new(font, c, "|")})
	end
}

local layout = Layout.new{
	anRemove = Layout.newAnimation(),
	Sticker.new{text = "parent absolute:\nabsW = 320\nabsH = 240",
		absW = 320, absH = 240, relX = 0.0, relY = 0.0, bgrC = 0x0000FF},
	Sticker.new{text = "parent relative:\nrelW = 0.3\nrelH = 0.4",
		relW = 0.3, relH = 0.4, relX = 0.6, relY = 0.0, bgrC = 0xFF0000},
	Layout.new{
		cellAbsW = 320, cellAbsH = 240,
		Sticker.new{text = "cell absolute:\ncellAbsW = 320\ncellAbsH = 240",
			col = 0.1, row = 1.0, bgrC = 0x00FF00},
	},		
	Layout.new{
		cellRelW = 0.5, cellRelH = 0.25,
		Sticker.new{text = "cell relative:\ncellRelW = 0.5\ncellRelH = 0.25",
			col = 1, row = 3, bgrC = 0x00FFFF},
	}
}

stage:addChild(layout)