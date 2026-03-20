-- // ═══════════════════════════════════════════════════════════
-- //  RIVALS HUB  |  Rayfield UI  |  v3.1
-- //  by traplixy gaming
-- // ═══════════════════════════════════════════════════════════

-- // ── CHANGE YOUR KEYS HERE ──────────────────────────────────
local VALID_KEYS = {
    ["free"]  = "Free",
    ["vip"]   = "VIP",
    ["dev"]   = "Dev",
}
local SCRIPT_NAME = "RIVALS HUB"
local SCRIPT_VER  = "v3.1"
-- // ───────────────────────────────────────────────────────────

local TweenService     = game:GetService("TweenService")
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser      = game:GetService("VirtualUser")
local LocalPlayer      = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

-- ════════════════════════════════════════════════════════════
--  KEY SYSTEM
-- ════════════════════════════════════════════════════════════

local function isValidKey(k) return VALID_KEYS[k:lower()] ~= nil end

local function tw(obj, t, props)
    TweenService:Create(
        obj,
        TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

local _keyDone = false

local function runKeySystem()

    local gui = Instance.new("ScreenGui")
    gui.Name            = "RivalsKeyGUI"
    gui.ResetOnSpawn    = false
    gui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset  = true
    gui.DisplayOrder    = 999
    gui.Parent          = (gethui and gethui()) or game:GetService("CoreGui")

    local overlay = Instance.new("Frame")
    overlay.Size                   = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3       = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel        = 0
    overlay.Parent                 = gui
    tw(overlay, 0.6, {BackgroundTransparency = 0.5})

    local card = Instance.new("Frame")
    card.AnchorPoint       = Vector2.new(0.5, 0.5)
    card.Position          = UDim2.fromScale(0.5, 0.5)
    card.Size              = UDim2.fromOffset(0, 0)
    card.BackgroundColor3  = Color3.fromRGB(12, 12, 18)
    card.BorderSizePixel   = 0
    card.ClipsDescendants  = true
    card.Parent            = gui
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

    local border = Instance.new("UIStroke")
    border.Color     = Color3.fromRGB(0, 200, 255)
    border.Thickness = 2
    border.Parent    = card

    task.wait()
    tw(card, 0.4, {Size = UDim2.fromOffset(450, 310)})

    task.spawn(function()
        while gui.Parent do
            tw(border, 1.2, {Color = Color3.fromRGB(0, 240, 255), Thickness = 2.5})
            task.wait(1.2)
            if not gui.Parent then break end
            tw(border, 1.2, {Color = Color3.fromRGB(0, 140, 220), Thickness = 1.5})
            task.wait(1.2)
        end
    end)

    local topBar = Instance.new("Frame")
    topBar.Size             = UDim2.new(1, 0, 0, 4)
    topBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    topBar.BorderSizePixel  = 0
    topBar.Parent           = card

    local topGrad = Instance.new("UIGradient")
    topGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(0, 120, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 240, 255)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(0, 120, 255)),
    }
    topGrad.Parent = topBar

    task.spawn(function()
        local t = 0
        while topBar.Parent do
            t = (t + 0.008) % 1
            if topGrad.Parent then topGrad.Rotation = t * 360 end
            task.wait()
        end
    end)

    local title = Instance.new("TextLabel")
    title.Size                   = UDim2.new(1, 0, 0, 54)
    title.Position               = UDim2.fromOffset(0, 14)
    title.BackgroundTransparency = 1
    title.Text                   = "⚡  " .. SCRIPT_NAME
    title.TextColor3             = Color3.fromRGB(255, 255, 255)
    title.Font                   = Enum.Font.GothamBold
    title.TextSize               = 26
    title.TextStrokeTransparency = 0.6
    title.TextStrokeColor3       = Color3.fromRGB(0, 200, 255)
    title.Parent                 = card

    local sub = Instance.new("TextLabel")
    sub.Size                   = UDim2.new(1, -20, 0, 18)
    sub.Position               = UDim2.fromOffset(10, 68)
    sub.BackgroundTransparency = 1
    sub.Text                   = SCRIPT_VER .. "  ·  Enter your access key to continue"
    sub.TextColor3             = Color3.fromRGB(100, 120, 155)
    sub.Font                   = Enum.Font.Gotham
    sub.TextSize               = 13
    sub.Parent                 = card

    local inputWrap = Instance.new("Frame")
    inputWrap.Size             = UDim2.new(0.88, 0, 0, 46)
    inputWrap.AnchorPoint      = Vector2.new(0.5, 0)
    inputWrap.Position         = UDim2.new(0.5, 0, 0, 106)
    inputWrap.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    inputWrap.BorderSizePixel  = 0
    inputWrap.Parent           = card
    Instance.new("UICorner", inputWrap).CornerRadius = UDim.new(0, 8)

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color     = Color3.fromRGB(45, 50, 70)
    inputStroke.Thickness = 1.2
    inputStroke.Parent    = inputWrap

    local keyIcon = Instance.new("TextLabel")
    keyIcon.Size                   = UDim2.new(0, 38, 1, 0)
    keyIcon.BackgroundTransparency = 1
    keyIcon.Text                   = "🔑"
    keyIcon.TextSize               = 16
    keyIcon.Font                   = Enum.Font.Gotham
    keyIcon.Parent                 = inputWrap

    local inputBox = Instance.new("TextBox")
    inputBox.Size                = UDim2.new(1, -46, 1, 0)
    inputBox.Position            = UDim2.fromOffset(42, 0)
    inputBox.BackgroundTransparency = 1
    inputBox.PlaceholderText     = "Paste key here..."
    inputBox.PlaceholderColor3   = Color3.fromRGB(65, 70, 95)
    inputBox.Text                = ""
    inputBox.TextColor3          = Color3.fromRGB(210, 225, 255)
    inputBox.Font                = Enum.Font.Code
    inputBox.TextSize            = 14
    inputBox.TextXAlignment      = Enum.TextXAlignment.Left
    inputBox.ClearTextOnFocus    = false
    inputBox.Parent              = inputWrap

    inputBox.Focused:Connect(function()
        tw(inputStroke, 0.2, {Color = Color3.fromRGB(0, 200, 255), Thickness = 2})
    end)
    inputBox.FocusLost:Connect(function()
        tw(inputStroke, 0.3, {Color = Color3.fromRGB(45, 50, 70), Thickness = 1.2})
    end)

    local statusLbl = Instance.new("TextLabel")
    statusLbl.Size                   = UDim2.new(0.88, 0, 0, 22)
    statusLbl.AnchorPoint            = Vector2.new(0.5, 0)
    statusLbl.Position               = UDim2.new(0.5, 0, 0, 162)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Text                   = ""
    statusLbl.Font                   = Enum.Font.Gotham
    statusLbl.TextSize               = 13
    statusLbl.TextColor3             = Color3.fromRGB(255, 80, 80)
    statusLbl.Parent                 = card

    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(0.88, 0, 0, 44)
    btn.AnchorPoint      = Vector2.new(0.5, 0)
    btn.Position         = UDim2.new(0.5, 0, 0, 194)
    btn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    btn.BorderSizePixel  = 0
    btn.Text             = "UNLOCK  →"
    btn.TextColor3       = Color3.fromRGB(255, 255, 255)
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 15
    btn.AutoButtonColor  = false
    btn.Parent           = card
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseEnter:Connect(function()
        if btn.Text ~= "⛔  LOCKED" then
            tw(btn, 0.15, {BackgroundColor3 = Color3.fromRGB(0, 220, 255)})
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.Text ~= "⛔  LOCKED" then
            tw(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(0, 180, 255)})
        end
    end)

    local barBG = Instance.new("Frame")
    barBG.Size             = UDim2.new(0.88, 0, 0, 4)
    barBG.AnchorPoint      = Vector2.new(0.5, 0)
    barBG.Position         = UDim2.new(0.5, 0, 0, 254)
    barBG.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    barBG.BorderSizePixel  = 0
    barBG.Parent           = card
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame")
    barFill.Size             = UDim2.fromScale(1, 1)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    barFill.BorderSizePixel  = 0
    barFill.Parent           = barBG
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

    local attLbl = Instance.new("TextLabel")
    attLbl.Size                   = UDim2.new(0.88, 0, 0, 16)
    attLbl.AnchorPoint            = Vector2.new(0.5, 0)
    attLbl.Position               = UDim2.new(0.5, 0, 0, 262)
    attLbl.BackgroundTransparency = 1
    attLbl.Text                   = "5 attempts remaining"
    attLbl.TextColor3             = Color3.fromRGB(80, 90, 120)
    attLbl.Font                   = Enum.Font.Gotham
    attLbl.TextSize               = 11
    attLbl.Parent                 = card

    local attempts    = 0
    local maxAttempts = 5
    local locked      = false

    local function shakeCard()
        local orig = card.Position
        for i = 1, 6 do
            tw(card, 0.04, {Position = orig + UDim2.fromOffset((i%2==0) and 9 or -9, 0)})
            task.wait(0.045)
        end
        tw(card, 0.1, {Position = orig})
    end

    local function tryKey()
        if locked then return end
        local entered = inputBox.Text:gsub("%s+", ""):lower()

        if entered == "" then
            statusLbl.TextColor3 = Color3.fromRGB(255, 180, 50)
            statusLbl.Text = "⚠  Please enter a key first."
            return
        end

        btn.Text = "⏳  Checking..."
        tw(btn, 0.15, {BackgroundColor3 = Color3.fromRGB(40, 45, 65)})
        task.wait(0.4)

        if isValidKey(entered) then
            local tier = VALID_KEYS[entered]
            tw(inputStroke, 0.2, {Color = Color3.fromRGB(50, 220, 100)})
            tw(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(28, 185, 75)})
            tw(barFill, 0.3, {BackgroundColor3 = Color3.fromRGB(28, 185, 75)})
            btn.Text             = "✔  Unlocked  [" .. tier .. "]"
            statusLbl.TextColor3 = Color3.fromRGB(80, 255, 130)
            statusLbl.Text       = "✔  Access granted — loading Rivals Hub..."
            attLbl.Text          = "Welcome!"
            task.wait(1.3)
            tw(card, 0.4, {Size = UDim2.fromOffset(450, 0)})
            tw(overlay, 0.4, {BackgroundTransparency = 1})
            task.wait(0.5)
            gui:Destroy()
            _keyDone = true
        else
            attempts += 1
            local left = maxAttempts - attempts
            task.spawn(shakeCard)
            tw(inputStroke, 0.1, {Color = Color3.fromRGB(255, 55, 55)})
            task.wait(0.15)
            tw(inputStroke, 0.45, {Color = Color3.fromRGB(45, 50, 70)})
            statusLbl.TextColor3 = Color3.fromRGB(255, 75, 75)
            if left <= 0 then
                locked = true
                btn.Text = "⛔  LOCKED"
                tw(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(130, 25, 25)})
                tw(barFill, 0.4, {
                    Size             = UDim2.fromScale(0, 1),
                    BackgroundColor3 = Color3.fromRGB(200, 35, 35),
                })
                statusLbl.Text = "⛔  Too many attempts. Re-execute the script."
                attLbl.Text    = "No attempts remaining"
            else
                btn.Text = "TRY AGAIN"
                tw(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(0, 180, 255)})
                tw(barFill, 0.35, {Size = UDim2.fromScale(left / maxAttempts, 1)})
                statusLbl.Text = "✘  Wrong key — " .. left .. " attempt" .. (left == 1 and "" or "s") .. " left"
                attLbl.Text    = left .. " attempt" .. (left == 1 and "" or "s") .. " remaining"
            end
        end
    end

    btn.MouseButton1Click:Connect(function() task.spawn(tryKey) end)
    inputBox.FocusLost:Connect(function(enter)
        if enter then task.spawn(tryKey) end
    end)

    repeat task.wait(0.05) until _keyDone
