local side = 6

local textures = Layout.newResources{
	path = imagepath,
	from = 1, to = side * side,
	namemod = function(n, p, b, e, i)
		if e == ".jpg" or e == ".png" then return b end
	end
}

if not textures then 
	local layout = Layout.new{
		bgrC = 0xFF0000, bgrA = 0.5,
		TextField.new(font, "No images in "..imagepath, "|")
	}
	stage:addChild(layout)
	return
end

local layout = Layout.new{
	cellRelW = 1/side, cellRelH = 1/side,
	anRemove = Layout.newAnimation(),
}

for col = 0, side do
	for row = 0, side do
		layout:addChild(Layout.new{
			anAdd = Layout.newAnimation(),
			move = true, scale = true, tilt = true,
			scaleMin = 0.5, scaleMax = 10,
			bgrC = math.random(0, 0xFFFFFF), bgrA = 1.0,
			col = col, row = row,
			texture = textures[col + row * side + 1]
		})
	end
end

stage:addChild(layout)