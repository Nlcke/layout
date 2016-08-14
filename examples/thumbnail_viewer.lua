local textures = Layout.newResources{
	path = imagepath,
	from = 1, to = 100,
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
	content = true,
	cellRelW = 1/10, cellRelH = 1/10,
	anRemove = Layout.newAnimation(),
}

for col = 0, 9 do
	for row = 0, 9 do
		layout:addChild(Layout.new{
			anAdd = Layout.newAnimation(),
			move = true, scale = true, tilt = true,
			scaleMin = 0.5, scaleMax = 10,
			bgrC = math.random(0, 0xFFFFFF), bgrA = 1.0,
			col = col, row = row,
			texture = textures[col + row * 10 + 1]
		})
	end
end

stage:addChild(layout)