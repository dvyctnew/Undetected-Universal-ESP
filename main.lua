-- local deltaclock = 

local plr = game.Players.LocalPlayer
local chr = nil 
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local headoffset = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0,3,0)
local cfg = {
    enabled = false,
	teamcheck = true,
	box = {
		Visible = false,
		Filled = false,
		Color = Color3.new(1,1,1),
		Transparency = 1,
		Thickness = 1,
	},
	boxOutline = {
		Visible = false,
		Filled = false,
		Color = Color3.new(0,0,0),
		Transparency = 1,
		Thickness = 3,
	},
	healthBarOutline = {
		Visible = false,
		Filled = false,
		Color = Color3.new(0,0,0),
		Transparency = 1,
		Thickness = 3,
	},
	healthBar = {
		Visible = false,
		Filled = false,
		Color = Color3.new(0,1,0),
		Transparency = 1,
		Thickness = 1,
	},
	name = {
		Visible = false,
		Text = "",
        Color = Color3.new(0,0,0),
		Outline = true,
		OutlineColor = Color3.new(0, 0, 0),
		Font = 1,
		Center = true,
		Transparency = 1,
	}, 
}
local function updateitem(Box, BoxOutline, HealthBar, HealthBarOutline)
	BoxOutline.Color = cfg.boxOutline.Color
	BoxOutline.Thickness = cfg.boxOutline.Thickness
	BoxOutline.Transparency = cfg.boxOutline.Transparency
	BoxOutline.Filled = cfg.boxOutline.Filled
	Box.Visible = false
	Box.Color = cfg.box.Color
	Box.Thickness = cfg.box.Thickness
	Box.Transparency = cfg.box.Transparency
	Box.Filled = cfg.box.Filled
	HealthBarOutline.Visible = false
	HealthBarOutline.Color = cfg.healthBarOutline.Color
	HealthBarOutline.Thickness = cfg.healthBarOutline.Thickness
	HealthBarOutline.Transparency = cfg.healthBarOutline.Transparency
	HealthBarOutline.Filled = cfg.healthBarOutline.Filled
	HealthBar.Visible = false
	HealthBar.Color = cfg.healthBar.Color
	HealthBar.Thickness = cfg.healthBar.Thickness
	HealthBar.Transparency = cfg.healthBar.Transparency
	HealthBar.Filled = cfg.healthBar.Filled
end
local headoffset = Vector3.new(0, 1.5, 0) 
local legoffset = Vector3.new(0, 3, 0) 
local function esp(v, BoxOutline, Box, HealthBar, HealthBarOutline, Name)
	game:GetService("RunService").RenderStepped:Connect(function()
        if cfg.enabled == true then
		if not (v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= plr) then
			Box.Visible = false
			BoxOutline.Visible = false
			HealthBarOutline.Visible = false
			HealthBar.Visible = false
            Name.Visible = false
			return
		end

		if v.Character.Humanoid.Health <= 0 then
			Box.Visible = false
			BoxOutline.Visible = false
			HealthBarOutline.Visible = false
			HealthBar.Visible = false
            Name.Visible = false
			return
		end

		local RootPart = v.Character.HumanoidRootPart
		local Head = v.Character.Head
		local RootPosition, RootVis = camera:WorldToViewportPoint(RootPart.Position)
		local HeadPosition = camera:WorldToViewportPoint(Head.Position + headoffset)
		local LegPosition = camera:WorldToViewportPoint(RootPart.Position - legoffset)

		if RootVis then
            local BoxHeight = math.abs(HeadPosition.Y - LegPosition.Y)
            local BoxWidth = BoxHeight * 0.6 
        
            BoxOutline.Size = Vector2.new(BoxWidth, BoxHeight)
            BoxOutline.Position = Vector2.new(RootPosition.X - BoxWidth / 2, RootPosition.Y - BoxHeight / 2)
            BoxOutline.Visible = cfg.boxOutline.Visible

            Box.Color = v.TeamColor.Color
            Name.Color = v.TeamColor.Color

            Name.Position = Vector2.new(Box.Position.X + (BoxWidth / 2), Box.Position.Y - 15) -- Position above the box
            Name.Visible = cfg.name.Visible
        
            HealthBarOutline.Size = Vector2.new(2, BoxHeight)
            HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6, 0)
            HealthBarOutline.Visible = cfg.healthBarOutline.Visible 
        
            local healthPercentage = v.Character.Humanoid.Health / v.Character.Humanoid.MaxHealth
            HealthBar.Size = Vector2.new(2, BoxHeight * healthPercentage)
            HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (BoxHeight - HealthBar.Size.Y))
            HealthBar.Visible = cfg.healthBar.Visible
        
            Box.Size = Vector2.new(BoxWidth, BoxHeight)
            Box.Position = Vector2.new(RootPosition.X - BoxWidth / 2, RootPosition.Y - BoxHeight / 2)
            Box.Visible = cfg.box.Visible


          --[[  if v.TeamColor == plr.TeamColor and cfg.teamcheck then 
               Box.Visible = false
              BoxOutline.Visible = false
             HealthBarOutline.Visible = false
              HealthBar.Visible = false
               Name.Visible = false
            else
                Box.Visible = cfg.box.Visible
                BoxOutline.Visible = cfg.boxOutline.Visible
                HealthBarOutline.Visible = cfg.box.Visible
                HealthBar.Visible = cfg.box.Visible
                Name.Visible = cfg.name.Visible
            end
            ]]
        else
            Box.Visible = false
            BoxOutline.Visible = false
            HealthBarOutline.Visible = false
            HealthBar.Visible = false
            Name.Visible = false
        end
    else 
        Box.Visible = false
        BoxOutline.Visible = false
        HealthBarOutline.Visible = false
        HealthBar.Visible = false
        Name.Visible = false
    end 
	end)
