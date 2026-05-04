-- ============================================
-- SERVER HOPPER - KEY SYSTEM WITH SAVE
-- Key: Davey
-- Auto-saves key after first correct entry
-- Mobile & PC Support | Everyone Can Use
-- ============================================

-- ===== SERVER SIDE =====
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

if not ReplicatedStorage:FindFirstChild("ServerHopEvent") then
    local hopEvent = Instance.new("RemoteEvent")
    hopEvent.Name = "ServerHopEvent"
    hopEvent.Parent = ReplicatedStorage
    
    hopEvent.OnServerEvent:Connect(function(player, placeId)
        if not placeId or type(placeId) ~= "number" then
            warn("Invalid Place ID from: " .. player.Name)
            return
        end
        
        print(player.Name .. " is hopping to Place ID: " .. placeId)
        
        local options = Instance.new("TeleportOptions")
        options.ShouldShowTeleportDialog = false
        
        local success, err = pcall(function()
            TeleportService:Teleport(placeId, player, nil, nil, options)
        end)
        
        if not success then
            warn("Teleport failed: " .. tostring(err))
        end
    end)
    
    print("Server Hop Event created!")
end

-- ===== CLIENT GUI SIDE (Mobile + PC + Key Save) =====
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
local savedKey = readfile and pcall(function() return readfile("ServerHopper_Key.txt") end)
if savedKey then
    local fileContent = readfile("ServerHopper_Key.txt")
    if fileContent == correctKey then
        keyAccepted = true
        print("Key auto-loaded!")
    end
end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ServerHopper"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== KEY FRAME =====
local keyFrameSize = isMobile and UDim2.new(0, 240, 0, 150) or UDim2.new(0, 280, 0, 170)
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
keyTitle.Size = UDim2.new(1, 0, 0, 38)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.Text = "ENTER KEY"
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = isMobile and 14 or 17
keyTitle.BorderSizePixel = 0
keyTitle.Parent = keyFrame

local ktCorner = Instance.new("UICorner")
ktCorner.CornerRadius = UDim.new(0, 14)
ktCorner.Parent = keyTitle

-- Key Input
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0, 38)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
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

-- Submit Button
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 42)
submitBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
submitBtn.Text = "SUBMIT"
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
keyStatus.Size = UDim2.new(1, 0, 0, 20)
keyStatus.Position = UDim2.new(0, 0, 0.88, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.Text = "Enter key to continue..."
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 11
keyStatus.Parent = keyFrame

-- ===== MAIN HOPPER FRAME (Hidden until key accepted) =====
local mainFrameSize = isMobile and UDim2.new(0, 240, 0, 160) or UDim2.new(0, 280, 0, 170)
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

-- Main Title
local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0, 38)
mainTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainTitle.TextColor3 = Color3.fromRGB(0, 255, 170)
mainTitle.Text = "SERVER HOPPER"
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = isMobile and 13 or 16
mainTitle.BorderSizePixel = 0
mainTitle.Parent = mainFrame

local mtCorner = Instance.new("UICorner")
mtCorner.CornerRadius = UDim.new(0, 14)
mtCorner.Parent = mainTitle

-- Close Button Main
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 5)
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

-- Place ID Input
local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.8, 0, 0, 38)
placeInput.Position = UDim2.new(0.1, 0, 0.3, 0)
placeInput.PlaceholderText = "Enter Place ID..."
placeInput.Text = ""
placeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
placeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
placeInput.Font = Enum.Font.SourceSans
placeInput.TextSize = 14
placeInput.BorderSizePixel = 0
placeInput.Parent = mainFrame

local piCorner = Instance.new("UICorner")
piCorner.CornerRadius = UDim.new(0, 8)
piCorner.Parent = placeInput

-- Hop Button
local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.8, 0, 0, 42)
hopBtn.Position = UDim2.new(0.1, 0, 0.58, 0)
hopBtn.Text = "HOP SERVER"
hopBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
hopBtn.BorderSizePixel = 0
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = 15
hopBtn.AutoButtonColor = false
hopBtn.Parent = mainFrame

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 10)
hbCorner.Parent = hopBtn

-- Hop Glow
local hopGlow = Instance.new("Frame")
hopGlow.Size = UDim2.new(1, 0, 0, 3)
hopGlow.Position = UDim2.new(0, 0, 1, -3)
hopGlow.BorderSizePixel = 0
hopGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
hopGlow.Parent = hopBtn

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.88, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Ready to hop"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- ===== KEY SUBMIT FUNCTION =====
submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyAccepted = true
        
        -- Save key to file
        if writefile then
            pcall(function()
                writefile("ServerHopper_Key.txt", correctKey)
            end)
        end
        
        -- Switch frames
        keyFrame.Visible = false
        mainFrame.Visible = true
        keyStatus.Text = "Key accepted! Saved."
        keyStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        keyStatus.Text = "Wrong key! Try again."
        keyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        keyStatus.Text = "Enter key to continue..."
        keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- Submit Hover Effects
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

-- ===== HOP FUNCTION =====
hopBtn.MouseButton1Click:Connect(function()
    local placeId = tonumber(placeInput.Text)
    
    if not placeId then
        statusLabel.Text = "Invalid Place ID!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        statusLabel.Text = "Ready to hop"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    
    statusLabel.Text = "Hopping..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    hopEvent:FireServer(placeId)
end)

-- Hop Button Hover
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

print("Server Hopper loaded!")
]]

loadstring(guiCode)()