end

task.spawn(runKeySystem)
repeat task.wait(0.05) until _keyDone

-- ════════════════════════════════════════════════════════════
--  MAIN VARIABLES
-- ════════════════════════════════════════════════════════════

local aimbotToggle   = false
local silentAim      = false
local autoClick      = false
local aimAtPart      = "Head"
local wallCheck      = false
local teamCheck      = false
local aimbotFOV      = 120
local aimbotSmooth   = 0.25
local infJump        = false
local walkSpeed      = 16
local speedBoost     = false
local speedBoostVal  = 50
local flyEnabled     = false
local flySpeed       = 50
local noclipEnabled  = false
local fullbright     = false
local antiAFK        = false
local rainbowEnabled = false
local rainbowHue     = 0
local infAmmo        = false
local godMode        = false
local killAura       = false
local killAuraRange  = 15
local autoFarm       = false
local autoFarmConn   = nil
local flyBodyVel     = nil
local flyBodyGyro    = nil

-- ── ESP library ──────────────────────────────────────────────
local ESP = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"
))()
ESP.Enabled        = false
ESP.ShowBox        = false
ESP.ShowName       = false
ESP.ShowHealth     = false
ESP.ShowTracer     = false
ESP.ShowDistance   = false
ESP.ShowSkeletons  = false
ESP.TeamCheck      = false
ESP.BoxType        = "2D"
ESP.TracerPosition = "Bottom"

