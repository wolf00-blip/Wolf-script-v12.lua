-- ============ WOLF SCRIPT v12 🐺 ============
-- Часть 1: Каркас меню
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем старый скрипт
for _, v in pairs(playerGui:GetChildren()) do
    if v.Name == "WolfScript" then v:Destroy() end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WolfScript"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ===== ГЛАВНОЕ ОКНО =====
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 360)
main.Position = UDim2.new(0, 30, 0, 30)
main.BackgroundColor3 = Color3.fromRGB(0, 10, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 10
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

-- ГРАДИЕНТ (тёмно-синий → бирюзовый)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 10, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 80))
}
gradient.Rotation = 90
gradient.Parent = main

-- Белая обводка окна
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.2
mainStroke.Parent = main

-- ===== ВЕРХНЯЯ ПОЛОСА =====
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topBar.BackgroundTransparency = 0.5
topBar.BorderSizePixel = 0
topBar.ZIndex = 11
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = topBar

-- Название с волком
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "WOLF SCRIPT 🐺"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 12
title.Parent = topBar

-- Кнопка X (закрыть)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.ZIndex = 12
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(255, 255, 255)
closeStroke.Thickness = 1
closeStroke.Parent = closeBtn

-- Кнопка _ (свернуть)
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 22, 0, 22)
minBtn.Position = UDim2.new(1, -54, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
minBtn.BackgroundTransparency = 0.5
minBtn.Text = "_"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.ZIndex = 12
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minBtn

local minStroke = Instance.new("UIStroke")
minStroke.Color = Color3.fromRGB(255, 255, 255)
minStroke.Thickness = 1
minStroke.Parent = minBtn

-- Кружок 🐺 (когда свёрнуто)
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 10, 0, 60)
toggle.BackgroundColor3 = Color3.fromRGB(0, 10, 30)
toggle.Text = "🐺"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 22
toggle.Visible = false
toggle.ZIndex = 20
toggle.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggle

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggle

-- ===== ПРАВАЯ ПОЛОСА (ВКЛАДКИ) =====
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(0, 70, 1, -30)
tabBar.Position = UDim2.new(1, -70, 0, 30)
tabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tabBar.BackgroundTransparency = 0.6
tabBar.BorderSizePixel = 0
tabBar.ZIndex = 11
tabBar.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 4)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Parent = tabBar

local tabPad = Instance.new("UIPadding")
tabPad.PaddingTop = UDim.new(0, 8)
tabPad.Parent = tabBar

-- ===== СТРАНИЦЫ (левая часть) =====
local pageContainer = Instance.new("Frame")
pageContainer.Size = UDim2.new(1, -80, 1, -40)
pageContainer.Position = UDim2.new(0, 8, 0, 36)
pageContainer.BackgroundTransparency = 1
pageContainer.ZIndex = 11
pageContainer.Parent = main

-- MAIN страница
local mainPage = Instance.new("Frame")
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.Visible = true
mainPage.ZIndex = 12
mainPage.Parent = pageContainer

-- ESP страница
local espPage = Instance.new("Frame")
espPage.Size = UDim2.new(1, 0, 1, 0)
espPage.BackgroundTransparency = 1
espPage.Visible = false
espPage.ZIndex = 12
espPage.Parent = pageContainer

-- НАСТРОЙКИ страница
local settingsPage = Instance.new("Frame")
settingsPage.Size = UDim2.new(1, 0, 1, 0)
settingsPage.BackgroundTransparency = 1
settingsPage.Visible = false
settingsPage.ZIndex = 12
settingsPage.Parent = pageContainer

-- ===== ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК =====
local pages = {
    main = mainPage,
    esp = espPage,
    settings = settingsPage
}

local tabButtons = {}
local activeTab = "main"

