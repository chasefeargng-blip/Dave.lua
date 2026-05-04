-- ============================================
-- D4VE HUB - FULL PACKAGE
-- Key: Davey | Mobile + PC | D4 Icon | Draggable | All Working
-- ============================================

local player = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Key check
local keyOk = false
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == "Davey" then keyOk = true end
end

-- ===== TELEPORT =====
local function hop(id)
    local ts = TeleportService
    local opt = Instance.new("TeleportOptions")
    opt.ShouldShowTeleportDialog = false
    ts:Teleport(id, player, nil, nil, opt)
end

-- ===== D4 ICON (Draggable) =====
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

-- Dragging
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
UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - sPos
        if math.abs(d.X) > 2 or math.abs(d.Y) > 2 then moved = true end
        d4.Position = UDim2.new(sFrame.X.Scale, sFrame.X.Offset + d.X, sFrame.Y.Scale, sFrame.Y.Offset + d.Y)
    end
end)

-- ===== MAIN FRAME =====
local mSize = isMobile and UDim2.new(0, 240, 0, 230) or UDim2.new(0, 260, 0, 240)
local main = Instance.new("Frame")
main.Size = mSize
main.Position = UDim2.new(0.5, -mSize.X.Offset/2, 0.5, -mSize.Y.Offset/2)
main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
main.BorderSizePixel = 0
main.Visible = keyOk
main.Draggable = true
main.Active = true
main.ZIndex = 5
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Stroke
local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(0, 255, 170)
ms.Thickness = 1.5
ms.Parent = main

-- Title
local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 0, 36)
mt.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
mt.TextColor3 = Color3.fromRGB(0, 255, 170)
mt.Text = "D4VE HUB"
mt.Font = Enum.Font.GothamBlack
mt.TextSize = isMobile and 16 or 18
mt.BorderSizePixel = 0
mt.Parent = main
Instance.new("UICorner", mt).CornerRadius = UDim.new(0, 12)

-- Close
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

-- Minimize
local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 22, 0, 22)
mb.Position = UDim2.new(1, -52, 0, 7)
mb.Text = "_"
mb.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.Font = Enum.Font.GothamBlack
mb.TextSize = 12
mb.BorderSizePixel = 0
mb.Parent = main
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 5)
mb.MouseButton1Click:Connect(function() main.Visible, d4.Visible = false, true end)

-- Status
local st = Instance.new("TextLabel")
st.Size = UDim2.new(1, 0, 0, 16)
st.Position = UDim2.new(0, 0, 0.93, 0)
st.BackgroundTransparency = 1
st.TextColor3 = Color3.fromRGB(150, 150, 150)
st.Text = "Ready"
st.Font = Enum.Font.SourceSans
st.TextSize = 10
st.Parent = main

-- ===== BUTTONS =====
local bw, bx = isMobile and 0.84 or 0.85, isMobile and 0.08 or 0.075

-- Server Hop
local b1 = Instance.new("TextButton")
b1.Size = UDim2.new(bw, 0, 0, 40)
b1.Position = UDim2.new(bx, 0, 0.17, 0)
b1.Text = "SERVER HOP"
b1.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.Font = Enum.Font.GothamBlack
b1.TextSize = isMobile and 12 or 14
b1.BorderSizePixel = 0
b1.Parent = main
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 8)
b1.MouseButton1Click:Connect(function() st.Text = "Hopping..."; st.TextColor3 = Color3.fromRGB(255, 200, 50); hop(game.PlaceId) end)

-- Rejoin
local b2 = Instance.new("TextButton")
b2.Size = UDim2.new(bw, 0, 0, 40)
b2.Position = UDim2.new(bx, 0, 0.38, 0)
b2.Text = "REJOIN"
b2.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.Font = Enum.Font.GothamBlack
b2.TextSize = isMobile and 12 or 14
b2.BorderSizePixel = 0
b2.Parent = main
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 8)
b2.MouseButton1Click:Connect(function() st.Text = "Rejoining..."; st.TextColor3 = Color3.fromRGB(255, 200, 50); hop(game.PlaceId) end)

-- Input
local inp = Instance.new("TextBox")
inp.Size = UDim2.new(bw, 0, 0, 32)
inp.Position = UDim2.new(bx, 0, 0.58, 0)
inp.PlaceholderText = "Place ID..."
inp.Text = ""
inp.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
inp.TextColor3 = Color3.fromRGB(255, 255, 255)
inp.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
inp.Font = Enum.Font.SourceSans
inp.TextSize = isMobile and 12 or 13
inp.BorderSizePixel = 0
inp.Parent = main
Instance.new("UICorner", inp).CornerRadius = UDim.new(0, 6)

-- Custom Hop
local b3 = Instance.new("TextButton")
b3.Size = UDim2.new(bw, 0, 0, 40)
b3.Position = UDim2.new(bx, 0, 0.75, 0)
b3.Text = "CUSTOM HOP"
b3.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
b3.TextColor3 = Color3.fromRGB(255, 255, 255)
b3.Font = Enum.Font.GothamBlack
b3.TextSize = isMobile and 12 or 14
b3.BorderSizePixel = 0
b3.Parent = main
Instance.new("UICorner", b3).CornerRadius = UDim.new(0, 8)
b3.MouseButton1Click:Connect(function()
    local id = tonumber(inp.Text)
    if id then st.Text = "Teleporting..."; st.TextColor3 = Color3.fromRGB(255, 200, 50); hop(id)
    else st.Text = "Invalid ID!"; st.TextColor3 = Color3.fromRGB(255, 60, 60); wait(2); st.Text = "Ready"; st.TextColor3 = Color3.fromRGB(150, 150, 150) end
end)

-- ===== KEY FRAME =====
local kSize = isMobile and UDim2.new(0, 240, 0, 140) or UDim2.new(0, 260, 0, 150)
local kf = Instance.new("Frame")
kf.Size = kSize
kf.Position = UDim2.new(0.5, -kSize.X.Offset/2, 0.5, -kSize.Y.Offset/2)
kf.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
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
kt.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
kt.TextColor3 = Color3.fromRGB(0, 170, 255)
kt.Text = "D4VE HUB"
kt.Font = Enum.Font.GothamBlack
kt.TextSize = isMobile and 16 or 18
kt.BorderSizePixel = 0
kt.Parent = kf
Instance.new("UICorner", kt).CornerRadius = UDim.new(0, 12)

local ki = Instance.new("TextBox")
ki.Size = UDim2.new(0.82, 0, 0, 34)
ki.Position = UDim2.new(0.09, 0, 0.38, 0)
ki.PlaceholderText = "Enter key..."
ki.Text = ""
ki.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
ki.TextColor3 = Color3.fromRGB(255, 255, 255)
ki.Font = Enum.Font.SourceSans
ki.TextSize = 13
ki.BorderSizePixel = 0
ki.Parent = kf
Instance.new("UICorner", ki).CornerRadius = UDim.new(0, 6)

local ku = Instance.new("TextButton")
ku.Size = UDim2.new(0.82, 0, 0, 38)
ku.Position = UDim2.new(0.09, 0, 0.65, 0)
ku.Text = "UNLOCK"
ku.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ku.TextColor3 = Color3.fromRGB(255, 255, 255)
ku.Font = Enum.Font.GothamBlack
ku.TextSize = 14
ku.BorderSizePixel = 0
ku.Parent = kf
Instance.new("UICorner", ku).CornerRadius = UDim.new(0, 8)
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

print("D4ve Hub Ready! Mobile + PC | Key: Davey")
