local quotes = {
[["If Java had true garbage
collection, most programs
would delete themselves
upon execution."
-- Robert Sewell]],
[["There are only two things
wrong with C++:
The initial concept and
the implementation."
-- Bertrand Meyer]],
[["Ruby performance tuning
really feels like trying
to get the best miles per
gallon out of a tricycle."
-- David R. MacIver]],
[["A C program is like a fast
dance on a newly waxed dance
floor by people carrying razors."
-- Waldi Ravens.]],
[["FORTRAN is not a flower but
a weed -- it is hardy, occasionally
blooms, and grows in every computer."
-- Alan J. Perlis.]]
}

local function newText(text)
	local sprite = Sprite.new()
	local y = 0
	for line in (text.."\n"):gmatch(".-\n") do
		local textfield = TextField.new(font, line, "|")
		textfield:setY(y)
		sprite:addChild(textfield)
		y = y + textfield:getLineHeight()
	end
	return sprite
end

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	bgrC = 0x00BBFF, bgrA = 0.5,
	cols = 1, rows = 4, cellRelW = 1, cellRelH = 0.25,
	sprM = Layout.LETTERBOX,
	newText(quotes[math.random(1, #quotes)])
}

stage:addChild(layout)