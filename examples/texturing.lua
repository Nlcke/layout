local layout = Layout.new{
	cellRelW = 0.2, cellRelH = 0.5,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.FIT_ALL,
		TextArea.new(font, "texM = Layout.FIT_ALL", "|", "C"),
		col = 0, row = 0,
	},
		Layout.new{
		texture = skyworldTexture,
		texM = Layout.STRETCH,
		TextArea.new(font, "texM = Layout.STRETCH", "|", "C"),
		col = 1, row = 0,
	},
		Layout.new{
		texture = skyworldTexture,
		texM = Layout.FIT_WIDTH,
		TextArea.new(font, "texM = Layout.FIT_WIDTH", "|", "C"),
		col = 2, row = 0,
	},
		Layout.new{
		texture = skyworldTexture,
		texM = Layout.FIT_HEIGHT,
		TextArea.new(font, "texM = Layout.FIT_HEIGHT", "|", "C"),
		col = 3, row = 0,
	},
		Layout.new{
		texture = skyworldTexture,
		texM = Layout.CROP,
		TextArea.new(font, "texM = Layout.CROP", "|", "C"),
		col = 4, row = 0,
	},
}

stage:addChild(layout)