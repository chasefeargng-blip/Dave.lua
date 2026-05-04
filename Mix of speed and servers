-- ============================================
-- D4VE HUB x NATHUB - FINAL
-- Discord: discord.gg/kqfvs9ndJ & discord.gg/z2H9a75UZn
-- Key wordt automatisch onthouden!
-- ============================================

local player = game.Players.LocalPlayer
local ts = game:GetService("TeleportService")
local uis = game:GetService("UserInputService")
local isMobile = uis.TouchEnabled and not uis.KeyboardEnabled

-- Key
local correctKey = "Davey"
local keyOk = false
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == correctKey then keyOk = true end
end

local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function getHum()
    local char = player.Character
    if char then return char:FindFirstChild("Humanoid") end
    return nil
end

local function setSpeed(val)
    local hum = getHum()
    if hum then hum.WalkSpeed = val end
end

local function hop(id)
    ts:Teleport(id, player)
end

-- ===== D4 ICON =====
local d4 = Instance.new("TextButton")
d4.Size = UDim2.new(0, 44, 0, 44)
d4.Position = UDim2.new(0.02, 0, 0.02, 0)
d4.Text = "D4"
d4.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
d4.TextColor3 = Color3.fromRGB(0, 0, 0)
d4.Font = Enum.Font.GothamBlack
d4.TextSize = 15
d4.BorderSizePixel = 0
d4.Visible = false
d4.ZIndex = 10
d4.Parent = gui
Instance.new("UICorner", d4).CornerRadius = UDim.new(1, 0)

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

-- ===== KEY FRAME =====
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 250, 0, 200)
keyFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyOk
keyFrame.ZIndex = 5
keyFrame.Parent = gui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local ks = Instance.new("UIStroke")
ks.Color = Color3.fromRGB(0, 170, 255)
ks.Thickness = 1.5
ks.Parent = keyFrame

local kt = Instance.new("TextLabel")
kt.Size = UDim2.new(1, 0, 0, 35)
kt.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
kt.TextColor3 = Color3.fromRGB(0, 170, 255)
kt.Text = "D4VE HUB x NATHUB"
kt.Font = Enum.Font.GothamBlack
kt.TextSize = 14
kt.BorderSizePixel = 0
kt.Parent = keyFrame
Instance.new("UICorner", kt).CornerRadius = UDim.new(0, 12)

-- Discord info
local dc = Instance.new("TextLabel")
dc.Size = UDim2.new(1, 0, 0, 28)
dc.Position = UDim2.new(0, 0, 0.22, 0)
dc.BackgroundTransparency = 1
dc.TextColor3 = Color3.fromRGB(200, 200, 200)
dc.Text = "Join Discord for Key!"
dc.Font = Enum.Font.SourceSansBold
dc.TextSize = 11
dc.Parent = keyFrame

-- Discord 1
local dc1 = Instance.new("TextButton")
dc1.Size = UDim2.new(0.85, 0, 0, 24)
dc1.Position = UDim2.new(0.075, 0, 0.35, 0)
dc1.Text = "discord.gg/kqfvs9ndJ"
dc1.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
dc1.TextColor3 = Color3.fromRGB(255, 255, 255)
dc1.Font = Enum.Font.SourceSans
dc1.TextSize = 10
dc1.BorderSizePixel = 0
dc1.Parent = keyFrame
Instance.new("UICorner", dc1).CornerRadius = UDim.new(0, 4)

-- Discord 2
local dc2 = Instance.new("TextButton")
dc2.Size = UDim2.new(0.85, 0, 0, 24)
dc2.Position = UDim2.new(0.075, 0, 0.48, 0)
dc2.Text = "discord.gg/z2H9a75UZn"
dc2.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
dc2.TextColor3 = Color3.fromRGB(255, 255, 255)
dc2.Font = Enum.Font.SourceSans
dc2.TextSize = 10
dc2.BorderSizePixel = 0
dc2.Parent = keyFrame
Instance.new("UICorner", dc2).CornerRadius = UDim.new(0, 4)

local ki = Instance.new("TextBox")
ki.Size = UDim2.new(0.85, 0, 0, 30)
ki.Position = UDim2.new(0.075, 0, 0.62, 0)
ki.PlaceholderText = "Enter key..."
ki.Text = ""
ki.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ki.TextColor3 = Color3.fromRGB(255, 255, 255)
ki.Font = Enum.Font.SourceSans
ki.TextSize = 12
ki.BorderSizePixel = 0
ki.Parent = keyFrame
Instance.new("UICorner", ki).CornerRadius = UDim.new(0, 5)

local ku = Instance.new("TextButton")
ku.Size = UDim2.new(0.85, 0, 0, 32)
ku.Position = UDim2.new(0.075, 0, 0.78, 0)
ku.Text = "UNLOCK"
ku.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ku.TextColor3 = Color3.fromRGB(255, 255, 255)
ku.Font = Enum.Font.GothamBlack
ku.TextSize = 14
ku.BorderSizePixel = 0
ku.Parent = keyFrame
Instance.new("UICorner", ku).CornerRadius = UDim.new(0, 6)
ku.MouseButton1Click:Connect(function()
    if ki.Text == correctKey then
        keyOk = true
        if writefile then pcall(function() writefile("D4veHub_Key.txt", correctKey) end) end
        keyFrame.Visible = false
        main.Visible = true
    else
        ki.Text = ""
        ki.PlaceholderText = "Wrong key!"
        wait(1.5)
        ki.PlaceholderText = "Enter key..."
    end
end)