local function makeTabButton(text, tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.7
    btn.Text = text
    btn.TextColor3 = (tabName == activeTab) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextWrapped = true
    btn.ZIndex = 12
    btn.Parent = tabBar
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = (tabName == activeTab) and 1.5 or 0.5
    s.Transparency = (tabName == activeTab) and 0.2 or 0.7
    s.Parent = btn
    
    tabButtons[tabName] = {button = btn, stroke = s}
    
    btn.MouseButton1Click:Connect(function()
        activeTab = tabName
        for name, page in pairs(pages) do
            page.Visible = (name == tabName)
        end
        for name, data in pairs(tabButtons) do
            if name == tabName then
                data.button.TextColor3 = Color3.fromRGB(255, 255, 255)
                data.stroke.Thickness = 1.5
                data.stroke.Transparency = 0.2
            else
                data.button.TextColor3 = Color3.fromRGB(150, 150, 150)
                data.stroke.Thickness = 0.5
                data.stroke.Transparency = 0.7
            end
        end
    end)
    
    return btn
end

makeTabButton("🏠\nMAIN", "main")
makeTabButton("👁️\nESP", "esp")
makeTabButton("⚙️\nНАСТ", "settings")

-- ===== ЗАКРЫТИЕ И СВОРАЧИВАНИЕ =====
local running = true

closeBtn.MouseButton1Click:Connect(function()
    running = false
    screenGui:Destroy()
    print("WOLF SCRIPT v12 закрыт")
end)

minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    toggle.Visible = true
end)

toggle.MouseButton1Click:Connect(function()
    main.Visible = true
    toggle.Visible = false
end)

print("WOLF SCRIPT v12 - Часть 1 загружена (каркас)")

-- ============ ЧАСТЬ 2: UI-ЭЛЕМЕНТЫ ============

-- ===== ФУНКЦИЯ: Кнопка с переключателем =====
local function makeToggle(parent, text, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -6, 0, 34)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BackgroundTransparency = 0.4
    container.BorderSizePixel = 0
    container.ZIndex = 12
    container.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = container
    
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = container
    
    -- Фон переключателя
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 36, 0, 18)
    switchBg.Position = UDim2.new(1, -42, 0.5, -9)
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    switchBg.BorderSizePixel = 0
    switchBg.ZIndex = 13
    switchBg.Parent = container
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switchBg
    
    -- Кружок
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.BorderSizePixel = 0
    knob.ZIndex = 14
    knob.Parent = switchBg
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob
    
    -- Кнопка (невидимая, для нажатия)
    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 15
    clickBtn.Parent = container
    
    local state = false
    
    local function updateVisual()
        if state then
            switchBg.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            TweenService:Create(knob, TweenInfo.new(0.15), {
                Position = UDim2.new(1, -16, 0.5, -7)
            }):Play()
        else
            switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            TweenService:Create(knob, TweenInfo.new(0.15), {
                Position = UDim2.new(0, 2, 0.5, -7)
            }):Play()
        end
    end
    
    clickBtn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        if callback then
            local ok, err = pcall(callback, state)
            if not ok then print("Ошибка: " .. tostring(err)) end
        end
    end)
    
    -- Возвращаем функции для внешнего управления
    return {
        setState = function(val)
            state = val
            updateVisual()
        end,
        getState = function() return state end
    }
end

-- ===== ФУНКЦИЯ: Ползунок =====
local function makeSlider(parent, label, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -6, 0, 38)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BackgroundTransparency = 0.4
    container.BorderSizePixel = 0
    container.ZIndex = 12
    container.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = container
    
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = container
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 14)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label .. ": " .. defaultVal
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 13
    lbl.Parent = container
    
    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -16, 0, 10)
    bar.Position = UDim2.new(0, 8, 0, 22)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.ZIndex = 13
    bar.Parent = container
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar
    
    local fill = Instance.new("Frame")
    local initRatio = (defaultVal - minVal) / (maxVal - minVal)
    fill.Size = UDim2.new(initRatio, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 14
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local currentValue = defaultVal
    local dragging = false
    
    local function updateFromInput(input)
        local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        currentValue = math.floor(minVal + (maxVal - minVal) * relX)
        fill.Size = UDim2.new(relX, 0, 1, 0)
        lbl.Text = label .. ": " .. currentValue
        callback(currentValue)
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input)
        end
    end)
    
    bar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromInput(input)
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    return {
        setValue = function(val)
            currentValue = val
            local ratio = math.clamp((val - minVal) / (maxVal - minVal), 0, 1)
            fill.Size = UDim2.new(ratio, 0, 1, 0)
            lbl.Text = label .. ": " .. val
        end
    }
end

-- ===== ФУНКЦИЯ: Кнопка-действие =====
local function makeButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.ZIndex = 12
    btn.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("Нажата: " .. text)
        local ok, err = pcall(callback, btn)
        if not ok then print("Ошибка: " .. tostring(err)) end
    end)
    
    return btn
