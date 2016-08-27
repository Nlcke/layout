local texturenames = Layout.newResources{
	path = imagepath,
	onlynames = true,
	namemod = function(n, p, b, e, i)
		if e == ".jpg" or e == ".png" then return n end
	end,
}

if not texturenames then 
	local layout = Layout.new{
		bgrC = 0xFF0000, bgrA = 0.5,
		TextField.new(font, "No images in "..imagepath, "|")
	}
	stage:addChild(layout)
	return
end

local i, l = 1, #texturenames

local thisImage = Layout.new{
	texture = Texture.new(texturenames[i], true),
}

local nextImage = Layout.new{}

local imageframe = Layout.new{thisImage, selectable = false}

local label = Layout.new{
	relW = 0.8, relH = 0.1,
	relX = 0.1, relY = 0.9,
	sprM = Layout.FIT_HEIGHT,
	sprAncX = 1,
	bgrA = 0.5,
	selectable = false,
	TextField.new(font, texturenames[i], "|")
}

label(1):setTextColor(0xFFFFFF)

local leftbutton = Layout.new{
	texture = leftbuttonTexture,
	ancX = 0, ancY = 1,
	relW = 0.1, relH = 0.1,
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self)
		i = i - 1
		if i < 1 then i = l end
		nextImage:play(false)
		thisImage:update{anRemove = Layout.newAnimation()}
		thisImage:removeFromParent()
		nextImage:update{
			anAdd = Layout.newAnimation(),
			texture = Texture.new(texturenames[i], true),
		}
		imageframe:addChild(nextImage)
		thisImage, nextImage = nextImage, thisImage
		label(1):setText(texturenames[i])
		label:update()		
	end
}

local rightbutton = Layout.new{
	texture = rightbuttonTexture,
	ancX = 1, ancY = 1,
	relW = 0.1, relH = 0.1,
	anPress = Layout.newAnimation(14, 7, 0.04),
	anHover = Layout.newAnimation(14, 7, 0.02),
	
	onPress = function(self)
		i = i + 1
		if i > l then i = 1 end
		nextImage:play(false)
		thisImage:update{anRemove = Layout.newAnimation()}
		thisImage:removeFromParent()
		nextImage:update{
			anAdd = Layout.newAnimation(),
			texture = Texture.new(texturenames[i], true),
		}
		imageframe:addChild(nextImage)
		thisImage, nextImage = nextImage, thisImage
		label(1):setText(texturenames[i])
		label:update()		
	end
}

local layout = Layout.new{
	anAdd = Layout.newAnimation(),
	anRemove = Layout.newAnimation(),
	imageframe,
	leftbutton, label, rightbutton,
}

Layout.select(rightbutton)

stage:addChild(layout)