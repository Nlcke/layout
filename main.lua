local examples = Layout.newResources{
	path = "|R|examples",
	namemod = function(name, path, base, ext, i) return base end
}

local layout

local backbutton = Layout.new{
	texture = backbuttonTexture,
	ancX = 1, ancY = 0,
	relW = 0.1, relH = 0.1,
	limW = 1, limH = 1,
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	onPress = function(self)
		for _,child in pairs(stage.__children) do
			child:removeFromParent()
		end
		stage:addChild(layout)
		Layout.select(layout)
	end
}

backbutton:addEventListener(Event.ENTER_FRAME, function()
	if backbutton:getParent() == stage then
		stage:addChild(backbutton)
	end
end)

local Button = Layout:with{
	text = "BUTTON",
	textColor = 0xFFFFFF,
	bgrA = 1.0,
	sprM = Layout.LETTERBOX,
	
	init = function(self, p)
		self.textfield = TextField.new(font, self.text, "Pq|")
		self.textfield:setTextColor(self.textColor)
		self:addChild(self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text) end
	end,
	
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	selector = Layout.new{bgrC = 0x0088FF, bgrA = 0.25},
	
	onPress = function(self)
		stage:addChild(backbutton)
		Layout.select(backbutton)
		examples[self.text]()
		layout:removeFromParent()
	end
}

local database = {}
for i = 1, #examples do database[i] = {text = examples[-i]} end

layout = Layout.new{
	template = Button, database = database, scroll = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsH = 50,
	cellBrdW = 5, cellBrdH = 5,
	cols = 1,
}

stage:addChild(layout)

Layout.select(layout)