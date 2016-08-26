local dx, dy = math.random(-2, 2), math.random(-2, 2)

local layout = Layout.new{
	cellRelW = 0.2, cellRelH = 0.5,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.LETTERBOX,
		TextField.new(font, " LETTERBOX ", "|"),
		col = 0, row = 0,
	},
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.STRETCH,
		TextField.new(font, " STRETCH ", "|"),
		col = 1, row = 0,
	},
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.FIT_WIDTH,
		TextField.new(font, " FIT_WIDTH ", "|"),
		col = 2, row = 0,
	},
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.FIT_HEIGHT,
		TextField.new(font, " FIT_HEIGHT ", "|"),
		col = 3, row = 0,
	},
	Layout.new{
		texture = skyworldTexture,
		texM = Layout.CROP,
		TextField.new(font, " CROP ", "|"),
		col = 4, row = 0,
	},
	Layout.new{
		id = "scrbg",
		cellRelH = 1/5,
		Layout.new{row = 0,
			TextField.new(font, "texM = Layout.CROP", "|"),
		},
		Layout.new{row = 1,
			TextField.new(font, "texAncX = 0.75", "|"),
		},
		Layout.new{row = 2,
			TextField.new(font, "texAncY = 0.25", "|"),
		},
		Layout.new{row = 3,
			TextField.new(font, "texS = 0.125", "|"),
		},
		Layout.new{row = 4,
			TextField.new(font, "[press to change scrolling]", "|"),
		},		
		texture = ringtile,
		texM = Layout.CROP, texS = 0.125,
		texAncX = 0.75, texAncY = 0.25,
		col = 0, row = 1, cellW = 5,
		onPress = function()
			dx, dy = math.random(-2, 2), math.random(-2, 2)
		end
	},	
}

layout"scrbg":addEventListener(Event.ENTER_FRAME, function()
	local x, y = layout"scrbg".texOffX, layout"scrbg".texOffY
	layout"scrbg":update{texOffX = x + dx, texOffY = y + dy}
end)

stage:addChild(layout)