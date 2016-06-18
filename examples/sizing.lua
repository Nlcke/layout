local texts = {
	abs = "absolute\nabsW = 320\nabsH = 240",
	rel = "relative\nrelW = 0.5\nrelH = 0.5",
	anc = "anchored\nancX = 0\nancY = 1",
	grs = "gridsnapped\ncol = 1\nrow = 0",
}

local spaces = (" "):rep(30)

for k,v in pairs(texts) do
	texts[k] = spaces .. "\n" .. v .. "\n" .. spaces 
end

local layout = Layout.new{
	cellRelW = 0.5, cellRelH = 0.5,
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	Layout.new{
		TextArea.new(font, texts.abs, "|", "C"),
		absW = 320, absH = 240,
		absX = 60, absY = 40,
		
		bgrC = 0x0000FF, bgrA = 0.5,
	},
		Layout.new{
		TextArea.new(font, texts.rel, "|", "C"),
		relW = 0.5, relH = 0.5,
		ancX = 0.8, ancY = 0.4,
		
		bgrC = 0xFF0000, bgrA = 0.5,
	},
		Layout.new{
		TextArea.new(font, texts.anc, "|", "C"),
		ancX = 0, ancY = 1,
		
		bgrC = 0x000000, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
		Layout.new{
		TextArea.new(font, texts.grs, "|", "C"),
		col = 1, row = 0, 
		
		bgrC = 0x00FF00, bgrA = 0.5,
		relW = 0.5, relH = 0.5,
	},
}

stage:addChild(layout)