end
local function create(v)
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = cfg.boxOutline.Color
	BoxOutline.Thickness = cfg.boxOutline.Thickness
	BoxOutline.Transparency = cfg.boxOutline.Transparency
	BoxOutline.Filled = cfg.boxOutline.Filled

	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = cfg.box.Color
	Box.Thickness = cfg.box.Thickness
	Box.Transparency = cfg.box.Transparency
	Box.Filled = cfg.box.Filled

	local HealthBarOutline = Drawing.new("Square")
	HealthBarOutline.Visible = false
	HealthBarOutline.Color = cfg.healthBarOutline.Color
	HealthBarOutline.Thickness = cfg.healthBarOutline.Thickness
	HealthBarOutline.Transparency = cfg.healthBarOutline.Transparency
	HealthBarOutline.Filled = cfg.healthBarOutline.Filled

	local HealthBar = Drawing.new("Square")
	HealthBar.Visible = false
	HealthBar.Color = cfg.healthBar.Color
	HealthBar.Thickness = cfg.healthBar.Thickness
	HealthBar.Transparency = cfg.healthBar.Transparency
	HealthBar.Filled = cfg.healthBar.Filled
	
	local Name = Drawing.new("Text")
    Name.Text = v.Name
    Name.Visible = false
    Name.Outline = cfg.name.Outline
    Name.Color = cfg.name.Color
    Name.OutlineColor = cfg.name.OutlineColor
    Name.Font =  cfg.name.Font
    Name.Center =  cfg.name.Center
    Name.Transparency =  cfg.name.Transparency

    --local Team = Drawing.new("Text")\

    esp(v, BoxOutline, Box, HealthBar, HealthBarOutline, Name)
end
for _, v in ipairs(game.Players:GetPlayers()) do
	create(v)
end

game.Players.PlayerAdded:Connect(function(plr)
	create(plr)
end)
local uilibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainstreamed/amongus-hook/refs/heads/main/uilibrary.lua"))()


local TITLE = uilibrary:AddTab("by dvyct")
TITLE:AddButton("UNIVERSAL ESP BY DVYCT, dvyctnew on github, dvyct on discord.", function() end)
TITLE:AddButton("Arrow Keys like GTA5 Menus to move around.", function() end)
TITLE:AddButton("UI Library made by mainstreamed", function() end)
TITLE:AddButton("Hes the creator of Amongus.Hook a really good cheat check him out", function() end)
TITLE:AddButton("THIS IS COMPLETELY UNDETECTED BTW ON EVERY GAME.", function() end)


local ESP = uilibrary:AddTab("Player ESP")
local Toggle = ESP:AddToggle({
    text = "ESP Enabled", 
    default = false, 
    flag = {
        value = false,
    },
    callback = function(state)
        if state then
            cfg.enabled = true
        else
            cfg.enabled = false
        end
    end
})

local Toggle = ESP:AddToggle({
    text = "Player Boxes", 
    default = false, 
    flag = {
        value = false,
    },
    callback = function(state)
        if state then
            cfg.box.Visible = true
            cfg.boxOutline.Visible = true
        else
            cfg.box.Visible = false
            cfg.boxOutline.Visible = false
        end
    end
})

local Toggle = ESP:AddToggle({
    text = "Player Health", 
    default = false, 
    flag = {
        value = false,
    },
    callback = function(state)
        if state then
            cfg.healthBarOutline.Visible = true
            cfg.healthBar.Visible = true
        else
            cfg.healthBarOutline.Visible = false
           cfg.healthBar.Visible = false
        end
    end
})

local Toggle = ESP:AddToggle({
    text = "Player Name", 
    default = false, 
    flag = {
        value = false,
    },
    callback = function(state)
        if state then
            cfg.name.Visible = true
        else
            cfg.name.Visible = false
        end
    end
})


-- print("Loaded in" )
