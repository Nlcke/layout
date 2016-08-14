imagepath = "d:/Images/Fruits" -- set this path to your images
backbuttonTexture = Texture.new("resources/backbutton.png")
leftbuttonTexture = Texture.new("resources/leftbutton.png")
rightbuttonTexture = Texture.new("resources/rightbutton.png")
skyworldTexture = Texture.new("resources/skyworld.png")
splashscreenPack = TexturePack.new("resources/splashscreen.txt",
	"resources/splashscreen.png")
splashscreenDesc = io.open("resources/splashscreen.txt", "rb"):read"*a"
fruitsPack = TexturePack.new("resources/fruits.txt", "resources/fruits.png")
fruitsDesc = io.open("resources/fruits.txt", "rb"):read"*a"
deviceOS = application:getDeviceInfo()

local function getFontCache(charsets)
	local t = {}
	local n = 0
	for k,v in ipairs(charsets) do
		for i = v[1], v[2] do
			n = n + 1
			t[n] = utf8.char(i)
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