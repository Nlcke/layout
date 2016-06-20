backbuttonTexture = Texture.new("resources/backbutton.png")
skyworldTexture = Texture.new("resources/skyworld.png")

local function toUTF8(decimal)
	if decimal < 128 then return string.char(decimal) end
	local charbytes = {}
	for bytes,vals in ipairs {{0x7FF,192}, {0xFFFF,224}, {0x1FFFFF,240}} do
		if decimal <= vals[1] then
			for b = bytes+1, 2, -1 do
				local mod = decimal % 64
				decimal = (decimal - mod) / 64
				charbytes[b] = string.char(128 + mod)
			end
			charbytes[1] = string.char(vals[2] + decimal)
			break
		end
	end
	return table.concat(charbytes)
end

local function getFontCache(charsets)
	local t = {}
	local n = 0
	for k,v in ipairs(charsets) do
		for i = v[1], v[2] do
			n = n + 1
			t[n] = toUTF8(i)
		end
	end
	return table.concat(t)
end

local charsets = {
	{0x0020,0x007F},
	{0x0080,0x009F},
	{0x00A0,0x00FF},
	{0x0100,0x017F},
	{0x0180,0x024F},
	{0x0250,0x02AF},
	{0x02B0,0x02FF},
	{0x0300,0x036F},
	{0x0370,0x03FF},
	{0x0400,0x0458},
	{0x0500,0x052F},
	{0x0530,0x058F},
}

local fontcache = getFontCache(charsets)

font = TTFont.new("resources/BlissPro-Bold.otf", 150, fontcache)