-- ============================================
-- D4VE HUB - SERVER HOPPER
-- Key: Davey
-- Server Hop + Rejoin + Custom Hop
-- Mobile & PC Support | Everyone Can Use
-- ============================================

-- ===== SERVER SIDE =====
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

if not ReplicatedStorage:FindFirstChild("ServerHopEvent") then
    local hopEvent = Instance.new("RemoteEvent")
    hopEvent.Name = "ServerHopEvent"
    hopEvent.Parent = ReplicatedStorage
    
    hopEvent.OnServerEvent:Connect(function(player, placeId, jobId)
        if not placeId or type(placeId) ~= "number" then
            warn("Invalid Place ID from: " .. player.Name)
            return
        end
        
        print(player.Name .. " is hopping to Place ID: " .. placeId)
        
        local options = Instance.new("TeleportOptions")
        options.ShouldShowTeleportDialog = false
        
        -- If JobId provided = rejoin same server
        if jobId and jobId ~= "" then
            options.ServerInstanceId = jobId
        end
        
        local success, err = pcall(function()
            TeleportService:Teleport(placeId, player, nil, nil, options)
        end)
        
        if not success then
            warn("Teleport failed: " .. tostring(err))
        end
    end)
    
    print("D4ve Hub Server Hop Event created!")
end

-- ===== CLIENT GUI SIDE =====
local guiCode = [[
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local hopEvent = ReplicatedStorage:WaitForChild("ServerHopEvent")

-- Detect Mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Key System with Save
local correctKey = "Davey"
local keyAccepted = false

-- Check if key was already saved
local savedKey = readfile and pcall(function() return readfile("D4veHub_Key.txt") end)
if savedKey then
    local fileContent = readfile("D4veHub_Key.txt")
    if fileContent == correctKey then
        keyAccepted = true
        print("D4ve Hub Key auto-loaded!")
    end
end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== KEY FRAME =====
local keyFrameSize = isMobile and UDim2.new(0, 250, 0, 170) or UDim2.new(0, 290, 0, 190)
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = keyFrameSize
keyFrame.Position = UDim2.new(0.5, -keyFrameSize.X.Offset/2, 0.5, -keyFrameSize.Y.Offset/2)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyAccepted
keyFrame.Parent = gui

local kfCorner = Instance.new("UICorner")
kfCorner.CornerRadius = UDim.new(0, 14)
kfCorner.Parent = keyFrame

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(0, 170, 255)
kfStroke.Transparency = 0.5
kfStroke.Thickness = 1.5
kfStroke.Parent = keyFrame

-- Key Title
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 42)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.Text = "D4VE HUB"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = isMobile and 17 or 21
keyTitle.BorderSizePixel = 0
keyTitle.Parent = keyFrame

local ktCorner = Instance.new("UICorner")
ktCorner.CornerRadius = UDim.new(0, 14)
ktCorner.Parent = keyTitle

-- Key Subtitle
local keySubtitle = Instance.new("TextLabel")
keySubtitle.Size = UDim2.new(1, 0, 0, 18)
keySubtitle.Position = UDim2.new(0, 0, 0.28, 0)
keySubtitle.BackgroundTransparency = 1
keySubtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
keySubtitle.Text = "Enter your key to unlock"
keySubtitle.Font = Enum.Font.SourceSans
keySubtitle.TextSize = 12
keySubtitle.Parent = keyFrame

-- Key Input
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.82, 0, 0, 40)
keyInput.Position = UDim2.new(0.09, 0, 0.42, 0)
keyInput.PlaceholderText = "Enter key..."
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 14
keyInput.BorderSizePixel = 0
keyInput.Parent = keyFrame

local kiCorner = Instance.new("UICorner")
kiCorner.CornerRadius = UDim.new(0, 8)
kiCorner.Parent = keyInput

local kiStroke = Instance.new("UIStroke")
kiStroke.Color = Color3.fromRGB(60, 60, 70)
kiStroke.Thickness = 1
kiStroke.Parent = keyInput