-- ── ESP box offset correction ────────────────────────────────
local ESP_OFFSET_Y = -20
local ESP_SCALE_X  = 0.80
local ESP_SCALE_Y  = 0.85

local _origUpdate = ESP.Update
if _origUpdate then
    ESP.Update = function(self, ...)
        _origUpdate(self, ...)
        for _, obj in pairs(ESP.Objects or {}) do
            if obj.Box then
                local b = obj.Box
                if b.Size then
                    b.Size = Vector2.new(b.Size.X * ESP_SCALE_X, b.Size.Y * ESP_SCALE_Y)
                end
                if b.Position then
                    b.Position = Vector2.new(
                        b.Position.X + (b.Size and b.Size.X * (1 - ESP_SCALE_X) / 2 or 0),
                        b.Position.Y + ESP_OFFSET_Y
                    )
                end
            end
        end
    end
end

-- ── FOV circle ───────────────────────────────────────────────
local fovCircle = Drawing.new("Circle")
fovCircle.Visible   = false
fovCircle.Filled    = false
fovCircle.Color     = Color3.fromRGB(0, 200, 255)
fovCircle.Thickness = 1.5
fovCircle.NumSides  = 64
fovCircle.Radius    = aimbotFOV

-- ── Target finder ────────────────────────────────────────────
local function getTarget()
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    local mouse    = UserInputService:GetMouseLocation()
    local best     = nil
    local bestDist = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local hum  = char:FindFirstChild("Humanoid")
        local part = char:FindFirstChild(aimAtPart) or char:FindFirstChild("HumanoidRootPart")
        if not hum or not part or hum.Health <= 0 then continue end
        if teamCheck and player.Team == LocalPlayer.Team then continue end

        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mouse).Magnitude
        if dist > aimbotFOV then continue end

        if wallCheck then
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {localChar}
            params.FilterType = Enum.RaycastFilterType.Blacklist
            local result = workspace:Raycast(
                Camera.CFrame.Position,
                part.Position - Camera.CFrame.Position,
                params
            )
            if result and not result.Instance:IsDescendantOf(char) then continue end
        end

        if dist < bestDist then
            bestDist = dist
            best     = part
        end
    end
    return best
