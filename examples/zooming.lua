local pixel = Pixel.new(skyworldTexture)

local layout = Layout.new{
	scroll = true, zoom = true,
	bgrA = 0.5, bgrC = {0xFFFF00, 1, 0xFF00FF, 1, 0xFFFFFF, 1, 0x0000FF, 1},
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	pixel
}

Layout.select(pixel)

stage:addChild(layout)