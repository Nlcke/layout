local database = {}

for r = 0, 255, 2 do
	for g = 0, 255, 2 do
		for b = 0, 255, 2 do
			local color = 65536 * r + 256 * g + b
			table.insert(database, {bgrC = color, bgrA = 1.0})
		end
	end
end

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
    template = Layout, database = database, scroll = true,
    cellAbsW = 64, cellAbsH = 64,
    cols = 1024,
}

stage:addChild(layout)