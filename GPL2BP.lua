local funcs = {}

--[[

GPL 2 Basepart
Converts GPL palettes to either a table or a bunch of baseparts 

Usage:

module.GPL2Table(StringValue)
	Where:
		StringValue is a String Value whose value is a GPL palette

module.GPL2Parts(StringValue,PartProperties)
	Where:
		StringValue is a String Value whose value is a GPL palette
		PartProperties is a Dictionary of settings:
			-Position = Position of the column
			-Size = Size of each BasePart
]]

funcs.GPL2Table = function(StringValue)
	local GPLBase = {
		PaletteName = "", --str
		Description = "", --str
		Colors = 0, --Num
		PaletteValues = {},
		DevInfo = {
			BeginningOfColors = 0
		}
	}
	local String = StringValue.Value or StringValue
	local NewTable 
	local Lines = string.split(String,"\n")
	--print(game.HttpService:JSONEncode(Lines))
	NewTable = GPLBase
	NewTable.PaletteName = string.gsub(Lines[2],"#Palette Name: ","") or "No Name"
	NewTable.Description = string.gsub(Lines[3],"#Description: ","") or "No Description"
	local colors = string.gsub(Lines[4],"#Colors: ","")
	NewTable.Colors = tonumber(colors) or 0
	for i,v in pairs(Lines) do
		if string.find(v,"#") then
			NewTable.DevInfo.BeginningOfColors = i+1
		end
	end
	--print(NewTable.DevInfo.BeginningOfColors)
	for the = NewTable.DevInfo.BeginningOfColors,#Lines do
		local Line = Lines[the]
		--print(Line)
		local Values = string.split(Line,"	")
		
		--print(table.unpack(Values))
		--print(Values[1])
		local Set = Line
		local colors = {"","",""}
		
		for the=1,3 do
			colors[the] = string.match(Set,"%d+")
			if string.match(Set,"%d+") == nil then continue end
			Set = string.gsub(Set,string.match(Set,"%d+"),"")
			--print(Set)
		end
		table.insert(NewTable.PaletteValues,{
			R = tonumber(colors[1]),
			G = tonumber(colors[2]),
			B = tonumber(colors[3]),
		})
	end
	return NewTable
end

funcs.GPL2Parts = function(StringValue : string,Position : Vector3,Size : Vector3)
	local PartProperties = {
		Position = Position or Vector3.new(0,0,0),
		Size = Size or Vector3.new(1,1,1),
	}
	local Palette = funcs.GPL2Table(StringValue.Value or StringValue)
	local Model = Instance.new("Model")
	Model.Name = "GPL2BP_Output_"..os.time()
	Model.Parent = workspace
	for i,v in pairs(Palette.PaletteValues) do
		local NewPart = Instance.new("Part")
		NewPart.Size = PartProperties.Size
		NewPart.Position = Vector3.new(PartProperties.Position.X,PartProperties.Size.Y * i,PartProperties.Position.Z)
		NewPart.Color = Color3.fromRGB(v.R,v.G,v.B)
		NewPart.Name = NewPart.Color:ToHex()
		NewPart.Parent = Model
		NewPart.Material = Enum.Material.SmoothPlastic
	end
end

return funcs