end

-- ── Aimbot + Auto Click render loop ──────────────────────────
local wasAiming = false

RunService.RenderStepped:Connect(function()
    fovCircle.Position = UserInputService:GetMouseLocation()
    fovCircle.Radius   = aimbotFOV
    fovCircle.Visible  = aimbotToggle

    local rmbHeld = silentAim or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)

    if wasAiming and (not aimbotToggle or not rmbHeld) then
        Camera.CameraType = Enum.CameraType.Custom
        wasAiming = false
    end

    if not aimbotToggle or not rmbHeld then return end

    local part = getTarget()
    if not part then return end

    Camera.CameraType = Enum.CameraType.Scriptable
    wasAiming = true

    local targetCF = CFrame.new(Camera.CFrame.Position, part.Position)
    Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 - aimbotSmooth)

    local screenPos = Camera:WorldToViewportPoint(part.Position)
    local mousePos  = UserInputService:GetMouseLocation()
    local delta     = Vector2.new(screenPos.X, screenPos.Y) - mousePos

    if delta.Magnitude > 50 then delta = delta.Unit * 50 end

    if mousemoverel then
        mousemoverel(delta.X * (1 - aimbotSmooth), delta.Y * (1 - aimbotSmooth))
    end

    -- Auto click while aiming at a target
    if autoClick then
        mouse1click()
    end
end)

-- ── Infinite jump ────────────────────────────────────────────
UserInputService.JumpRequest:Connect(function()
    if not infJump then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- ── Walk speed ───────────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if speedBoost then
        hum.WalkSpeed = speedBoostVal
    else
        hum.WalkSpeed = walkSpeed
    end
end)

-- ── Speed boost hotkey (Left Shift) ──────────────────────────
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftShift and speedBoost then
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speedBoostVal end
    end
end)

-- ── Fly ──────────────────────────────────────────────────────
local function enableFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    hum.PlatformStand = true

    flyBodyVel = Instance.new("BodyVelocity")
    flyBodyVel.Velocity       = Vector3.zero
    flyBodyVel.MaxForce       = Vector3.new(1e5, 1e5, 1e5)
    flyBodyVel.Parent         = hrp

    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque     = Vector3.new(1e5, 1e5, 1e5)
    flyBodyGyro.D             = 100
    flyBodyGyro.CFrame        = hrp.CFrame
    flyBodyGyro.Parent        = hrp
end

local function disableFly()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    if flyBodyVel  then flyBodyVel:Destroy();  flyBodyVel  = nil end
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
end

RunService.RenderStepped:Connect(function()
    if not flyEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not flyBodyVel or not flyBodyGyro then return end

    local cf    = Camera.CFrame
    local vel   = Vector3.zero
    local keys  = UserInputService

    if keys:IsKeyDown(Enum.KeyCode.W) then vel = vel + cf.LookVector end
    if keys:IsKeyDown(Enum.KeyCode.S) then vel = vel - cf.LookVector end
    if keys:IsKeyDown(Enum.KeyCode.A) then vel = vel - cf.RightVector end
    if keys:IsKeyDown(Enum.KeyCode.D) then vel = vel + cf.RightVector end
    if keys:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
    if keys:IsKeyDown(Enum.KeyCode.LeftControl) then vel = vel - Vector3.new(0,1,0) end

    flyBodyVel.Velocity  = vel * flySpeed
    flyBodyGyro.CFrame   = cf
end)

-- ── Noclip ───────────────────────────────────────────────────
RunService.Stepped:Connect(function()
    if not noclipEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)

-- ── Fullbright ───────────────────────────────────────────────
RunService.RenderStepped:Connect(function()
    if not fullbright then return end
    local L = game:GetService("Lighting")
    L.Brightness     = 2
    L.ClockTime      = 14
    L.FogEnd         = 100000
    L.GlobalShadows  = false
    L.Ambient        = Color3.fromRGB(255, 255, 255)
    L.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
end)

-- ── Anti-AFK ─────────────────────────────────────────────────
LocalPlayer.Idled:Connect(function()
    if not antiAFK then return end
    VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Camera.CFrame)
end)

-- ── Rainbow gun ──────────────────────────────────────────────
RunService.RenderStepped:Connect(function()
    if not rainbowEnabled then return end
    rainbowHue = (rainbowHue + 0.004) % 1
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    for _, p in ipairs(tool:GetDescendants()) do
        if p:IsA("BasePart") or p:IsA("MeshPart") then
            pcall(function() p.Color = Color3.fromHSV(rainbowHue, 1, 1) end)
        end
    end
end)