end

-- ===== ФУНКЦИЯ: Сетка для кнопок (2 в ряд) =====
local function makeGrid(parent)
    local grid = Instance.new("Frame")
    grid.Size = UDim2.new(1, 0, 1, 0)
    grid.BackgroundTransparency = 1
    grid.ZIndex = 12
    grid.Parent = parent
    
    local layout = Instance.new("UIGridLayout")
    layout.CellSize = UDim2.new(0.5, -4, 0, 34)
    layout.CellPadding = UDim2.new(0, 6, 0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = grid
    
    return grid
end

-- ===== СПИСКИ ДЛЯ КАЖДОЙ СТРАНИЦЫ =====
-- MAIN
local mainList = Instance.new("Frame")
mainList.Size = UDim2.new(1, 0, 1, 0)
mainList.BackgroundTransparency = 1
mainList.ZIndex = 12
mainList.Parent = mainPage

local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 6)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = mainList

-- ESP
local espList = Instance.new("Frame")
espList.Size = UDim2.new(1, 0, 1, 0)
espList.BackgroundTransparency = 1
espList.ZIndex = 12
espList.Parent = espPage

local espLayout = Instance.new("UIListLayout")
espLayout.Padding = UDim.new(0, 6)
espLayout.SortOrder = Enum.SortOrder.LayoutOrder
espLayout.Parent = espList

-- НАСТРОЙКИ
local settingsList = Instance.new("Frame")
settingsList.Size = UDim2.new(1, 0, 1, 0)
settingsList.BackgroundTransparency = 1
settingsList.ZIndex = 12
settingsList.Parent = settingsPage

local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 6)
settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
settingsLayout.Parent = settingsList

-- Хранилище переключателей и ползунков
local toggles = {}
local sliders = {}

print("WOLF SCRIPT v12 - Часть 2 загружена (UI-элементы)")

-- ============ ЧАСТЬ 3: ФУНКЦИИ ============

-- ===== СОСТОЯНИЕ =====
local state = {
    tpFruit = false,
    autoFight = false,
    attackRadius = 60,
    attackDelay = 0.4,
    hitboxSize = 2,
    espPlayers = false,
    espFruits = false,
    espDistance = false,
    espTracers = false,
    fruitNotify = false,
    antiAfk = false,
    walkWater = false
}

-- ===== ПОИСК ПЛОДОВ =====
local function isDevilFruit(obj)
    if not obj:IsA("Tool") then return false end
    local n = obj.Name:lower()
    if n:find("gacha") or n:find("dealer") or n:find("seller") or n:find("shop") then return false end
    if n == "fruit" or n:find("fruit") then return true end
    return false
end

local function getFruitPart(obj)
    if obj:IsA("Tool") and obj.Parent and obj.Parent:FindFirstChild("Handle") then
        return obj.Parent.Handle
    end
    return nil
end

local function findAllFruits()
    local fruits = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if isDevilFruit(obj) then
            local part = getFruitPart(obj)
            if part then table.insert(fruits, {obj = obj, part = part}) end
        end
    end
    return fruits
end