keyInput.Focused:Connect(function()
    TweenService:Create(kiStroke, TweenInfo.new(0.3), {
        Color = Color3.fromRGB(0, 170, 255)
    }):Play()
end)

keyInput.FocusLost:Connect(function()
    TweenService:Create(kiStroke, TweenInfo.new(0.3), {
        Color = Color3.fromRGB(60, 60, 70)
    }):Play()
end)

-- Submit Button
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.82, 0, 0, 44)
submitBtn.Position = UDim2.new(0.09, 0, 0.68, 0)
submitBtn.Text = "UNLOCK"
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.BorderSizePixel = 0
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBlack
submitBtn.TextSize = 16
submitBtn.AutoButtonColor = false
submitBtn.Parent = keyFrame

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 10)
sbCorner.Parent = submitBtn

-- Submit Glow
local submitGlow = Instance.new("Frame")
submitGlow.Size = UDim2.new(1, 0, 0, 3)
submitGlow.Position = UDim2.new(0, 0, 1, -3)
submitGlow.BorderSizePixel = 0
submitGlow.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
submitGlow.Parent = submitBtn

-- Key Status
local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, 0, 0, 18)
keyStatus.Position = UDim2.new(0, 0, 0.92, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.Text = ""
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 11
keyStatus.Parent = keyFrame

-- ===== MAIN HUB FRAME =====
local mainFrameSize = isMobile and UDim2.new(0, 250, 0, 240) or UDim2.new(0, 290, 0, 260)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset/2, 0.5, -mainFrameSize.Y.Offset/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = keyAccepted
mainFrame.Parent = gui

local mfCorner = Instance.new("UICorner")
mfCorner.CornerRadius = UDim.new(0, 14)
mfCorner.Parent = mainFrame

local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(0, 255, 170)
mfStroke.Transparency = 0.5
mfStroke.Thickness = 1.5
mfStroke.Parent = mainFrame

-- Hub Title
local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1, 0, 0, 42)
hubTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
hubTitle.TextColor3 = Color3.fromRGB(0, 255, 170)
hubTitle.Text = "D4VE HUB"
hubTitle.Font = Enum.Font.GothamBlack
hubTitle.TextSize = isMobile and 17 or 21
hubTitle.BorderSizePixel = 0
hubTitle.Parent = mainFrame

local htCorner = Instance.new("UICorner")
htCorner.CornerRadius = UDim.new(0, 14)
htCorner.Parent = hubTitle

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 7)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = mainFrame

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 8)
cbCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    }):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    }):Play()
end)

-- ===== SERVER HOP BUTTON =====
local serverHopBtn = Instance.new("TextButton")
serverHopBtn.Size = UDim2.new(0.85, 0, 0, 42)
serverHopBtn.Position = UDim2.new(0.075, 0, 0.2, 0)
serverHopBtn.Text = "SERVER HOP 🔄"
serverHopBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
serverHopBtn.BorderSizePixel = 0
serverHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
serverHopBtn.Font = Enum.Font.GothamBlack
serverHopBtn.TextSize = isMobile and 12 or 14
serverHopBtn.AutoButtonColor = false
serverHopBtn.Parent = mainFrame

local shbCorner = Instance.new("UICorner")
shbCorner.CornerRadius = UDim.new(0, 10)
shbCorner.Parent = serverHopBtn

local shbGlow = Instance.new("Frame")
shbGlow.Size = UDim2.new(1, 0, 0, 3)
shbGlow.Position = UDim2.new(0, 0, 1, -3)
shbGlow.BorderSizePixel = 0
shbGlow.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
shbGlow.Parent = serverHopBtn

-- ===== REJOIN BUTTON =====
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0.85, 0, 0, 42)
rejoinBtn.Position = UDim2.new(0.075, 0, 0.4, 0)
rejoinBtn.Text = "REJOIN 🔁"
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Font = Enum.Font.GothamBlack
rejoinBtn.TextSize = isMobile and 12 or 14
rejoinBtn.AutoButtonColor = false
rejoinBtn.Parent = mainFrame

local rjbCorner = Instance.new("UICorner")
rjbCorner.CornerRadius = UDim.new(0, 10)
rjbCorner.Parent = rejoinBtn

