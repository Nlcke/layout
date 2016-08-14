local layout = Layout.new{
	cellRelW = 0.4, cellRelH = 0.4,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "absolute:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "absX = 10", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "absY = 20", "|"),
		},
		
		absX = 10, absY = 20,
		
		bgrC = 0x0000FF, bgrA = 0.5,
		relW = 0.4, relH = 0.4,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "relative:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "relX = 0.55", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "relY = 0.55", "|"),
		},
		
		relX = 0.55, relY = 0.55,
		
		bgrC = 0xFF0000, bgrA = 0.5,
		relW = 0.4, relH = 0.4,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "anchored:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "ancX = 0.1", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "ancY = 0.85", "|"),
		},
		
		ancX = 0.1, ancY = 0.85,
		
		bgrC = 0x000000, bgrA = 0.5,
		relW = 0.4, relH = 0.4,
	},
	Layout.new{
		Layout.new{
			relH = 1/3, relY = 0/3, TextField.new(font, "gridsnapped:", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 1/3, TextField.new(font, "col = 1.25", "|"),
		},
		Layout.new{
			relH = 1/3, relY = 2/3, TextField.new(font, "row = 0.05", "|"),
		},
		
		col = 1.25, row = 0.05, 
		
		bgrC = 0x00FF00, bgrA = 0.5,
		relW = 0.4, relH = 0.4,
	},
}

stage:addChild(layout)