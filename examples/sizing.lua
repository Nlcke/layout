local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	--cellRelW = 0.5, cellRelH = 0.5,
	cellAbsW = 320, cellAbsH = 240,
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "parent absolute:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "absW = 320", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "absH = 240", "|"),
		},	
		absW = 320, absH = 240,
		
		relX = 0, relY = 0,
		bgrC = 0x0000FF, bgrA = 0.5,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "parent relative:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "relW = 0.3", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "relH = 0.6", "|"),
		},	
		relW = 0.3, relH = 0.6,
		
		relX = 0, relY = 0.4,
		bgrC = 0xFF0000, bgrA = 0.5,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "cell absolute:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "col = 0.5", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "row = 0.5", "|"),
		},	
		relW = 0.5, relH = 0.5,
		
		relX = 0.5, relY = 0.0,
		bgrC = 0x000000, bgrA = 0.5,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "cell relative:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "col = 0.5", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "row = 0.5", "|"),
		},
		col = 1.0, row = 1.0,
		relX = 0.5, relY = 0.5,
		bgrC = 0x00FF00, bgrA = 0.5,
	},
}

stage:addChild(layout)