-- ── Infinite ammo ────────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    if not infAmmo then return end
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    for _, v in ipairs(tool:GetDescendants()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            local n = v.Name:lower()
            if n == "ammo" or n == "currentammo" or n == "clip"
            or n == "magazine" or n == "bullets" or n == "loadedammo"
            or n == "reserveammo" or n == "totalammo" then
                pcall(function() v.Value = 999 end)
            end
        end
    end
end)

-- ── God mode ─────────────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    if not godMode then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health    = hum.MaxHealth
        hum.MaxHealth = math.huge
        pcall(function()
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("NumberValue") or v:IsA("IntValue") then
                    local n = v.Name:lower()
                    if n == "health" or n == "shield" or n == "hp" then
                        v.Value = 999999
                    end
                end
            end
        end)
    end
end)

-- ── Kill aura ────────────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    if not killAura then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local eChar = player.Character
        if not eChar then continue end
        local eHum = eChar:FindFirstChildOfClass("Humanoid")
        local eHRP = eChar:FindFirstChild("HumanoidRootPart")
        if not eHum or not eHRP or eHum.Health <= 0 then continue end
        if teamCheck and player.Team == LocalPlayer.Team then continue end

        local dist = (hrp.Position - eHRP.Position).Magnitude
        if dist <= killAuraRange then
            pcall(function()
                eHum:TakeDamage(math.huge)
                -- also try value-based damage for games that use custom health
                for _, v in ipairs(eChar:GetDescendants()) do
                    if (v:IsA("NumberValue") or v:IsA("IntValue")) then
                        local n = v.Name:lower()
                        if n == "health" or n == "hp" then
                            v.Value = 0
                        end
                    end
                end
            end)
        end
    end
end)

-- ── Auto farm ────────────────────────────────────────────────
local function startAutoFarm()
    autoFarmConn = RunService.Heartbeat:Connect(function()
        if not autoFarm then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if not autoFarm then break end
            pcall(function()
                local n = obj.Name:lower()
                if (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Part"))
                and (n:find("coin") or n:find("cash") or n:find("gem")
                or n:find("item") or n:find("pickup") or n:find("orb")
                or n:find("xp") or n:find("drop") or n:find("reward")
                or n:find("collect") or n:find("loot")) then
                    local dist = (hrp.Position - obj.Position).Magnitude
                    if dist < 200 then
                        hrp.CFrame = CFrame.new(obj.Position)
                        task.wait(0.05)
                    end
                end
            end)
        end
    end)
end

local function stopAutoFarm()
    if autoFarmConn then
        autoFarmConn:Disconnect()
        autoFarmConn = nil
    end
end

-- ════════════════════════════════════════════════════════════
--  RAYFIELD UI
-- ════════════════════════════════════════════════════════════

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name             = "Rivals Hub  " .. SCRIPT_VER,
    LoadingTitle     = "Rivals Hub",
    LoadingSubtitle  = "by traplixy gaming",
    Theme            = "Serenity",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = false,
    ConfigurationSaving    = { Enabled = true, FileName = "RivalsHub" },
    Discord                = { Enabled = false },
    KeySystem              = false,
})

-- ════════════════════════════════════════════════════════════
--  🎯 AIMBOT TAB
-- ════════════════════════════════════════════════════════════

local AimbotTab = Window:CreateTab("🎯  Aimbot", nil)
AimbotTab:CreateSection("— Core Settings —")

AimbotTab:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = false, Flag = "AimbotOn",
    Callback = function(v)
        aimbotToggle = v
        Rayfield:Notify({
            Title   = v and "✅  Aimbot Enabled" or "❌  Aimbot Disabled",
            Content = v and "Hold RMB to lock onto targets." or "Aimbot has been turned off.",
            Duration = 2,
        })
    end,
})

AimbotTab:CreateToggle({
    Name = "Silent Aim  (no RMB required)",
    CurrentValue = false, Flag = "SilentAim",
    Callback = function(v)
        silentAim = v
        Rayfield:Notify({
            Title   = v and "✅  Silent Aim Enabled" or "❌  Silent Aim Disabled",
            Content = v and "Auto-aiming without holding RMB." or "Silent aim turned off.",
            Duration = 2,
        })
    end,
})

AimbotTab:CreateToggle({
    Name = "Auto Click  (shoots while locked on)",
    CurrentValue = false, Flag = "AutoClick",
    Callback = function(v)
        autoClick = v
        Rayfield:Notify({
            Title   = v and "✅  Auto Click ON" or "❌  Auto Click OFF",
            Content = v and "Automatically shoots while aimed at target." or "Auto click disabled.",
            Duration = 2,
        })
    end,
})

AimbotTab:CreateLabel("ℹ️  RMB = hold to aim  |  Silent = always on  |  Auto Click = auto shoot")
AimbotTab:CreateDivider()
AimbotTab:CreateSection("— Configuration —")

