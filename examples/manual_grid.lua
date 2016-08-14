local bitmaps = {}
for name in ("\n"..fruitsDesc):gmatch"\n(.-%.png)" do
	bitmaps[name:sub(1, -5)] = Bitmap.new(fruitsPack:getTextureRegion(name))
end

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	content = true, scroll = true,
	cols = 3, rows = 4,
	borderW = 5, borderH = 5,
	cellRelW = 1/3, cellRelH = 1/2,
	Layout.new{bitmaps.Fruits,     col = 0, row = 0, sprM = Layout.CROP,
		colW = 3},	
	Layout.new{bitmaps.orange,     col = 0, row = 1, sprM = Layout.CROP},
	Layout.new{bitmaps.cherry,     col = 1, row = 1, sprM = Layout.CROP},
	Layout.new{bitmaps.banana,     col = 2, row = 1, sprM = Layout.CROP},	
	Layout.new{bitmaps.grape,      col = 0, row = 2, sprM = Layout.CROP},
	Layout.new{bitmaps.strawberry, col = 1, row = 2, sprM = Layout.CROP},
	Layout.new{bitmaps.elderberry, col = 2, row = 2, sprM = Layout.CROP},
	Layout.new{bitmaps.melon,      col = 0, row = 3, sprM = Layout.CROP},
	Layout.new{bitmaps.fig,        col = 1, row = 3, sprM = Layout.CROP},
	Layout.new{bitmaps.apple,      col = 2, row = 3, sprM = Layout.CROP},
}

Layout.select(layout(1))

stage:addChild(layout)