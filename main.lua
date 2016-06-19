local examples = Layout.loadFromPath{
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
	end
}

Button = Layout:with{
	text = "BUTTON",
	textColor = 0xFFFFFF,
	bgrA = 1.0,
	
	init = function(self, p)
		self.textfield = TextArea.new(font, self.text, "|")
		self.textfield:setTextColor(self.textColor)
		table.insert(p, self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text, "|") end
	end,
	
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self)
		examples[self.text]()
		layout:removeFromParent()
		stage:addChild(backbutton)
	end
}

local database = {}
for i = 1, #examples do database[i] = {text = examples[-i]} end

layout = Layout.new{
	template = Button, database = database,
	scroll = true,
	content = true,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	cellAbsH = 50,
	borderW = 5, borderH = 5,
	cols = 1,
}

stage:addChild(layout)