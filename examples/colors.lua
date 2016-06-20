database = {}
for i = 1, 2^16 do
    database[i] = {bgrC = i, bgrA = 1.0}
end
layout = Layout.new{
    template = Layout, database = database,
    scroll = true, content = true,
    cellAbsW = 16, cellAbsH = 16,
    cols = 256,
}

stage:addChild(layout)