-- ===== ТП К ФРУКТУ (АВТО) =====
local tpLoop = nil
local function startTP()
    if tpLoop then return end
    tpLoop = task.spawn(function()
        while running and state.tpFruit do
            local fruits = findAllFruits()
            if #fruits > 0 then
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local closest, dist = nil, math.huge
                        for _, f in pairs(fruits) do
                            local d = (f.part.Position - hrp.Position).Magnitude
                            if d < dist then dist = d; closest = f end
                        end
                        if closest then
                            hrp.CFrame = closest.part.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end

local function stopTP()
    if tpLoop then
        pcall(function() task.cancel(tpLoop) end)
        tpLoop = nil
    end
end

-- ===== АВТО-БОЙ (КЛИК ПО ЦЕНТРУ) =====
local autoFightLoop = nil
local VirtualUser = game:GetService("VirtualUser")

local function startAutoFight()
    if autoFightLoop then return end
    autoFightLoop = task.spawn(function()
        while running and state.autoFight do
            local camera = workspace.CurrentCamera
            local centerX = camera.ViewportSize.X / 2
            local centerY = camera.ViewportSize.Y / 2
            
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    pcall(function() tool:Activate() end)
                end
                pcall(function()
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                    task.wait(0.05)
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                end)
            end
            task.wait(state.attackDelay)
        end
    end)
end

local function stopAutoFight()
    if autoFightLoop then
        pcall(function() task.cancel(autoFightLoop) end)
        autoFightLoop = nil
    end
end

-- ===== ESP ИГРОКОВ =====
local espData = {}

local function clearESP()
    for plr, data in pairs(espData) do
        for _, obj in pairs(data) do
            if obj and obj.Parent then obj:Destroy() end
        end
    end
    espData = {}
end

local function applyESP(plr)
    if plr == player then return end
    local char = plr.Character
    if not char then return end
    if espData[plr] then return end
    local head = char:FindFirstChild("Head")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not head or not humanoid then return end
    
    local h = Instance.new("Highlight")
    h.Name = "WolfESP"
    h.Adornee = char
    h.FillColor = Color3.fromRGB(255, 255, 255)
    h.OutlineColor = Color3.fromRGB(0, 0, 0)
    h.FillTransparency = 0.6
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = char
    
    local bb = Instance.new("BillboardGui")
    bb.Name = "WolfNameTag"
    bb.Size = UDim2.new(0, 160, 0, 40)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.Adornee = head
    bb.Parent = head
    
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, 0, 0, 16)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = plr.Name
    nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLbl.TextStrokeTransparency = 0
    nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 14
    nameLbl.Parent = bb
    
    local hpBg = Instance.new("Frame")
    hpBg.Size = UDim2.new(0.7, 0, 0, 8)
    hpBg.Position = UDim2.new(0.15, 0, 0, 18)
    hpBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    hpBg.BorderSizePixel = 0
    hpBg.Parent = bb
    
    local hpBgCorner = Instance.new("UICorner")
    hpBgCorner.CornerRadius = UDim.new(0, 4)
    hpBgCorner.Parent = hpBg
    
    local hpFill = Instance.new("Frame")
    hpFill.Size = UDim2.new(1, 0, 1, 0)
    hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    hpFill.BorderSizePixel = 0
    hpFill.Parent = hpBg
    
    local hpFillCorner = Instance.new("UICorner")
    hpFillCorner.CornerRadius = UDim.new(0, 4)
    hpFillCorner.Parent = hpFill
    
    espData[plr] = {
        highlight = h, billboard = bb, name = nameLbl,
        hpBg = hpBg, hpFill = hpFill, humanoid = humanoid, player = plr
    }
end

-- ===== ТРЕЙСЕРЫ =====
local tracers = {}

local function clearTracers()
    for _, t in pairs(tracers) do
        if t and t.Parent then t:Destroy() end
    end
    tracers = {}
end

local function applyTracers()
    clearTracers()
    if not state.espTracers then return end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                local line = Instance.new("LineHandleAdornment")
                line.Name = "WolfTracer"
                line.Adornee = head
                line.Length = 0
                line.Thickness = 2
                line.Color3 = Color3.fromRGB(255, 255, 255)
                line.Transparency = 0.3
                line.AlwaysOnTop = true
                line.ZIndex = 999
                line.Parent = head
                tracers[plr] = line
            end
        end
    end
end

-- ===== ESP ПЛОДОВ =====
local fruitHighlights = {}

local function clearFruitESP()
    for _, h in pairs(fruitHighlights) do
        if h and h.Parent then h:Destroy() end
    end
    fruitHighlights = {}
end

local function applyFruitESP()
    clearFruitESP()
    if not state.espFruits then return end
    local fruits = findAllFruits()
    for _, f in pairs(fruits) do
        local h = Instance.new("Highlight")
        h.Name = "WolfFruitESP"
        h.Adornee = f.obj
        h.FillColor = Color3.fromRGB(255, 100, 255)
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.4
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = f.obj
        table.insert(fruitHighlights, h)
    end
end

-- ===== ХИТБОКС =====
local function applyHitbox(size)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local char = plr.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(size, size, size)
                    hrp.Transparency = size > 3 and 0.7 or 1
                    hrp.CanCollide = false
                end
            end
        end
    end
end

-- ===== ANTI-AFK =====
local antiAfkConn = nil
local function startAntiAfk()
    if antiAfkConn then return end
    antiAfkConn = player.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

local function stopAntiAfk()
    if antiAfkConn then
        antiAfkConn:Disconnect()
        antiAfkConn = nil
    end