AimbotTab:CreateSlider({
    Name = "FOV Radius",
    Range = {20, 500}, Increment = 10,
    Suffix = " px", CurrentValue = 120, Flag = "AimFOV",
    Callback = function(v) aimbotFOV = v end,
})

AimbotTab:CreateSlider({
    Name = "Smoothness",
    Range = {0, 95}, Increment = 5,
    Suffix = "%", CurrentValue = 25, Flag = "AimSmooth",
    Callback = function(v) aimbotSmooth = v / 100 end,
})

AimbotTab:CreateDropdown({
    Name = "Target Hitbox",
    Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    CurrentOption = {"Head"}, Flag = "AimPart",
    Callback = function(v)
        aimAtPart = v[1]
        Rayfield:Notify({ Title = "🎯  Target Changed", Content = "Now targeting: " .. v[1], Duration = 2 })
    end,
})

AimbotTab:CreateDivider()
AimbotTab:CreateSection("— Filters —")

AimbotTab:CreateToggle({
    Name = "Wall Check  (visible targets only)",
    CurrentValue = false, Flag = "WallCheck",
    Callback = function(v) wallCheck = v end,
})
AimbotTab:CreateToggle({
    Name = "Team Check  (ignore teammates)",
    CurrentValue = false, Flag = "TeamCheck",
    Callback = function(v) teamCheck = v end,
})

-- ════════════════════════════════════════════════════════════
--  ⚔️ COMBAT TAB
-- ════════════════════════════════════════════════════════════

local CombatTab = Window:CreateTab("⚔️  Combat", nil)
CombatTab:CreateSection("— Kill Aura —")

CombatTab:CreateToggle({
    Name = "🔴  Kill Aura  (damages nearby enemies)",
    CurrentValue = false, Flag = "KillAura",
    Callback = function(v)
        killAura = v
        Rayfield:Notify({
            Title   = v and "✅  Kill Aura ON" or "❌  Kill Aura OFF",
            Content = v and "Damaging all enemies within range." or "Kill aura disabled.",
            Duration = 2,
        })
    end,
})

CombatTab:CreateSlider({
    Name = "Kill Aura Range",
    Range = {5, 100}, Increment = 5,
    Suffix = " studs", CurrentValue = 15, Flag = "KillAuraRange",
    Callback = function(v) killAuraRange = v end,
})

CombatTab:CreateLabel("ℹ️  Kill Aura respects Team Check from Aimbot tab")
CombatTab:CreateDivider()
CombatTab:CreateSection("— Defense —")

CombatTab:CreateToggle({
    Name = "🛡️  God Mode  (max health lock)",
    CurrentValue = false, Flag = "GodMode",
    Callback = function(v)
        godMode = v
        Rayfield:Notify({
            Title   = v and "✅  God Mode ON" or "❌  God Mode OFF",
            Content = v and "Health locked to max — you cannot die." or "God mode disabled.",
            Duration = 2,
        })
    end,
})

CombatTab:CreateDivider()
CombatTab:CreateSection("— Weapons —")

CombatTab:CreateToggle({
    Name = "🔫  Infinite Ammo  (no reload)",
    CurrentValue = false, Flag = "InfAmmo",
    Callback = function(v)
        infAmmo = v
        Rayfield:Notify({
            Title   = v and "✅  Infinite Ammo ON" or "❌  Infinite Ammo OFF",
            Content = v and "Ammo locked to 999 — no reload needed." or "Infinite ammo disabled.",
            Duration = 2,
        })
    end,
})

-- ════════════════════════════════════════════════════════════
--  👁️ ESP TAB
-- ════════════════════════════════════════════════════════════

local ESPTab = Window:CreateTab("👁️  ESP", nil)
ESPTab:CreateSection("— Visibility —")

ESPTab:CreateToggle({ Name="Enable ESP",   CurrentValue=false, Flag="ESPOn",     Callback=function(v) ESP.Enabled      =v end })
ESPTab:CreateToggle({ Name="Boxes",        CurrentValue=false, Flag="ESPBox",    Callback=function(v) ESP.ShowBox      =v end })
ESPTab:CreateToggle({ Name="Names",        CurrentValue=false, Flag="ESPName",   Callback=function(v) ESP.ShowName     =v end })
ESPTab:CreateToggle({ Name="Health Bars",  CurrentValue=false, Flag="ESPHealth", Callback=function(v) ESP.ShowHealth   =v end })
ESPTab:CreateToggle({ Name="Tracers",      CurrentValue=false, Flag="ESPTracer", Callback=function(v) ESP.ShowTracer   =v end })
ESPTab:CreateToggle({ Name="Distance",     CurrentValue=false, Flag="ESPDist",   Callback=function(v) ESP.ShowDistance =v end })
ESPTab:CreateToggle({ Name="Skeleton",     CurrentValue=false, Flag="ESPSkel",   Callback=function(v) ESP.ShowSkeletons=v end })
ESPTab:CreateToggle({ Name="Team Check",   CurrentValue=false, Flag="ESPTeam",   Callback=function(v) ESP.TeamCheck    =v end })