local rjbGlow = Instance.new("Frame")
rjbGlow.Size = UDim2.new(1, 0, 0, 3)
rjbGlow.Position = UDim2.new(0, 0, 1, -3)
rjbGlow.BorderSizePixel = 0
rjbGlow.BackgroundColor3 = Color3.fromRGB(140, 110, 255)
rjbGlow.Parent = rejoinBtn

-- Place ID Input
local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.85, 0, 0, 36)
placeInput.Position = UDim2.new(0.075, 0, 0.62, 0)
placeInput.PlaceholderText = "Enter Place ID..."
placeInput.Text = ""
placeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
placeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
placeInput.Font = Enum.Font.SourceSans
placeInput.TextSize = 13
placeInput.BorderSizePixel = 0
placeInput.Parent = mainFrame

local piCorner = Instance.new("UICorner")
piCorner.CornerRadius = UDim.new(0, 8)
piCorner.Parent = placeInput

-- Custom Hop Button
local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.85, 0, 0, 42)
hopBtn.Position = UDim2.new(0.075, 0, 0.8, 0)
hopBtn.Text = "CUSTOM HOP 🎯"
hopBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
hopBtn.BorderSizePixel = 0
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = isMobile and 12 or 14
hopBtn.AutoButtonColor = false
hopBtn.Parent = mainFrame

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 10)
hbCorner.Parent = hopBtn

local hopGlow = Instance.new("Frame")
hopGlow.Size = UDim2.new(1, 0, 0, 3)
hopGlow.Position = UDim2.new(0, 0, 1, -3)
hopGlow.BorderSizePixel = 0
hopGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
hopGlow.Parent = hopBtn

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0.94, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Ready"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- ===== KEY SUBMIT FUNCTION =====
submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyAccepted = true
        
        if writefile then
            pcall(function()
                writefile("D4veHub_Key.txt", correctKey)
            end)
        end
        
        keyFrame.Visible = false
        mainFrame.Visible = true
    else
        keyStatus.Text = "Wrong key!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        keyStatus.Text = ""
        keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

submitBtn.MouseEnter:Connect(function()
    TweenService:Create(submitBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 190, 255)
    }):Play()
end)

submitBtn.MouseLeave:Connect(function()
    TweenService:Create(submitBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    }):Play()
end)

-- ===== SERVER HOP (New Server) =====
serverHopBtn.MouseButton1Click:Connect(function()
    local currentPlaceId = game.PlaceId
    statusLabel.Text = "Finding new server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    hopEvent:FireServer(currentPlaceId, nil)
end)

serverHopBtn.MouseEnter:Connect(function()
    TweenService:Create(serverHopBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 160, 20)
    }):Play()
end)

serverHopBtn.MouseLeave:Connect(function()
    TweenService:Create(serverHopBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    }):Play()
end)

-- ===== REJOIN (Same Server) =====
rejoinBtn.MouseButton1Click:Connect(function()
    local currentPlaceId = game.PlaceId
    local currentJobId = game.JobId
    statusLabel.Text = "Rejoining same server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    hopEvent:FireServer(currentPlaceId, currentJobId)
end)

rejoinBtn.MouseEnter:Connect(function()
    TweenService:Create(rejoinBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(120, 80, 255)
    }):Play()
end)

rejoinBtn.MouseLeave:Connect(function()
    TweenService:Create(rejoinBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(100, 60, 255)
    }):Play()
end)

-- ===== CUSTOM HOP =====
hopBtn.MouseButton1Click:Connect(function()
    local placeId = tonumber(placeInput.Text)
    
    if not placeId then
        statusLabel.Text = "Invalid Place ID!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    
    statusLabel.Text = "Hopping..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    hopEvent:FireServer(placeId, nil)
end)

hopBtn.MouseEnter:Connect(function()
    TweenService:Create(hopBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 220, 150)
    }):Play()
end)

hopBtn.MouseLeave:Connect(function()
    TweenService:Create(hopBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 200, 130)
    }):Play()
end)

print("D4ve Hub loaded!")
]]

loadstring(guiCode)()
