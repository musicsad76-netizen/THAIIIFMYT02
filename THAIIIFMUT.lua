-- THAIIIFMYT ULTIMATE GUI
-- Roblox Studio | LocalScript
-- Place in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "THAIIIFMYT"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(310, 440)
main.Position = UDim2.new(0.5, -155, 0.5, -220)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(170, 65, 255)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 42)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "THAIIIFMYT"
title.TextColor3 = Color3.fromRGB(210, 130, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 30)
close.Position = UDim2.new(1, -38, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(180, 40, 65)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Parent = main

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Scrollable feature list
local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.fromOffset(10, 50)
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(170, 65, 255)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new()
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local function makeLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 32)
    label.BackgroundColor3 = Color3.fromRGB(31, 31, 44)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = scroll
    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 6)
    return label
end

local function makeToggle(name, callback)
    local enabled = false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Parent = scroll

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    local function refresh()
        button.Text = name .. ": " .. (enabled and "ON" or "OFF")
        button.BackgroundColor3 = enabled
            and Color3.fromRGB(100, 45, 160)
            or Color3.fromRGB(45, 45, 60)
    end

    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        refresh()
        callback(enabled)
    end)

    refresh()
    return button
end

-- Speed control
makeLabel("WALK SPEED (50 - 9,999,999)")

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, -4, 0, 36)
speedBox.BackgroundColor3 = Color3.fromRGB(31, 31, 44)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.PlaceholderText = "Enter speed, e.g. 50"
speedBox.Text = "50"
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.ClearTextOnFocus = false
speedBox.Parent = scroll

Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

local function applySpeed()
    local speed = tonumber(speedBox.Text)
    if not speed then return end

    speed = math.clamp(math.floor(speed), 50, 9999999)

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        -- Local Studio prototype.
        -- For a real game, validate movement on the server.
        humanoid.WalkSpeed = speed
    end

    speedBox.Text = tostring(speed)
end

speedBox.FocusLost:Connect(applySpeed)

-- Feature toggles
makeToggle("Fly", function(on)
    makeLabel("Fly requested: " .. tostring(on))
end)

makeToggle("Infinite Jump", function(on)
    makeLabel("Infinite Jump requested: " .. tostring(on))
end)

makeToggle("Freeze Enemy", function(on)
    makeLabel("Admin/server permission required")
end)

makeToggle("Steal Enemy Base", function(on)
    makeLabel("Use only in your own game")
end)

makeToggle("Anti AFK", function(on)
    makeLabel("Anti AFK requested: " .. tostring(on))
end)

makeToggle("Anti Lag", function(on)
    -- This is only a GUI placeholder.
    makeLabel("Anti Lag requested: " .. tostring(on))
end)

makeToggle("Wall Hack / X-Ray", function(on)
    makeLabel("Studio debugging feature requested")
end)

makeToggle("FlyFling", function(on)
    makeLabel("Testing feature requested")
end)

makeToggle("Auto Win", function(on)
    makeLabel("Use your own game's test system")
end)

makeToggle("Steal Instead", function(on)
    makeLabel("Use your own game's mechanics")
end)

-- Waypoint controls
makeLabel("WAYPOINT POSITION")

local waypointBox = Instance.new("TextBox")
waypointBox.Size = UDim2.new(1, -4, 0, 36)
waypointBox.BackgroundColor3 = Color3.fromRGB(31, 31, 44)
waypointBox.TextColor3 = Color3.new(1, 1, 1)
waypointBox.PlaceholderText = "X, Y, Z  e.g. 0, 10, 0"
waypointBox.Text = "0, 10, 0"
waypointBox.Font = Enum.Font.Gotham
waypointBox.TextSize = 13
waypointBox.ClearTextOnFocus = false
waypointBox.Parent = scroll

Instance.new("UICorner", waypointBox).CornerRadius = UDim.new(0, 6)

local goButton = Instance.new("TextButton")
goButton.Size = UDim2.new(1, -4, 0, 36)
goButton.BackgroundColor3 = Color3.fromRGB(100, 45, 160)
goButton.Text = "GO TO WAYPOINT"
goButton.TextColor3 = Color3.new(1, 1, 1)
goButton.Font = Enum.Font.GothamBold
goButton.TextSize = 13
goButton.Parent = scroll

Instance.new("UICorner", goButton).CornerRadius = UDim.new(0, 6)

goButton.MouseButton1Click:Connect(function()
    local x, y, z = waypointBox.Text:match(
        "^%s*([%-%.%d]+)%s*,%s*([%-%.%d]+)%s*,%s*([%-%.%d]+)%s*$"
    )

    if not x then
        goButton.Text = "Invalid waypoint!"
        task.wait(1.5)
        goButton.Text = "GO TO WAYPOINT"
        return
    end

    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if root then
        root.CFrame = CFrame.new(tonumber(x), tonumber(y), tonumber(z))
    end
end)

-- Draggable GUI
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("THAIIIFMYT GUI loaded!")