ESPTab:CreateDivider()
ESPTab:CreateSection("— Style —")

ESPTab:CreateDropdown({
    Name="Box Style", Options={"2D","Corner Box Esp"},
    CurrentOption={"2D"}, Flag="ESPBoxType",
    Callback=function(v) ESP.BoxType=v[1] end,
})
ESPTab:CreateDropdown({
    Name="Tracer Origin", Options={"Bottom","Top","Middle"},
    CurrentOption={"Bottom"}, Flag="ESPTracerPos",
    Callback=function(v) ESP.TracerPosition=v[1] end,
})

ESPTab:CreateDivider()
ESPTab:CreateSection("— Box Correction —")

ESPTab:CreateSlider({
    Name = "Vertical Offset",
    Range = {-80, 80}, Increment = 2,
    Suffix = " px", CurrentValue = -20, Flag = "ESPOffsetY",
    Callback = function(v) ESP_OFFSET_Y = v end,
})
ESPTab:CreateSlider({
    Name = "Width Scale",
    Range = {50, 120}, Increment = 5,
    Suffix = "%", CurrentValue = 80, Flag = "ESPScaleX",
    Callback = function(v) ESP_SCALE_X = v / 100 end,
})
ESPTab:CreateSlider({
    Name = "Height Scale",
    Range = {50, 120}, Increment = 5,
    Suffix = "%", CurrentValue = 85, Flag = "ESPScaleY",
    Callback = function(v) ESP_SCALE_Y = v / 100 end,
})

-- ════════════════════════════════════════════════════════════
--  🧍 PLAYER TAB
-- ════════════════════════════════════════════════════════════

local PlayerTab = Window:CreateTab("🧍  Player", nil)
PlayerTab:CreateSection("— Movement —")

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false, Flag = "InfJump",
    Callback = function(v)
        infJump = v
        Rayfield:Notify({
            Title   = v and "✅  Infinite Jump ON" or "❌  Infinite Jump OFF",
            Content = v and "Jump as many times as you want." or "Infinite jump disabled.",
            Duration = 2,
        })
    end,
})

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 250}, Increment = 2,
    Suffix = " stud/s", CurrentValue = 16, Flag = "WalkSpd",
    Callback = function(v) walkSpeed = v end,
})

PlayerTab:CreateToggle({
    Name = "⚡  Speed Boost  (hold Left Shift)",
    CurrentValue = false, Flag = "SpeedBoost",
    Callback = function(v)
        speedBoost = v
        Rayfield:Notify({
            Title   = v and "✅  Speed Boost ON" or "❌  Speed Boost OFF",
            Content = v and "Hold Left Shift to activate boost." or "Speed boost disabled.",
            Duration = 2,
        })
    end,
})

PlayerTab:CreateSlider({
    Name = "Speed Boost Value",
    Range = {20, 500}, Increment = 10,
    Suffix = " stud/s", CurrentValue = 50, Flag = "SpeedBoostVal",
    Callback = function(v) speedBoostVal = v end,
})

PlayerTab:CreateToggle({
    Name = "🕊️  Fly  (WASD + Space/Ctrl)",
    CurrentValue = false, Flag = "FlyEnabled",
    Callback = function(v)
        flyEnabled = v
        if v then
            enableFly()
            Rayfield:Notify({
                Title   = "✅  Fly Enabled",
                Content = "WASD to move  |  Space = up  |  Ctrl = down",
                Duration = 3,
            })
        else
            disableFly()
            Rayfield:Notify({
                Title   = "❌  Fly Disabled",
                Content = "Flying turned off.",
                Duration = 2,
            })
        end
    end,
})

PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200}, Increment = 10,
    Suffix = " stud/s", CurrentValue = 50, Flag = "FlySpeed",
    Callback = function(v) flySpeed = v end,
})

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false, Flag = "Noclip",
    Callback = function(v)
        noclipEnabled = v
        Rayfield:Notify({
            Title   = v and "✅  Noclip ON" or "❌  Noclip OFF",
            Content = v and "You can now walk through walls." or "Noclip disabled.",
            Duration = 2,
        })
    end,
})

PlayerTab:CreateDivider()
PlayerTab:CreateSection("— Teleport —")

PlayerTab:CreateButton({
    Name = "📍  Teleport to Spawn",
    Callback = function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        if hrp and spawn then
            hrp.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
            Rayfield:Notify({ Title = "📍  Teleported", Content = "Moved to spawn location.", Duration = 2 })
        else
            Rayfield:Notify({ Title = "⚠️  Failed", Content = "Could not find a spawn point.", Duration = 2 })
        end
    end,
})

