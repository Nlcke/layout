local text = "Спецэффекты"

local function getCharPositions(font, text)
	local t = {0}
	local s = ""
	for i,code in utf8.codes(text) do
		local char = utf8.char(code)
		s = s .. char
		local x, y, w, h = font:getBounds(s.." ")
		t[#t+1] = w
	end
	return t
end

local function getChars(text)
	local t = {}
	local char = utf8.char
	for i,code in utf8.codes(text) do
		t[#t+1] = char(code)
	end
	return t
end

local positions = getCharPositions(font, text)
local chars = getChars(text)
local _, _, _, textHeight = font:getBounds("|")
local textWidth = positions[#positions]

local layout = Layout.new{}

for i,char in ipairs(chars) do
	local frame = Pixel.new(0, 0, textWidth, textHeight)
	local glyph = TextField.new(font, char, "Pq")
	glyph:setX(positions[i])
	frame:addChild(glyph)
	layout:addChild(Layout.new{
		frame,
		anAdd = Layout.newAnimation(math.random(60, 180)),
	})
end

stage:addChild(layout)