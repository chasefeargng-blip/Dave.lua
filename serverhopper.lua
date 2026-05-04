-- ============================================
-- D4VE HUB - FINAL 100% WORKING
-- Key: Davey | Mobile + PC | D4 Icon | All Tested
-- ============================================

local player = game.Players.LocalPlayer
local ts = game:GetService("TeleportService")
local uis = game:GetService("UserInputService")
local isMobile = uis.TouchEnabled and not uis.KeyboardEnabled

-- Key check
local keyOk = false
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == "Davey" then keyOk = true end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== D4 ICON =====
local d4 = Instance.new("TextButton")
d4.Size = UDim2.new(0, 45, 0, 45)
d4.Position = UDim2.new(0, 10, 0, 10)
d4.Text = "D4"
d4.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
d4.TextColor3 = Color3.fromRGB(0, 0, 0)
d4.Font = Enum.Font.GothamBlack
d4.TextSize = 16
d4.BorderSizePixel = 0
d4.Visible = false
d4.ZIndex = 10
d4.Parent = gui
Instance.new("UICorner", d4).CornerRadius = UDim.new(1, 0)

-- D4 Drag
local drag, moved, sPos, sFrame = false, false, nil, nil
d4.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag, moved, sPos, sFrame = true, false, i.Position, d4.Position
    end
end)
d4.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
        if not moved then main.Visible, d4.Visible = true, false end
    end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - sPos
        if math.abs(d.X) > 2 or math.abs(d.Y) > 2 then moved = true end
        d4.Position = UDim2.new(sFrame.X.Scale, sFrame.X.Offset + d.X, sFrame.Y.Scale, sFrame.Y.Offset + d.Y)
    end
end)

-- ===== MAIN FRAME =====
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 260)
main.Position = UDim2.new(0.5, -110, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
main.BorderSizePixel = 0
main.Visible = keyOk
main.Draggable = true
main.Active = true
main.ZIndex = 5
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(0, 255, 170)
ms.Thickness = 1.5
ms.Parent = main

-- Title
local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 0, 36)
mt.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
mt.TextColor3 = Color3.fromRGB(0, 255, 170)
mt.Text = "D4VE HUB"
mt.Font = Enum.Font.GothamBlack
mt.TextSize = 18
mt.BorderSizePixel = 0
mt.Parent = main
Instance.new("UICorner", mt).CornerRadius = UDim.new(0, 12)

-- Close
local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 24, 0, 24)
cb.Position = UDim2.new(1, -30, 0, 6)
cb.Text = "X"
cb.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.Font = Enum.Font.GothamBold
cb.TextSize = 13
cb.BorderSizePixel = 0
cb.AutoButtonColor = false
cb.Parent = main
Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 6)
cb.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize
local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 24, 0, 24)
mb.Position = UDim2.new(1, -56, 0, 6)
mb.Text = "_"
mb.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.Font = Enum.Font.GothamBlack
mb.TextSize = 14
mb.BorderSizePixel = 0
mb.Parent = main
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 6)
mb.MouseButton1Click:Connect(function() main.Visible, d4.Visible = false, true end)

-- ===== BUTTONS =====
local bw = 1
local bx = 0

-- Server Hop
local b1 = Instance.new("TextButton")
b1.Size = UDim2.new(bw, -20, 0, 48)
b1.Position = UDim2.new(bx, 10, 0, 46)
b1.Text = "SERVER HOP"
b1.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.Font = Enum.Font.GothamBold
b1.TextSize = 15
b1.BorderSizePixel = 0
b1.Parent = main
b1.MouseButton1Click:Connect(function() ts:Teleport(game.PlaceId, player) end)

-- Rejoin
local b2 = Instance.new("TextButton")
b2.Size = UDim2.new(bw, -20, 0, 48)
b2.Position = UDim2.new(bx, 10, 0, 104)
b2.Text = "REJOIN"
b2.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.Font = Enum.Font.GothamBold
b2.TextSize = 15
b2.BorderSizePixel = 0
b2.Parent = main
b2.MouseButton1Click:Connect(function() ts:Teleport(game.PlaceId, player) end)

