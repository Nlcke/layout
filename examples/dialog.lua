Label = Layout:with{
	text = "LABEL",
	textColor = 0xFFFFFF,
	bgrA = 1.0,
	sprS = 0.9,
	
	init = function(self, p)
		self.textfield = TextField.new(font, self.text, "|")
		self.textfield:setTextColor(self.textColor)
		self:addChild(self.textfield)
	end,
	
	upd = function(self, p)
		if p.text then self.textfield:setText(p.text, "|") end
	end,
}

local Button = Label:with{
	text = "BUTTON",
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
}

local Dialog = Layout:with{
	text = "DIALOG",
	buttons = {"OK", "Cancel"},
	callbacks = {
		OK = function() print "OK" end,
		Cancel = function() print "Cancel" end
	},
	texture = skyworldTexture,
	texM = Layout.STRETCH,
	init = function(self, p)
		self:addChild(Label.new{
			text = self.text,
			textColor = 0xFF0000,
			bgrA = 0,
			relY = 0, relH = 0.5,
		})
		local n = #self.buttons
		self.cellRelW = 1 / n
		self.cellRelH = 0.5
		for i,name in ipairs(self.buttons) do
			self:addChild(Button.new{
				text = name,
				bgrA = 0.5,
				sprM = Layout.FIT_HEIGHT, sprS = 0.25,
				col = i - 1, row = 1,
				onPress = self.callbacks[name],
			})
		end
	end
}

local dialog = Dialog.new{
	text = "MOVE ME",
	relW = 0.5, relH = 0.5, move = true,
}

local label = Label.new{

}

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	bgrC = 0xFF0000, bgrA = 0.5,
	dialog
}

stage:addChild(layout)