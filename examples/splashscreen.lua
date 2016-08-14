local counter = 0
local function countup() counter = counter + 1 end

local elements = {}
for name in ("\n"..splashscreenDesc):gmatch"\n(.-%.png)" do
	local texture = splashscreenPack:getTextureRegion(name)
	elements[#elements+1] = Layout.new{
		Bitmap.new(texture),
		anAdd = {
			frames = math.random(120, 240),
			anchorX = math.sqrt,
			rotation = math.log,
		},
		onAdd = countup
	}
end

local l = #elements

local function onPress(self)
	if counter == 0 then
		for i,element in ipairs(elements) do
			self:addChild(element)
		end
	elseif counter == l then
		for i,element in ipairs(elements) do
			element.anRemove = Layout.newAnimation(math.random(60, 120))
			element:removeFromParent()
		end
		counter = 0
	end
end

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	onPress = onPress

}

onPress(layout)

stage:addChild(layout)