-- Name: ErYx on Top (Reverted Configuration Layout)
-- Execution: Run inside your environment executor (e.g., Delta)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

if game:GetService("CoreGui"):FindFirstChild("ErYxOnTopHorizontal") then
    game:GetService("CoreGui").ErYxOnTopHorizontal:Destroy()
end

-- --- UI CONFIGURATION ---
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "ErYxOnTopHorizontal"
gui.ResetOnSpawn = false

local BACK_COLOR = Color3.fromRGB(12, 12, 12)
local PURPLE_ACCENT = Color3.fromRGB(140, 50, 255)

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.fromOffset(630, 95)  
mainFrame.Position = UDim2.new(0.5, -315, 0.8, -47) 
mainFrame.BackgroundColor3 = BACK_COLOR
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = PURPLE_ACCENT
mainStroke.Thickness = 2

-- Top Header Window Drag Handle
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 25)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 10)

local headerTitle = Instance.new("TextLabel", header)
headerTitle.Size = UDim2.new(1, -50, 1, 0)
headerTitle.Position = UDim2.fromOffset(12, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Text = "ErYx on Top | Shape Configurator"
headerTitle.TextColor3 = Color3.new(1, 1, 1)
headerTitle.Font = Enum.Font.SourceSansBold
headerTitle.TextSize = 13
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Minimise Button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.fromOffset(18, 18)
closeBtn.Position = UDim2.new(1, -24, 0.5, -9)
closeBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
closeBtn.Text = "—"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", closeBtn).Color = PURPLE_ACCENT

-- Open Trigger Rebranded Text Button ("ErYx")
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.fromOffset(65, 35)
openBtn.Position = UDim2.new(0, -85, 0.5, -17)
openBtn.BackgroundColor3 = BACK_COLOR
openBtn.Text = "ErYx"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.SourceSansBold
openBtn.TextSize = 14
openBtn.Visible = false
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 6)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = PURPLE_ACCENT
openStroke.Thickness = 2

-- Dragging Functionality
local function makeDraggable(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    handle.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end
makeDraggable(mainFrame, header)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false; openBtn.Visible = true
    TweenService:Create(openBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 20, 0.5, -17)}):Play()
end)
openBtn.MouseButton1Click:Connect(function()
    openBtn.Visible = false; mainFrame.Visible = true
    openBtn.Position = UDim2.new(0, -85, 0.5, -17)
end)

-- --- HORIZONTAL CONTAINER SETUP ---
local horizontalContainer = Instance.new("Frame", mainFrame)
horizontalContainer.Size = UDim2.new(1, -20, 0, 55)
horizontalContainer.Position = UDim2.fromOffset(10, 32)
horizontalContainer.BackgroundTransparency = 1

local horizLayout = Instance.new("UIListLayout", horizontalContainer)
horizLayout.FillDirection = Enum.FillDirection.Horizontal
horizLayout.Padding = UDim.new(0, 8)
horizLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- --- HORIZONTAL SLIDER BUILDER ---
local function createHorizontalSlider(parent, name, min, max, defaultVal, isFloat, width)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.fromOffset(width, 45)
    container.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(1, 0, 0, 14)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = name .. ": " .. tostring(defaultVal)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBg = Instance.new("TextButton", container)
    sliderBg.Size = UDim2.new(1, 0, 0, 5)
    sliderBg.Position = UDim2.new(0, 0, 0, 18)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBg.Text = ""
    sliderBg.AutoButtonColor = false
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 2)

    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.Size = UDim2.new((defaultVal - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = PURPLE_ACCENT
    sliderFill.BorderSizePixel = 0
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 2)

    local value = defaultVal
    local dragging = false

    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local rawValue = min + pos * (max - min)
        value = isFloat and math.floor(rawValue * 100) / 100 or math.floor(rawValue)
        label.Text = name .. ": " .. tostring(value)
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; update(input) end
    end)
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
    end)

    return function() return value end
end