PlayerTab:CreateButton({
    Name = "📍  Teleport to Nearest Player",
    Callback = function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local nearest, nearestDist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = p
                end
            end
        end
        if nearest then
            hrp.CFrame = nearest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            Rayfield:Notify({ Title = "📍  Teleported", Content = "Moved to: " .. nearest.Name, Duration = 2 })
        else
            Rayfield:Notify({ Title = "⚠️  No Players", Content = "No players found nearby.", Duration = 2 })
        end
    end,
})

PlayerTab:CreateButton({
    Name = "📍  Teleport to Random Player",
    Callback = function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local others = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(others, p)
            end
        end
        if #others == 0 then
            Rayfield:Notify({ Title = "⚠️  No Players", Content = "No other players found.", Duration = 2 })
            return
        end
        local target = others[math.random(1, #others)]
        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Rayfield:Notify({ Title = "📍  Teleported", Content = "Moved to: " .. target.Name, Duration = 2 })
    end,
})

-- ════════════════════════════════════════════════════════════
--  ⚙️ MISC TAB
-- ════════════════════════════════════════════════════════════

local MiscTab = Window:CreateTab("⚙️  Misc", nil)
MiscTab:CreateSection("— Visuals —")

MiscTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false, Flag = "Fullbright",
    Callback = function(v)
        fullbright = v
        Rayfield:Notify({
            Title   = v and "✅  Fullbright ON" or "❌  Fullbright OFF",
            Content = v and "Lighting set to maximum visibility." or "Fullbright disabled.",
            Duration = 2,
        })
    end,
})

MiscTab:CreateToggle({
    Name = "🌈  Rainbow Gun",
    CurrentValue = false, Flag = "Rainbow",
    Callback = function(v)
        rainbowEnabled = v
        if not v then
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    for _, p in ipairs(tool:GetDescendants()) do
                        if p:IsA("BasePart") or p:IsA("MeshPart") then
                            pcall(function() p.Color = Color3.fromRGB(163,162,165) end)
                        end
                    end
                end
            end
        end
    end,
})

MiscTab:CreateDivider()
MiscTab:CreateSection("— Farm —")

MiscTab:CreateToggle({
    Name = "🌾  Auto Farm  (collect nearby items)",
    CurrentValue = false, Flag = "AutoFarm",
    Callback = function(v)
        autoFarm = v
        if v then
            startAutoFarm()
            Rayfield:Notify({ Title = "✅  Auto Farm ON", Content = "Collecting nearby items automatically.", Duration = 2 })
        else
            stopAutoFarm()
            Rayfield:Notify({ Title = "❌  Auto Farm OFF", Content = "Auto farm disabled.", Duration = 2 })
        end
    end,
})

MiscTab:CreateDivider()
MiscTab:CreateSection("— Utility —")

MiscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false, Flag = "AntiAFK",
    Callback = function(v) antiAFK = v end,
})

MiscTab:CreateButton({
    Name = "🔄  Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

MiscTab:CreateButton({
    Name = "📋  Copy Username to Clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(LocalPlayer.Name)
            Rayfield:Notify({ Title = "📋  Copied", Content = "Username copied: " .. LocalPlayer.Name, Duration = 2 })
        end
    end,
})

-- ════════════════════════════════════════════════════════════
--  ℹ️ INFO TAB
-- ════════════════════════════════════════════════════════════

local InfoTab = Window:CreateTab("ℹ️  Info", nil)
InfoTab:CreateSection("— Credits —")
InfoTab:CreateLabel("Script by: traplixy gaming")
InfoTab:CreateLabel("UI: traplixy gaming")
InfoTab:CreateLabel("ESP: traplixy gaming")
InfoTab:CreateLabel("All rights reserved — traplixy gaming")
InfoTab:CreateDivider()
InfoTab:CreateSection("— Features —")
InfoTab:CreateLabel("🎯  Aimbot — RMB, Silent, Auto Click")
InfoTab:CreateLabel("⚔️  Combat — Kill Aura, God Mode, Inf Ammo")
InfoTab:CreateLabel("👁️  ESP — Boxes, names, health, tracers")
InfoTab:CreateLabel("🧍  Player — Jump, speed boost, fly, noclip")
InfoTab:CreateLabel("📍  Teleport — Spawn, nearest, random player")
InfoTab:CreateLabel("🌾  Auto Farm — Collects nearby items")
InfoTab:CreateLabel("🌈  Rainbow Gun — Cycle gun color")
InfoTab:CreateLabel("💡  Fullbright — Max visibility")
InfoTab:CreateLabel("🔄  Rejoin — Instantly rejoin the server")
InfoTab:CreateDivider()
InfoTab:CreateSection("— Key Info —")
InfoTab:CreateLabel("Keys: free | vip | dev  (case-insensitive)")
InfoTab:CreateLabel("Settings auto-save on toggle/slider change")
InfoTab:CreateLabel("Version: " .. SCRIPT_VER .. "  |  by traplixy gaming")

Rayfield:Notify({
    Title   = "✅  Rivals Hub " .. SCRIPT_VER .. " Ready",
    Content = "Welcome  |  by traplixy gaming",
    Duration = 4,
})

-- Load saved config
Rayfield:LoadConfiguration()
