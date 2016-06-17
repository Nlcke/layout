local layout = Layout.new{
	cellRelW = 0.5, cellRelH = 0.5,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Layout.new{
		TextArea.new(font, "absolute"),
		absX = 0, absY = 0,
		
		bgrC = 0x0000FF, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
		Layout.new{
		TextArea.new(font, "relative"),
		relX = 0.5, relY = 0.5,
		
		bgrC = 0xFF0000, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
		Layout.new{
		TextArea.new(font, "anchored"),
		ancX = 0, ancY = 1,
		
		bgrC = 0x000000, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
		Layout.new{
		TextArea.new(font, "gridsnapped"),
		col = 1, row = 0, 
		
		bgrC = 0x00FF00, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
}

stage:addChild(layout)