-- Sliders
local getRadius = createHorizontalSlider(horizontalContainer, "Radius/Scale", 1, 15, 4, true, 75)
local getSpeed = createHorizontalSlider(horizontalContainer, "Movement Speed", 1, 50, 14, false, 75)
local getHeightOffset = createHorizontalSlider(horizontalContainer, "Height", -8, 8, 0, true, 75)
local getSeparation = createHorizontalSlider(horizontalContainer, "Anti-Overlap", 1, 10, 3, true, 75)

-- --- INTERACTION BUTTONS ---
local cycleBtn = Instance.new("TextButton", horizontalContainer)
cycleBtn.Size = UDim2.fromOffset(105, 34)
cycleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
cycleBtn.Text = "Dih"
cycleBtn.TextColor3 = Color3.fromRGB(200, 160, 255)
cycleBtn.Font = Enum.Font.SourceSansBold
cycleBtn.TextSize = 12
Instance.new("UICorner", cycleBtn).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", cycleBtn).Color = PURPLE_ACCENT

-- Extra Wing Profile Customizer Switcher Button
local wingTypeBtn = Instance.new("TextButton", horizontalContainer)
wingTypeBtn.Size = UDim2.fromOffset(100, 34)
wingTypeBtn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
wingTypeBtn.Text = "Style: Angel"
wingTypeBtn.TextColor3 = Color3.fromRGB(180, 220, 255)
wingTypeBtn.Font = Enum.Font.SourceSansBold
wingTypeBtn.TextSize = 11
wingTypeBtn.Visible = false 
Instance.new("UICorner", wingTypeBtn).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", wingTypeBtn).Color = Color3.fromRGB(80, 140, 255)

local toggleBtn = Instance.new("TextButton", horizontalContainer)
toggleBtn.Size = UDim2.fromOffset(85, 34)
toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
toggleBtn.Text = "[ OFF ]"
toggleBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 13
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 5)
local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Color = Color3.fromRGB(220, 80, 80)

local currentMode = 1
local modeNames = {
    [1] = "Dih",
    [2] = "Custom Wings",
    [3] = "Top-To-Bottom Roll",
    [4] = "Double Diagonal X",
    [5] = "7 Head / 8 Legs",
    [6] = "Tornado Vortex",
    [7] = "Horizontal Halo",
    [8] = "Spiritual Aura"
}

local currentWingStyle = 1
local wingStyleNames = {
    [1] = "Style: Angel",
    [2] = "Style: Demon/Bat",
    [3] = "Style: Butterfly"
}

