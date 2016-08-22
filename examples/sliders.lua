Slider = Layout:with{
	scroll = true,
	bgrC = 0x444444,
	bgrA = 0.5,
	
	handleTexture = false,
	handleColor = 0x000000,
	handleAlpha = 0.5,
	handleWidth = 0.1,
	handleHeight = 1,
	handleCallback = function(self)
		self.parent.indicator(1):setText(self.ancX)
		self.parent.indicator:update()
	end,
	
	init = function(self, p)
		self.indicator = Layout.new{
			sprM = Layout.FIT_HEIGHT,
			sprX = 0,
			TextField.new(font, "0", "fg|")
		}
		self:addChild(self.indicator)
		self.handle = Layout.new{
			ancX = 0,
			ancY = 0,
			texture = self.handleTexture,
			bgrC = self.handleColor,
			bgrA = self.handleAlpha,
			relW = self.handleWidth,
			relH = self.handleHeight,
			move = true,
			onMove = self.handleCallback
		}
		self:addChild(self.handle)
	end
}

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Slider.new{bgrC = 0x00FF00, relY = 0.0, relH = 0.2},
	Slider.new{bgrC = 0x00FFFF, relY = 0.2, relH = 0.2},
	Slider.new{bgrC = 0xFFFF00, relY = 0.4, relH = 0.2},
	Slider.new{bgrC = 0xFF00FF, relY = 0.6, relH = 0.2},
	Slider.new{bgrC = 0xFF0000, relY = 0.8, relH = 0.2},
}

stage:addChild(layout)