end

-- ===== ХОЖДЕНИЕ ПО ВОДЕ =====
local function applyWalkWater(enabled)
    local char = player.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CustomPhysicalProperties = enabled 
                and PhysicalProperties.new(0.01, 0.3, 0.5, 1, 1)
                or nil
        end
    end
end

-- ===== НАПОЛНЕНИЕ MAIN =====
local tpToggle = makeToggle(mainList, "🍎 ТП к фрукту", function(val)
    state.tpFruit = val
    if val then startTP() else stopTP() end
end)

local autoFightToggle = makeToggle(mainList, "⚔️ Авто-бой", function(val)
    state.autoFight = val
    if val then startAutoFight() else stopAutoFight() end
end)

makeSlider(mainList, "📏 Радиус боя", 10, 200, 60, function(val)
    state.attackRadius = val
end)

makeSlider(mainList, "⏱️ Задержка боя", 1, 20, 4, function(val)
    state.attackDelay = val / 10
end)

-- ===== НАПОЛНЕНИЕ ESP =====
local espPlayersToggle = makeToggle(espList, "👤 ESP игроков", function(val)
    state.espPlayers = val
    if val then
        for _, plr in pairs(Players:GetPlayers()) do applyESP(plr) end
    else
        clearESP()
    end
end)

local espFruitsToggle = makeToggle(espList, "🍇 ESP плодов", function(val)
    state.espFruits = val
    if val then applyFruitESP() else clearFruitESP() end
end)

local espDistanceToggle = makeToggle(espList, "📍 Дистанция", function(val)
    state.espDistance = val
end)

local espTracersToggle = makeToggle(espList, "📡 Трейсеры", function(val)
    state.espTracers = val
    if val then applyTracers() else clearTracers() end
end)

local fruitNotifyToggle = makeToggle(espList, "📢 Уведомления", function(val)
    state.fruitNotify = val
end)

-- ===== НАПОЛНЕНИЕ НАСТРОЙКИ =====
makeSlider(settingsList, "💥 Хитбокс", 1, 20, 2, function(val)
    state.hitboxSize = val
    applyHitbox(val)
end)

local antiAfkToggle = makeToggle(settingsList, "🚶 Anti-AFK", function(val)
    state.antiAfk = val
    if val then startAntiAfk() else stopAntiAfk() end
end)

local walkWaterToggle = makeToggle(settingsList, "🌊 Хождение по воде", function(val)
    state.walkWater = val
    applyWalkWater(val)
end)

-- ===== ОБНОВЛЕНИЕ HP И ДИСТАНЦИИ =====
local renderConn = RunService.RenderStepped:Connect(function()
    for plr, data in pairs(espData) do
        if data.humanoid and data.humanoid.Parent then
            local ratio = math.clamp(data.humanoid.Health / math.max(data.humanoid.MaxHealth, 1), 0, 1)
            data.hpFill.Size = UDim2.new(ratio, 0, 1, 0)
            if ratio > 0.6 then
                data.hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            elseif ratio > 0.3 then
                data.hpFill.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            else
                data.hpFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
            
            -- Дистанция
            if state.espDistance and data.billboard then
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and plr.Character then
                    local hrp = char.HumanoidRootPart
                    local targetHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if targetHrp then
                        local dist = math.floor((hrp.Position - targetHrp.Position).Magnitude)
                        data.name.Text = plr.Name .. " [" .. dist .. "m]"
                    end
                end
            else
                data.name.Text = plr.Name
            end
        end
    end
end)

-- ===== АВТО-ОБНОВЛЕНИЕ ESP ПЛОДОВ =====
task.spawn(function()
    while running do
        task.wait(4)
        if state.espFruits then applyFruitESP() end
    end
end)

-- ===== ОЧИСТКА ПРИ ВЫХОДЕ =====
local function cleanup()
    stopTP()
    stopAutoFight()
    clearESP()
    clearTracers()
    clearFruitESP()
    stopAntiAfk()
end

-- Переподключаем закрытие
closeBtn.MouseButton1Click:Connect(function()
    cleanup()
end)

-- Обработка новых игроков
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if state.espPlayers then
            task.wait(0.5)
            applyESP(plr)
        end
    end)
end)

print("WOLF SCRIPT v12 - Часть 3 загружена (функции)")