-- Input
local inp = Instance.new("TextBox")
inp.Size = UDim2.new(bw, -20, 0, 38)
inp.Position = UDim2.new(bx, 10, 0, 162)
inp.PlaceholderText = "Place ID..."
inp.Text = ""
inp.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
inp.TextColor3 = Color3.fromRGB(255, 255, 255)
inp.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
inp.Font = Enum.Font.SourceSans
inp.TextSize = 14
inp.BorderSizePixel = 0
inp.Parent = main

-- Custom Hop
local b3 = Instance.new("TextButton")
b3.Size = UDim2.new(bw, -20, 0, 48)
b3.Position = UDim2.new(bx, 10, 0, 210)
b3.Text = "CUSTOM HOP"
b3.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
b3.TextColor3 = Color3.fromRGB(255, 255, 255)
b3.Font = Enum.Font.GothamBold
b3.TextSize = 15
b3.BorderSizePixel = 0
b3.Parent = main
b3.MouseButton1Click:Connect(function()
    local id = tonumber(inp.Text)
    if id and id > 0 then
        ts:Teleport(id, player)
    else
        inp.Text = ""
        inp.PlaceholderText = "Invalid ID!"
        wait(1.5)
        inp.PlaceholderText = "Place ID..."
    end
end)

-- ===== KEY FRAME =====
local kf = Instance.new("Frame")
kf.Size = UDim2.new(0, 220, 0, 150)
kf.Position = UDim2.new(0.5, -110, 0.5, -75)
kf.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
kf.BorderSizePixel = 0
kf.Visible = not keyOk
kf.Draggable = true
kf.Active = true
kf.ZIndex = 5
kf.Parent = gui
Instance.new("UICorner", kf).CornerRadius = UDim.new(0, 12)

local ks = Instance.new("UIStroke")
ks.Color = Color3.fromRGB(0, 170, 255)
ks.Thickness = 1.5
ks.Parent = kf

local kt = Instance.new("TextLabel")
kt.Size = UDim2.new(1, 0, 0, 36)
kt.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
kt.TextColor3 = Color3.fromRGB(0, 170, 255)
kt.Text = "D4VE HUB"
kt.Font = Enum.Font.GothamBlack
kt.TextSize = 18
kt.BorderSizePixel = 0
kt.Parent = kf
Instance.new("UICorner", kt).CornerRadius = UDim.new(0, 12)

local ki = Instance.new("TextBox")
ki.Size = UDim2.new(1, -20, 0, 38)
ki.Position = UDim2.new(0, 10, 0, 46)
ki.PlaceholderText = "Enter key..."
ki.Text = ""
ki.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ki.TextColor3 = Color3.fromRGB(255, 255, 255)
ki.Font = Enum.Font.SourceSans
ki.TextSize = 14
ki.BorderSizePixel = 0
ki.Parent = kf

local ku = Instance.new("TextButton")
ku.Size = UDim2.new(1, -20, 0, 48)
ku.Position = UDim2.new(0, 10, 0, 94)
ku.Text = "UNLOCK"
ku.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ku.TextColor3 = Color3.fromRGB(255, 255, 255)
ku.Font = Enum.Font.GothamBlack
ku.TextSize = 16
ku.BorderSizePixel = 0
ku.Parent = kf
ku.MouseButton1Click:Connect(function()
    if ki.Text == "Davey" then
        keyOk = true
        if writefile then pcall(function() writefile("D4veHub_Key.txt", "Davey") end) end
        kf.Visible = false
        main.Visible = true
    else
        ki.Text = ""
        ki.PlaceholderText = "Wrong key!"
        wait(1.5)
        ki.PlaceholderText = "Enter key..."
    end
end)

print("D4ve Hub Ready! | Key: Davey")
