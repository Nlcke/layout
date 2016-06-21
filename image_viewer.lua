local textures = Layout.loadFromPath{
	path = "d:/Images/Fruits", -- set this path to your images
	from = 1, to = 100,
	namemod = function(n, p, b, e, i)
		if e == ".jpg" or e == ".png" then return b end
	end
}

local layout = Layout.new{
	content = true,
	cellRelW = 1/10, cellRelH = 1/10,
	anRemove = Layout.newAnimation(),
}

for col = 0, 9 do
	for row = 0, 9 do
		layout:addChild(Layout.new{
			anAdd = Layout.newAnimation(),
			limW = 1, limH = 1,
			move = true, scale = true, tilt = true,
			scaleMin = 0.5, scaleMax = 10,
			bgrC = math.random(0, 0xFFFFFF), bgrA = 1.0,
			col = col, row = row,
			texture = textures[col + row * 10 + 1]
		})
	end
end

stage:addChild(layout)