cycleBtn.MouseButton1Click:Connect(function()
    currentMode = (currentMode % #modeNames) + 1
    cycleBtn.Text = modeNames[currentMode]
    wingTypeBtn.Visible = (currentMode == 2) 
end)

wingTypeBtn.MouseButton1Click:Connect(function()
    currentWingStyle = (currentWingStyle % #wingStyleNames) + 1
    wingTypeBtn.Text = wingStyleNames[currentWingStyle]
end)

-- --- ENGINE LOOP ---
local isActive = false

local function runEngine()
    while isActive do
        RunService.RenderStepped:Wait()
        
        local props = {}
        local trafficCones = workspace:FindFirstChild("WorkspaceCom") and workspace.WorkspaceCom:FindFirstChild("001_TrafficCones")
        if trafficCones then
            for _, v in pairs(trafficCones:GetChildren()) do
                if string.find(v.Name, "Prop" .. lp.Name) then
                    local remote = v:FindFirstChild("SetCurrentCFrame")
                    if remote then 
                        table.insert(props, remote) 
                        if #props >= 15 then break end
                    end
                end
            end
        end

        if #props > 0 and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            local root = lp.Character.HumanoidRootPart
            local radius = getRadius()
            local speed = getSpeed()
            local baseHeightBias = getHeightOffset()
            local spreadSpacer = getSeparation() * 0.4 
            
            local internalTime = tick() * (speed * 0.1) 

            for index, remote in ipairs(props) do
                if index > 15 then break end
                local targetCFrame = root.CFrame
                local antiOverlapFactor = index * spreadSpacer

                if currentMode == 1 then
                    -- --- 1. "Dih" MODE (Exactly 2 Max at Hips facing X-Axis, rest Halo) ---
                    if index <= 2 then
                        local sideSign = (index == 1) and -1 or 1
                        local x = (radius * 0.4) * sideSign
                        local y = -1.1 + baseHeightBias 
                        local z = 0
                        targetCFrame = root.CFrame * CFrame.new(x, y, z) * CFrame.Angles(math.rad(15), math.rad(90 * sideSign), 0)
                    else
                        local haloIndex = index - 2
                        local distAngle = (haloIndex / 13) * math.pi * 2 + (internalTime * 2)
                        local x = math.cos(distAngle) * radius
                        local z = math.sin(distAngle) * radius
                        targetCFrame = root.CFrame * CFrame.new(x, 3.2 + baseHeightBias, z) * CFrame.Angles(math.rad(90), -distAngle, 0)
                    end

                elseif currentMode == 2 then
                    -- --- 2. PREMIUM 15-PROP TRUE BACK WINGS ---
                    if index == 15 then
                        targetCFrame = root.CFrame * CFrame.new(0, 0.8 + baseHeightBias, 0.6) * CFrame.Angles(math.rad(90), 0, 0)
                    else
                        local isLeft = (index % 2 == 0)
                        local sideSign = isLeft and -1 or 1
                        local boneIndex = math.ceil(index / 2) 
                        local slowFlap = math.sin(internalTime * 1.3)
                        local x, y, z = 0, 0, 0
                        local yaw, pitch, roll = 0, 0, 0
                        
                        if currentWingStyle == 1 then
                            x = (0.4 + (boneIndex * 0.35) * (radius * 0.45)) * sideSign
                            y = 1.6 - (boneIndex * 0.15) + baseHeightBias 
                            z = 0.6 + (slowFlap * (boneIndex * 0.15)) + (boneIndex * 0.08)
                            yaw = math.rad((25 + (slowFlap * (boneIndex * 6))) * sideSign)
                            roll = math.rad((-10 - (boneIndex * 4)) * sideSign)
                        elseif currentWingStyle == 2 then
                            x = (0.3 + math.log(boneIndex) * (radius * 0.65)) * sideSign
                            y = (0.8 + (math.sin(boneIndex/2) * 1.2)) + baseHeightBias
                            z = 0.6 + (slowFlap * (boneIndex * 0.22))
                            yaw = math.rad((40 + (slowFlap * 20)) * sideSign)
                            pitch = math.rad(-15 * sideSign)
                            roll = math.rad((30 - (boneIndex * 12)) * sideSign)
                        elseif currentWingStyle == 3 then
                            local isTopSail = (boneIndex <= 4)
                            if isTopSail then
                                x = (0.5 + (boneIndex * 0.45)) * sideSign
                                y = 1.0 + (boneIndex * 0.3) + baseHeightBias
                                z = 0.6 + (slowFlap * (boneIndex * 0.12))
                            else
                                local bottomSub = boneIndex - 4
                                x = (0.7 + (bottomSub * 0.35)) * sideSign
                                y = 0.6 - (bottomSub * 0.4) + baseHeightBias
                                z = 0.7 + (slowFlap * (bottomSub * 0.08))
                            end
                            yaw = math.rad((15 + (slowFlap * 15)) * sideSign)
                            roll = math.rad((isTopSail and 20 or -20) * sideSign)
                        end
                        targetCFrame = root.CFrame * CFrame.new(x, y, z) * CFrame.Angles(pitch, yaw, roll)
                    end

                elseif currentMode == 3 then
                    -- --- 3. TOP-TO-BOTTOM VERTICAL WRAPPING LOOP ---
                    local offsetFactor = (index / 15)
                    local waveAngle = (offsetFactor * math.pi * 2) - (internalTime * 3)
                    local x = math.cos(waveAngle) * radius
                    local z = math.sin(waveAngle) * radius
                    local y = 3.5 - (offsetFactor * 7.0) + baseHeightBias
                    targetCFrame = root.CFrame * CFrame.new(x, y, z) * CFrame.Angles(0, -waveAngle, 0)

                elseif currentMode == 4 then
                    -- --- 4. DOUBLE DIAGONAL INTERSECTING "X" ORBITS ---
                    local isSplitLeft = (index <= 8)
                    local angle = (index / 8) * math.pi * 2 + (internalTime * 2)
                    local x = math.cos(angle) * radius
                    local ringPos = math.sin(angle) * radius
                    
                    if isSplitLeft then
                        targetCFrame = root.CFrame * CFrame.new(x, ringPos + baseHeightBias, ringPos * 0.5) * CFrame.Angles(0, -angle, math.rad(45))
                    else
                        targetCFrame = root.CFrame * CFrame.new(x, ringPos + baseHeightBias, -ringPos * 0.5) * CFrame.Angles(0, -angle, math.rad(-45))
                    end

                elseif currentMode == 5 then
                    -- --- 5. 7 HEAD / 8 LEGS CLASSIC SPLIT ---
                    if index <= 7 then
                        local distAngle = (index / 7) * math.pi * 2 + (internalTime * 2)
                        local x = math.cos(distAngle) * radius
                        local z = math.sin(distAngle) * radius
                        targetCFrame = root.CFrame * CFrame.new(x, 3.0 + baseHeightBias, z) * CFrame.Angles(math.rad(90), -distAngle, 0)
                    else
                        local legIndex = index - 7
                        local distAngle = (legIndex / 8) * math.pi * 2 - (internalTime * 1.5)
                        local x = math.cos(distAngle) * (radius * 0.8)
                        local z = math.sin(distAngle) * (radius * 0.8)
                        targetCFrame = root.CFrame * CFrame.new(x, -2.5 + baseHeightBias, z) * CFrame.Angles(0, -distAngle, 0)
                    end
                    
                elseif currentMode == 6 then
                    -- --- 6. TORNADO VORTEX ---
                    local angleIncrement = (index / 15) * math.pi * 8 + (internalTime * 4)
                    local dynamicConeRadius = (index / 15) * radius * 1.2
                    local verticalSpiral = -3.0 + ((index / 15) * 7.0) + baseHeightBias
                    local x = math.cos(angleIncrement) * dynamicConeRadius
                    local z = math.sin(angleIncrement) * dynamicConeRadius
                    targetCFrame = root.CFrame * CFrame.new(x, verticalSpiral, z) * CFrame.Angles(0, -angleIncrement, 0)

                elseif currentMode == 7 then
                    -- --- 7. HORIZONTAL HALO RING ---
                    local distAngle = (index / #props) * math.pi * 2 + (internalTime * 2)
                    local x = math.cos(distAngle) * (radius + antiOverlapFactor * 0.1)
                    local z = math.sin(distAngle) * (radius + antiOverlapFactor * 0.1)
                    targetCFrame = root.CFrame * CFrame.new(x, 3.0 + baseHeightBias, z) * CFrame.Angles(math.rad(90), -distAngle, 0)

                elseif currentMode == 8 then
                    -- --- 8. SPIRITUAL AURA ---
                    local layerIndex = (index % 3)
                    local angleIndex = (index / 15) * math.pi * 2 + internalTime
                    local waveOscillation = math.sin(internalTime * 2 + index) * 0.3
                    local currentRadius = radius * (0.6 + (layerIndex * 0.25))
                    local currentHeight = -2.0 + (layerIndex * 2.2) + waveOscillation + baseHeightBias
                    local x = math.cos(angleIndex) * currentRadius
                    local z = math.sin(angleIndex) * currentRadius
                    targetCFrame = root.CFrame * CFrame.new(x, currentHeight, z) * CFrame.Angles(0, -angleIndex, math.rad(45))
                end

                task.spawn(function()
                    pcall(function() remote:InvokeServer(targetCFrame) end)
                end)
            end
        end
    end
end

-- Master Trigger
toggleBtn.MouseButton1Click:Connect(function()
    isActive = not isActive
    if isActive then
        toggleBtn.Text = "[ ACTIVE ]"
        toggleBtn.TextColor3 = Color3.fromRGB(80, 220, 120)
        toggleStroke.Color = Color3.fromRGB(80, 220, 120)
        task.spawn(runEngine)
    else
        toggleBtn.Text = "[ OFF ]"
        toggleBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
        toggleStroke.Color = Color3.fromRGB(220, 80, 80)
    end
end)