-- ===== MAIN FRAME =====
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 240, 0, 310)
main.Position = UDim2.new(0.5, -120, 0.5, -155)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = keyOk
main.ZIndex = 5
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(0, 255, 170)
ms.Thickness = 1.5
ms.Parent = main

local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 0, 35)
mt.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
mt.TextColor3 = Color3.fromRGB(0, 255, 170)
mt.Text = "D4VE HUB x NATHUB"
mt.Font = Enum.Font.GothamBlack
mt.TextSize = 14
mt.BorderSizePixel = 0
mt.Parent = main
Instance.new("UICorner", mt).CornerRadius = UDim.new(0, 12)

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 22, 0, 22)
cb.Position = UDim2.new(1, -28, 0, 7)
cb.Text = "X"
cb.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.Font = Enum.Font.GothamBold
cb.TextSize = 12
cb.BorderSizePixel = 0
cb.AutoButtonColor = false
cb.Parent = main
Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 5)
cb.MouseButton1Click:Connect(function() gui:Destroy() end)

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 22, 0, 22)
mb.Position = UDim2.new(1, -52, 0, 7)
mb.Text = "_"
mb.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.Font = Enum.Font.GothamBlack
mb.TextSize = 14
mb.BorderSizePixel = 0
mb.Parent = main
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 5)
mb.MouseButton1Click:Connect(function() main.Visible, d4.Visible = false, true end)

-- Server Hop
local b1 = Instance.new("TextButton")
b1.Size = UDim2.new(1, -20, 0, 32)
b1.Position = UDim2.new(0, 10, 0, 40)
b1.Text = "SERVER HOP"
b1.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.Font = Enum.Font.GothamBold
b1.TextSize = 13
b1.BorderSizePixel = 0
b1.Parent = main
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 6)
b1.MouseButton1Click:Connect(function() hop(game.PlaceId) end)

-- Rejoin
local b2 = Instance.new("TextButton")
b2.Size = UDim2.new(1, -20, 0, 32)
b2.Position = UDim2.new(0, 10, 0, 76)
b2.Text = "REJOIN"
b2.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.Font = Enum.Font.GothamBold
b2.TextSize = 13
b2.BorderSizePixel = 0
b2.Parent = main
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 6)
b2.MouseButton1Click:Connect(function() hop(game.PlaceId) end)

-- Speed Boost
local st = Instance.new("TextLabel")
st.Size = UDim2.new(1, 0, 0, 16)
st.Position = UDim2.new(0, 0, 0, 115)
st.BackgroundTransparency = 1
st.TextColor3 = Color3.fromRGB(180, 180, 180)
st.Text = "SPEED BOOST (16-30)"
st.Font = Enum.Font.SourceSans
st.TextSize = 10
st.Parent = main

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(1, -20, 0, 28)
speedInput.Position = UDim2.new(0, 10, 0, 130)
speedInput.Text = "16"
speedInput.PlaceholderText = "16 - 30"
speedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 12
speedInput.BorderSizePixel = 0
speedInput.Parent = main
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 5)

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, -20, 0, 28)
speedBtn.Position = UDim2.new(0, 10, 0, 162)
speedBtn.Text = "SET SPEED"
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 12
speedBtn.BorderSizePixel = 0
speedBtn.Parent = main
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 5)
speedBtn.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val and val >= 16 and val <= 30 then setSpeed(val) end
end)

-- Giant Speed
local gt = Instance.new("TextLabel")
gt.Size = UDim2.new(1, 0, 0, 16)
gt.Position = UDim2.new(0, 0, 0, 197)
gt.BackgroundTransparency = 1
gt.TextColor3 = Color3.fromRGB(180, 180, 180)
gt.Text = "GIANT SPEED (10-34.5)"
gt.Font = Enum.Font.SourceSans
gt.TextSize = 10
gt.Parent = main

local giantInput = Instance.new("TextBox")
giantInput.Size = UDim2.new(1, -20, 0, 28)
giantInput.Position = UDim2.new(0, 10, 0, 212)
giantInput.Text = "10"
giantInput.PlaceholderText = "10 - 34.5"
giantInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
giantInput.TextColor3 = Color3.fromRGB(255, 255, 255)
giantInput.Font = Enum.Font.SourceSans
giantInput.TextSize = 12
giantInput.BorderSizePixel = 0
giantInput.Parent = main
Instance.new("UICorner", giantInput).CornerRadius = UDim.new(0, 5)

local giantBtn = Instance.new("TextButton")
giantBtn.Size = UDim2.new(1, -20, 0, 28)
giantBtn.Position = UDim2.new(0, 10, 0, 244)
giantBtn.Text = "SET GIANT SPEED"
giantBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
giantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giantBtn.Font = Enum.Font.GothamBold
giantBtn.TextSize = 12
giantBtn.BorderSizePixel = 0
giantBtn.Parent = main
Instance.new("UICorner", giantBtn).CornerRadius = UDim.new(0, 5)
giantBtn.MouseButton1Click:Connect(function()
    local val = tonumber(giantInput.Text)
    if val and val >= 10 and val <= 34.5 then setSpeed(val) end
end)

-- Reset
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1, -20, 0, 24)
resetBtn.Position = UDim2.new(0, 10, 0, 278)
resetBtn.Text = "RESET SPEED (16)"
resetBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 10
resetBtn.BorderSizePixel = 0
resetBtn.Parent = main
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 5)
resetBtn.MouseButton1Click:Connect(function() setSpeed(16) end)

print("D4VE HUB x NATHUB Ready!")
print("Discord: discord.gg/kqfvs9ndJ & discord.gg/z2H9a75UZn")
