-- // ═══════════════════════════════════════════════════════════
-- //  RIVALS HUB  |  Rayfield UI  |  v4.1
-- //  by traplixy gaming
-- // ═══════════════════════════════════════════════════════════

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local VirtualUser      = game:GetService("VirtualUser")
local SoundService     = game:GetService("SoundService")
local HttpService      = game:GetService("HttpService")
local LocalPlayer      = Players.LocalPlayer
local Camera           = workspace.CurrentCamera
local PlayerGui        = LocalPlayer:WaitForChild("PlayerGui")

local SCRIPT_NAME = "RIVALS HUB"
local SCRIPT_VER  = "v4.1"
local ACCENT      = Color3.fromRGB(0, 180, 255)
local ACCENT2     = Color3.fromRGB(0, 220, 255)
local ACCENT_DARK = Color3.fromRGB(0, 100, 200)
local VALID_KEY   = "K7husj-fauh4f-28bafd"

local function tw(o,t,p,s,d)
    TweenService:Create(o,TweenInfo.new(t,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play()
end
local function mkCorner(o,r) Instance.new("UICorner",o).CornerRadius=UDim.new(0,r or 8) end
local function mkStroke(o,c,t) local s=Instance.new("UIStroke",o); s.Color=c; s.Thickness=t or 1; return s end

-- ════════════════════════════════════════════════════════════
--  CUSTOM NOTIFICATIONS
-- ════════════════════════════════════════════════════════════

local notifGui=Instance.new("ScreenGui")
notifGui.Name="RivalsNotifs"; notifGui.ResetOnSpawn=false
notifGui.IgnoreGuiInset=true; notifGui.DisplayOrder=9998
notifGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
notifGui.Parent=PlayerGui

local notifContainer=Instance.new("Frame",notifGui)
notifContainer.Size=UDim2.fromOffset(300,0); notifContainer.AutomaticSize=Enum.AutomaticSize.Y
notifContainer.AnchorPoint=Vector2.new(1,1); notifContainer.Position=UDim2.new(1,-16,1,-16)
notifContainer.BackgroundTransparency=1; notifContainer.BorderSizePixel=0
local notifLayout=Instance.new("UIListLayout",notifContainer)
notifLayout.SortOrder=Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom
notifLayout.Padding=UDim.new(0,6)
local notifCount=0

local function notify(title,content,ntype)
    notifCount+=1
    local col=ntype=="error" and Color3.fromRGB(220,55,55)
             or ntype=="success" and Color3.fromRGB(50,200,100)
             or ACCENT
    local frame=Instance.new("Frame",notifContainer)
    frame.Size=UDim2.fromOffset(300,0); frame.AutomaticSize=Enum.AutomaticSize.Y
    frame.BackgroundColor3=Color3.fromRGB(10,12,22); frame.BorderSizePixel=0
    frame.LayoutOrder=notifCount; frame.Position=UDim2.fromOffset(320,0)
    mkCorner(frame,10); mkStroke(frame,col,1.2)
    local bar=Instance.new("Frame",frame)
    bar.Size=UDim2.new(0,3,1,0); bar.BackgroundColor3=col; bar.BorderSizePixel=0; mkCorner(bar,3)
    local icon=Instance.new("TextLabel",frame)
    icon.Size=UDim2.fromOffset(28,28); icon.Position=UDim2.fromOffset(10,10)
    icon.BackgroundColor3=col; icon.BackgroundTransparency=0.8; icon.BorderSizePixel=0
    icon.Text=ntype=="error" and "✕" or ntype=="success" and "✓" or "!"
    icon.TextColor3=col; icon.Font=Enum.Font.GothamBold; icon.TextSize=14; mkCorner(icon,6)
    local titleLbl=Instance.new("TextLabel",frame)
    titleLbl.Size=UDim2.new(1,-52,0,18); titleLbl.Position=UDim2.fromOffset(46,8)
    titleLbl.BackgroundTransparency=1; titleLbl.Text=title
    titleLbl.TextColor3=Color3.fromRGB(255,255,255); titleLbl.Font=Enum.Font.GothamBold
    titleLbl.TextSize=13; titleLbl.TextXAlignment=Enum.TextXAlignment.Left
    local contentLbl=Instance.new("TextLabel",frame)
    contentLbl.Size=UDim2.new(1,-52,0,0); contentLbl.AutomaticSize=Enum.AutomaticSize.Y
    contentLbl.Position=UDim2.fromOffset(46,24); contentLbl.BackgroundTransparency=1
    contentLbl.Text=content; contentLbl.TextColor3=Color3.fromRGB(130,150,175)
    contentLbl.Font=Enum.Font.Gotham; contentLbl.TextSize=11
    contentLbl.TextXAlignment=Enum.TextXAlignment.Left; contentLbl.TextWrapped=true
    local pad=Instance.new("UIPadding",frame); pad.PaddingBottom=UDim.new(0,10)
    local progBG=Instance.new("Frame",frame)
    progBG.Size=UDim2.new(1,-16,0,2); progBG.Position=UDim2.new(0,8,1,-4)
    progBG.BackgroundColor3=Color3.fromRGB(25,30,50); progBG.BorderSizePixel=0; mkCorner(progBG,99)
    local prog=Instance.new("Frame",progBG)
    prog.Size=UDim2.fromScale(1,1); prog.BackgroundColor3=col; prog.BorderSizePixel=0; mkCorner(prog,99)
    tw(frame,0.3,{Position=UDim2.fromOffset(0,0)},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    task.spawn(function()
        task.wait(0.3)
        tw(prog,3,{Size=UDim2.fromScale(0,1)},Enum.EasingStyle.Linear)
        task.wait(3)
        tw(frame,0.3,{Position=UDim2.fromOffset(320,0),BackgroundTransparency=1})
        task.wait(0.35); frame:Destroy()
    end)
end

-- ════════════════════════════════════════════════════════════
--  CINEMATIC LOADING SCREEN
-- ════════════════════════════════════════════════════════════

local loadGui=Instance.new("ScreenGui")
loadGui.Name="RivalsLoader"; loadGui.ResetOnSpawn=false
loadGui.IgnoreGuiInset=true; loadGui.DisplayOrder=9999
loadGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
loadGui.Parent=PlayerGui

local bg=Instance.new("Frame",loadGui)
bg.Size=UDim2.fromScale(1,1); bg.BackgroundColor3=Color3.fromRGB(0,0,0)
bg.BorderSizePixel=0; bg.ZIndex=1
local bgG=Instance.new("UIGradient",bg)
bgG.Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(2,6,18)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(1,2,8)),
}
bgG.Rotation=135

local scanline=Instance.new("Frame",loadGui)
scanline.Size=UDim2.fromScale(1,1); scanline.BackgroundColor3=Color3.fromRGB(0,0,0)
scanline.BackgroundTransparency=0.92; scanline.BorderSizePixel=0; scanline.ZIndex=8
local scanG=Instance.new("UIGradient",scanline)
scanG.Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0)),
}
task.spawn(function()
    local t=0
    while loadGui and loadGui.Parent do t=(t+0.8)%100; scanG.Offset=Vector2.new(0,t/100-0.5); task.wait(0.016) end
end)

local pCon=Instance.new("Frame",loadGui)
pCon.Size=UDim2.fromScale(1,1); pCon.BackgroundTransparency=1; pCon.ZIndex=2
local function spawnP()
    local p=Instance.new("Frame",pCon)
    local sz=math.random(1,3)
    p.Size=UDim2.fromOffset(sz,sz)
    p.Position=UDim2.fromScale(math.random(0,100)/100,math.random(0,100)/100)
    p.BackgroundColor3=math.random()<0.5 and ACCENT or Color3.fromRGB(255,255,255)
    p.BackgroundTransparency=math.random(60,95)/100
    p.BorderSizePixel=0; p.ZIndex=2; mkCorner(p,99)
    local dur=math.random(20,60)/10
    tw(p,dur,{Position=UDim2.fromScale(math.random(0,100)/100,math.random(0,100)/100),BackgroundTransparency=1},Enum.EasingStyle.Linear)
    task.delay(dur,function() if p and p.Parent then p:Destroy() end end)
end
task.spawn(function() while loadGui and loadGui.Parent do spawnP(); task.wait(0.05) end end)

local rC=Instance.new("Frame",loadGui)
rC.Size=UDim2.fromOffset(220,220); rC.AnchorPoint=Vector2.new(0.5,0.5)
rC.Position=UDim2.fromScale(0.5,0.38); rC.BackgroundTransparency=1; rC.ZIndex=3

local function mkRing(sz,col,thick,trans)
    local r=Instance.new("Frame",rC)
    r.Size=UDim2.fromOffset(sz,sz); r.AnchorPoint=Vector2.new(0.5,0.5)
    r.Position=UDim2.fromScale(0.5,0.5); r.BackgroundTransparency=1; r.ZIndex=3; mkCorner(r,99)
    local s=Instance.new("UIStroke",r); s.Color=col; s.Thickness=thick; s.Transparency=trans or 0
    return r
end
mkRing(220,ACCENT,1.5,0.5)
mkRing(175,ACCENT2,1,0.65)
mkRing(130,ACCENT,0.8,0.75)

local innerGlow=Instance.new("Frame",rC)
innerGlow.Size=UDim2.fromOffset(90,90); innerGlow.AnchorPoint=Vector2.new(0.5,0.5)
innerGlow.Position=UDim2.fromScale(0.5,0.5); innerGlow.BackgroundColor3=ACCENT
innerGlow.BackgroundTransparency=0.78; innerGlow.BorderSizePixel=0; innerGlow.ZIndex=4; mkCorner(innerGlow,99)

task.spawn(function()
    while loadGui and loadGui.Parent do
        tw(innerGlow,1.6,{BackgroundTransparency=0.5,Size=UDim2.fromOffset(105,105)},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
        task.wait(1.6); if not loadGui.Parent then break end
        tw(innerGlow,1.6,{BackgroundTransparency=0.82,Size=UDim2.fromOffset(80,80)},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
        task.wait(1.6)
    end
end)

local spinArc1=Instance.new("Frame",rC)
spinArc1.Size=UDim2.fromOffset(220,220); spinArc1.AnchorPoint=Vector2.new(0.5,0.5)
spinArc1.Position=UDim2.fromScale(0.5,0.5); spinArc1.BackgroundTransparency=1; spinArc1.ZIndex=5; mkCorner(spinArc1,99)
local sS1=Instance.new("UIStroke",spinArc1); sS1.Color=ACCENT2; sS1.Thickness=2.5

local spinArc2=Instance.new("Frame",rC)
spinArc2.Size=UDim2.fromOffset(175,175); spinArc2.AnchorPoint=Vector2.new(0.5,0.5)
spinArc2.Position=UDim2.fromScale(0.5,0.5); spinArc2.BackgroundTransparency=1; spinArc2.ZIndex=5; mkCorner(spinArc2,99)
local sS2=Instance.new("UIStroke",spinArc2); sS2.Color=ACCENT; sS2.Thickness=1.5

task.spawn(function()
    local r1,r2=0,0
    while loadGui and loadGui.Parent do
        r1=(r1+3)%360; r2=(r2-2)%360
        spinArc1.Rotation=r1; spinArc2.Rotation=r2; task.wait(0.016)
    end
end)

local logoLbl=Instance.new("TextLabel",loadGui)
logoLbl.Size=UDim2.fromOffset(200,60); logoLbl.AnchorPoint=Vector2.new(0.5,0.5)
logoLbl.Position=UDim2.fromScale(0.5,0.38); logoLbl.BackgroundTransparency=1
logoLbl.Text="⚡"; logoLbl.TextColor3=Color3.fromRGB(255,255,255)
logoLbl.Font=Enum.Font.GothamBold; logoLbl.TextSize=34; logoLbl.ZIndex=6; logoLbl.TextTransparency=1

local titleLbl=Instance.new("TextLabel",loadGui)
titleLbl.Size=UDim2.fromOffset(600,52); titleLbl.AnchorPoint=Vector2.new(0.5,0)
titleLbl.Position=UDim2.new(0.5,0,0.56,0); titleLbl.BackgroundTransparency=1
titleLbl.Text="RIVALS HUB"; titleLbl.TextColor3=Color3.fromRGB(255,255,255)
titleLbl.Font=Enum.Font.GothamBold; titleLbl.TextSize=38; titleLbl.ZIndex=6; titleLbl.TextTransparency=1
local tStroke=Instance.new("UIStroke",titleLbl); tStroke.Color=ACCENT; tStroke.Thickness=0.8; tStroke.Transparency=0.5

local subLbl=Instance.new("TextLabel",loadGui)
subLbl.Size=UDim2.fromOffset(500,22); subLbl.AnchorPoint=Vector2.new(0.5,0)
subLbl.Position=UDim2.new(0.5,0,0.65,0); subLbl.BackgroundTransparency=1
subLbl.Text="by traplixy gaming"
subLbl.TextColor3=ACCENT; subLbl.Font=Enum.Font.Gotham; subLbl.TextSize=13
subLbl.ZIndex=6; subLbl.TextTransparency=1

local verBadge=Instance.new("Frame",loadGui)
verBadge.Size=UDim2.fromOffset(70,22); verBadge.AnchorPoint=Vector2.new(0.5,0)
verBadge.Position=UDim2.new(0.5,0,0.70,0); verBadge.BackgroundColor3=Color3.fromRGB(8,14,30)
verBadge.BorderSizePixel=0; verBadge.ZIndex=6; mkCorner(verBadge,99); mkStroke(verBadge,ACCENT,1)
local verLbl=Instance.new("TextLabel",verBadge)
verLbl.Size=UDim2.fromScale(1,1); verLbl.BackgroundTransparency=1
verLbl.Text=SCRIPT_VER; verLbl.TextColor3=ACCENT
verLbl.Font=Enum.Font.GothamBold; verLbl.TextSize=11; verLbl.ZIndex=7

local barBG=Instance.new("Frame",loadGui)
barBG.Size=UDim2.fromOffset(380,4); barBG.AnchorPoint=Vector2.new(0.5,0)
barBG.Position=UDim2.new(0.5,0,0.76,0); barBG.BackgroundColor3=Color3.fromRGB(12,15,30)
barBG.BorderSizePixel=0; barBG.ZIndex=6; mkCorner(barBG,99)
local barFill=Instance.new("Frame",barBG)
barFill.Size=UDim2.fromScale(0,1); barFill.BackgroundColor3=ACCENT
barFill.BorderSizePixel=0; barFill.ZIndex=7; mkCorner(barFill,99)
local barG=Instance.new("UIGradient",barFill)
barG.Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,ACCENT_DARK),
    ColorSequenceKeypoint.new(0.5,ACCENT2),
    ColorSequenceKeypoint.new(1,ACCENT),
}
local barDot=Instance.new("Frame",barFill)
barDot.Size=UDim2.fromOffset(10,10); barDot.AnchorPoint=Vector2.new(1,0.5)
barDot.Position=UDim2.new(1,0,0.5,0); barDot.BackgroundColor3=Color3.fromRGB(200,240,255)
barDot.BorderSizePixel=0; barDot.ZIndex=8; mkCorner(barDot,99)

local statusLbl=Instance.new("TextLabel",loadGui)
statusLbl.Size=UDim2.fromOffset(380,18); statusLbl.AnchorPoint=Vector2.new(0.5,0)
statusLbl.Position=UDim2.new(0.5,0,0.79,0); statusLbl.BackgroundTransparency=1
statusLbl.Text=""; statusLbl.TextColor3=Color3.fromRGB(60,130,170)
statusLbl.Font=Enum.Font.Code; statusLbl.TextSize=11
statusLbl.ZIndex=6; statusLbl.TextXAlignment=Enum.TextXAlignment.Left

local skipLbl=Instance.new("TextLabel",loadGui)
skipLbl.Size=UDim2.fromOffset(260,16); skipLbl.AnchorPoint=Vector2.new(0.5,1)
skipLbl.Position=UDim2.new(0.5,0,1,-12); skipLbl.BackgroundTransparency=1
skipLbl.Text="[ SPACE ] skip"; skipLbl.TextColor3=Color3.fromRGB(20,40,60)
skipLbl.Font=Enum.Font.Code; skipLbl.TextSize=10; skipLbl.ZIndex=6

local loadSteps={
    {text="> initializing core modules...",    pct=0.12},
    {text="> loading rayfield ui...",           pct=0.25},
    {text="> verifying key...",                 pct=0.38},
    {text="> building aimbot engine...",        pct=0.52},
    {text="> configuring esp renderer...",      pct=0.64},
    {text="> loading hitbox expander...",       pct=0.75},
    {text="> applying configuration...",        pct=0.88},
    {text="> ready...",                         pct=1.00},
}

local loadDone=false
local skipped=false

local function typewrite(lbl,text,speed)
    lbl.Text=""
    for i=1,#text do
        if skipped then lbl.Text=text; return end
        lbl.Text=string.sub(text,1,i); task.wait(speed or 0.025)
    end
end

local function glitchTitle()
    local orig="RIVALS HUB"
    local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$"
    for i=1,4 do
        local g=""
        for j=1,#orig do
            g=g..(math.random()<0.3 and string.sub(chars,math.random(1,#chars),math.random(1,#chars)) or string.sub(orig,j,j))
        end
        titleLbl.Text=g; task.wait(0.04)
    end
    titleLbl.Text=orig
end

local function fadeLoader()
    for _,o in ipairs({logoLbl,titleLbl,subLbl,statusLbl,skipLbl}) do tw(o,0.4,{TextTransparency=1}) end
    tw(verBadge,0.4,{BackgroundTransparency=1})
    tw(barBG,0.4,{BackgroundTransparency=1}); tw(barFill,0.4,{BackgroundTransparency=1})
    tw(innerGlow,0.4,{BackgroundTransparency=1}); tw(bg,0.7,{BackgroundTransparency=1})
    task.wait(0.8); loadGui:Destroy(); loadDone=true
end

UserInputService.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode==Enum.KeyCode.Space and not skipped and not loadDone then
        skipped=true; barFill.Size=UDim2.fromScale(1,1)
        statusLbl.Text="> ready..."
        task.wait(0.3); fadeLoader()
    end
end)

task.spawn(function()
    task.wait(0.2)
    tw(logoLbl,1.2,{TextTransparency=0}); task.wait(0.5)
    tw(titleLbl,0.8,{TextTransparency=0}); task.wait(0.4)
    if not skipped then task.spawn(glitchTitle) end; task.wait(0.4)
    tw(subLbl,0.7,{TextTransparency=0}); task.wait(0.2)
    tw(verBadge,0.5,{BackgroundTransparency=0}); task.wait(0.3)
    statusLbl.TextTransparency=0
    for _,step in ipairs(loadSteps) do
        if skipped then return end
        task.spawn(function() typewrite(statusLbl,step.text,0.018) end)
        tw(barFill,0.5,{Size=UDim2.fromScale(step.pct,1)},Enum.EasingStyle.Quint)
        task.wait(0.45)
    end
    if skipped then return end
    task.wait(0.3)
    tw(barFill,0.12,{BackgroundColor3=Color3.fromRGB(255,255,255)})
    task.wait(0.12); tw(barFill,0.4,{BackgroundColor3=ACCENT})
    tw(tStroke,0.1,{Transparency=0,Thickness=2}); task.wait(0.1)
    tw(tStroke,0.4,{Transparency=0.5,Thickness=0.8}); task.wait(0.5)
    if not skipped then fadeLoader() end
end)

repeat task.wait(0.05) until loadDone

-- ════════════════════════════════════════════════════════════
--  KEY SYSTEM
-- ════════════════════════════════════════════════════════════

local _keyDone=false
local _verifiedUser=""
local _verifiedPlan=""

local function runKeySystem()
    local kGui=Instance.new("ScreenGui")
    kGui.Name="RivalsKeyGUI"; kGui.ResetOnSpawn=false
    kGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    kGui.IgnoreGuiInset=true; kGui.DisplayOrder=9997
    kGui.Parent=PlayerGui

    local overlay=Instance.new("Frame",kGui)
    overlay.Size=UDim2.fromScale(1,1)
    overlay.BackgroundColor3=Color3.fromRGB(0,8,22)
    overlay.BackgroundTransparency=0.4
    overlay.BorderSizePixel=0

    local card=Instance.new("Frame",kGui)
    card.AnchorPoint=Vector2.new(0.5,0.5)
    card.Position=UDim2.fromScale(0.5,0.5)
    card.Size=UDim2.fromOffset(500,300)
    card.BackgroundColor3=Color3.fromRGB(8,10,18)
    card.BorderSizePixel=0
    mkCorner(card,14); mkStroke(card,ACCENT,1.5)

    local topBar=Instance.new("Frame",card)
    topBar.Size=UDim2.new(1,0,0,3); topBar.BackgroundColor3=ACCENT; topBar.BorderSizePixel=0
    local topG=Instance.new("UIGradient",topBar)
    topG.Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,ACCENT_DARK),
        ColorSequenceKeypoint.new(0.5,ACCENT2),
        ColorSequenceKeypoint.new(1,ACCENT_DARK),
    }

    local titleLabel=Instance.new("TextLabel",card)
    titleLabel.Size=UDim2.new(1,0,0,50)
    titleLabel.Position=UDim2.fromOffset(0,20)
    titleLabel.BackgroundTransparency=1
    titleLabel.Text="RIVALS HUB — Key System"
    titleLabel.TextColor3=Color3.fromRGB(255,255,255)
    titleLabel.Font=Enum.Font.GothamBold
    titleLabel.TextSize=22

    local inputLabel=Instance.new("TextLabel",card)
    inputLabel.Size=UDim2.new(0.88,0,0,16)
    inputLabel.AnchorPoint=Vector2.new(0.5,0)
    inputLabel.Position=UDim2.new(0.5,0,0,80)
    inputLabel.BackgroundTransparency=1
    inputLabel.Text="ENTER ACCESS KEY"
    inputLabel.TextColor3=Color3.fromRGB(70,110,150)
    inputLabel.Font=Enum.Font.GothamBold
    inputLabel.TextSize=11

    local inputWrap=Instance.new("Frame",card)
    inputWrap.Size=UDim2.new(0.88,0,0,48)
    inputWrap.AnchorPoint=Vector2.new(0.5,0)
    inputWrap.Position=UDim2.new(0.5,0,0,104)
    inputWrap.BackgroundColor3=Color3.fromRGB(12,14,26)
    inputWrap.BorderSizePixel=0
    mkCorner(inputWrap,10)
    local iStroke=mkStroke(inputWrap,Color3.fromRGB(35,45,70),1.2)

    local inputBox=Instance.new("TextBox",inputWrap)
    inputBox.Size=UDim2.new(1,-16,1,0)
    inputBox.Position=UDim2.fromOffset(10,0)
    inputBox.BackgroundTransparency=1
    inputBox.PlaceholderText="Paste key here..."
    inputBox.PlaceholderColor3=Color3.fromRGB(50,60,90)
    inputBox.Text=""
    inputBox.TextColor3=Color3.fromRGB(200,225,255)
    inputBox.Font=Enum.Font.Code
    inputBox.TextSize=13
    inputBox.TextXAlignment=Enum.TextXAlignment.Left
    inputBox.ClearTextOnFocus=false

    inputBox.Focused:Connect(function() tw(iStroke,0.2,{Color=ACCENT,Thickness=1.8}) end)
    inputBox.FocusLost:Connect(function() tw(iStroke,0.3,{Color=Color3.fromRGB(35,45,70),Thickness=1.2}) end)

    local statusL=Instance.new("TextLabel",card)
    statusL.Size=UDim2.new(0.88,0,0,20)
    statusL.AnchorPoint=Vector2.new(0.5,0)
    statusL.Position=UDim2.new(0.5,0,0,162)
    statusL.BackgroundTransparency=1
    statusL.Text=""
    statusL.Font=Enum.Font.Gotham
    statusL.TextSize=12
    statusL.TextColor3=Color3.fromRGB(255,80,80)

    local btn=Instance.new("TextButton",card)
    btn.Size=UDim2.new(0.88,0,0,46)
    btn.AnchorPoint=Vector2.new(0.5,0)
    btn.Position=UDim2.new(0.5,0,0,190)
    btn.BackgroundColor3=ACCENT
    btn.BorderSizePixel=0
    btn.Text="VERIFY KEY  →"
    btn.TextColor3=Color3.fromRGB(255,255,255)
    btn.Font=Enum.Font.GothamBold
    btn.TextSize=14
    btn.AutoButtonColor=false
    mkCorner(btn,10)

    btn.MouseEnter:Connect(function() tw(btn,0.15,{BackgroundColor3=ACCENT2}) end)
    btn.MouseLeave:Connect(function() tw(btn,0.2,{BackgroundColor3=ACCENT}) end)
    btn.MouseButton1Down:Connect(function() tw(btn,0.08,{Size=UDim2.new(0.86,0,0,44)}) end)
    btn.MouseButton1Up:Connect(function() tw(btn,0.12,{Size=UDim2.new(0.88,0,0,46)},Enum.EasingStyle.Back,Enum.EasingDirection.Out) end)

    local function tryKey()
        local entered=inputBox.Text:gsub("%s+","")
        if entered=="" then
            statusL.TextColor3=Color3.fromRGB(255,180,50)
            statusL.Text="⚠  Please enter a key."
            return
        end
        if entered==VALID_KEY then
            _verifiedUser=LocalPlayer.Name
            _verifiedPlan="Member"
            tw(iStroke,0.2,{Color=Color3.fromRGB(50,220,100)})
            tw(btn,0.2,{BackgroundColor3=Color3.fromRGB(28,185,75)})
            btn.Text="✔  Access Granted"
            statusL.TextColor3=Color3.fromRGB(80,255,130)
            statusL.Text="✔  Welcome, "..LocalPlayer.Name.."!"
            task.wait(1.5)
            tw(card,0.4,{Size=UDim2.fromOffset(500,0)})
            tw(overlay,0.4,{BackgroundTransparency=1})
            task.wait(0.5); kGui:Destroy(); _keyDone=true
        else
            tw(iStroke,0.1,{Color=Color3.fromRGB(255,55,55)})
            task.wait(0.15)
            tw(iStroke,0.45,{Color=Color3.fromRGB(35,45,70)})
            statusL.TextColor3=Color3.fromRGB(255,75,75)
            statusL.Text="✘  Invalid key. Access denied."
            btn.Text="TRY AGAIN"
            tw(btn,0.2,{BackgroundColor3=ACCENT})
        end
    end

    btn.MouseButton1Click:Connect(function() task.spawn(tryKey) end)
    inputBox.FocusLost:Connect(function(enter) if enter then task.spawn(tryKey) end end)

    repeat task.wait(0.05) until _keyDone
end

task.spawn(runKeySystem)
repeat task.wait(0.05) until _keyDone

-- ════════════════════════════════════════════════════════════
--  WATERMARK
-- ════════════════════════════════════════════════════════════

local wmGui=Instance.new("ScreenGui")
wmGui.Name="RivalsWatermark"; wmGui.ResetOnSpawn=false
wmGui.IgnoreGuiInset=true; wmGui.DisplayOrder=990
wmGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
wmGui.Parent=PlayerGui

local wm=Instance.new("Frame",wmGui)
wm.Size=UDim2.fromOffset(0,30); wm.AutomaticSize=Enum.AutomaticSize.X
wm.Position=UDim2.fromOffset(12,12); wm.BackgroundColor3=Color3.fromRGB(6,8,18)
wm.BackgroundTransparency=0.15; wm.BorderSizePixel=0; mkCorner(wm,8); mkStroke(wm,ACCENT,1)
local wmPad=Instance.new("UIPadding",wm)
wmPad.PaddingLeft=UDim.new(0,10); wmPad.PaddingRight=UDim.new(0,10)
local wmLayout=Instance.new("UIListLayout",wm)
wmLayout.FillDirection=Enum.FillDirection.Horizontal
wmLayout.SortOrder=Enum.SortOrder.LayoutOrder
wmLayout.Padding=UDim.new(0,6)
wmLayout.VerticalAlignment=Enum.VerticalAlignment.Center

local wmDot=Instance.new("Frame",wm)
wmDot.Size=UDim2.fromOffset(6,6); wmDot.BackgroundColor3=ACCENT
wmDot.BorderSizePixel=0; wmDot.LayoutOrder=1; mkCorner(wmDot,99)
task.spawn(function()
    while wmGui and wmGui.Parent do
        tw(wmDot,0.6,{BackgroundColor3=ACCENT2,Size=UDim2.fromOffset(7,7)},Enum.EasingStyle.Sine)
        task.wait(0.6)
        tw(wmDot,0.6,{BackgroundColor3=ACCENT,Size=UDim2.fromOffset(6,6)},Enum.EasingStyle.Sine)
        task.wait(0.6)
    end
end)

local wmText=Instance.new("TextLabel",wm)
wmText.Size=UDim2.fromOffset(0,30); wmText.AutomaticSize=Enum.AutomaticSize.X
wmText.BackgroundTransparency=1; wmText.LayoutOrder=2
wmText.Font=Enum.Font.GothamBold; wmText.TextSize=12
wmText.TextColor3=Color3.fromRGB(220,230,255)
wmText.Text="Rivals Hub  "..SCRIPT_VER

local function mkWmSep(order)
    local s=Instance.new("TextLabel",wm)
    s.Size=UDim2.fromOffset(0,30); s.AutomaticSize=Enum.AutomaticSize.X
    s.BackgroundTransparency=1; s.LayoutOrder=order; s.Text="|"
    s.Font=Enum.Font.Gotham; s.TextSize=11; s.TextColor3=Color3.fromRGB(30,45,70)
    return s
end
mkWmSep(3)

local wmFPS=Instance.new("TextLabel",wm)
wmFPS.Size=UDim2.fromOffset(0,30); wmFPS.AutomaticSize=Enum.AutomaticSize.X
wmFPS.BackgroundTransparency=1; wmFPS.LayoutOrder=4
wmFPS.Font=Enum.Font.Gotham; wmFPS.TextSize=11; wmFPS.TextColor3=ACCENT
mkWmSep(5)

local wmStatus=Instance.new("TextLabel",wm)
wmStatus.Size=UDim2.fromOffset(0,30); wmStatus.AutomaticSize=Enum.AutomaticSize.X
wmStatus.BackgroundTransparency=1; wmStatus.LayoutOrder=6
wmStatus.Font=Enum.Font.Gotham; wmStatus.TextSize=11
wmStatus.TextColor3=Color3.fromRGB(130,145,175)

local wmDrag,wmDragStart,wmDragPos=false,nil,nil
wm.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then wmDrag=true; wmDragStart=i.Position; wmDragPos=wm.Position end
end)
wm.InputChanged:Connect(function(i)
    if wmDrag and i.UserInputType==Enum.UserInputType.MouseMovement then
        local d=i.Position-wmDragStart
        wm.Position=UDim2.new(wmDragPos.X.Scale,wmDragPos.X.Offset+d.X,wmDragPos.Y.Scale,wmDragPos.Y.Offset+d.Y)
    end
end)
wm.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then wmDrag=false end
end)

local fpsBuffer={}
RunService.RenderStepped:Connect(function(dt)
    table.insert(fpsBuffer,1/dt)
    if #fpsBuffer>20 then table.remove(fpsBuffer,1) end
    local avg=0; for _,v in ipairs(fpsBuffer) do avg+=v end
    local fps=math.floor(avg/#fpsBuffer)
    local fpsCol=fps>=60 and Color3.fromRGB(50,220,100) or fps>=30 and Color3.fromRGB(255,180,50) or Color3.fromRGB(255,60,60)
    wmFPS.Text=fps.." fps"; wmFPS.TextColor3=fpsCol
end)

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
local aimShake       = false
local aimShakeAmt    = 2
local infJump        = false
local walkSpeed      = 16
local speedBoost     = false
local speedBoostVal  = 50
local bHop           = false
local flyEnabled     = false
local flySpeed       = 50
local customFOV      = false
local customFOVVal   = 70
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
local showCrosshair  = false
local hitSound       = false
local crosshairSize  = 8
local hitboxExpander = false
local hitboxSize     = 5

-- ════════════════════════════════════════════════════════════
--  HITBOX EXPANDER
-- ════════════════════════════════════════════════════════════

local expandedParts={}
local function applyHitboxExpander()
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        local char=player.Character; if not char then continue end
        for _,part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                if not expandedParts[part] then expandedParts[part]=part.Size end
                pcall(function()
                    part.Size=expandedParts[part]+Vector3.new(hitboxSize,hitboxSize,hitboxSize)
                    if part.Transparency<0.99 then part.Transparency=0.99 end
                end)
            end
        end
    end
end
local function removeHitboxExpander()
    for part,origSize in pairs(expandedParts) do
        pcall(function() if part and part.Parent then part.Size=origSize end end)
    end
    expandedParts={}
end
RunService.Heartbeat:Connect(function()
    if hitboxExpander then applyHitboxExpander() end
end)
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if hitboxExpander then task.wait(1); applyHitboxExpander() end
    end)
end)

-- ── ESP ──────────────────────────────────────────────────────
local ESP=loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))()
ESP.Enabled=false; ESP.ShowBox=false; ESP.ShowName=false; ESP.ShowHealth=false
ESP.ShowTracer=false; ESP.ShowDistance=false; ESP.ShowSkeletons=false
ESP.TeamCheck=false; ESP.BoxType="2D"; ESP.TracerPosition="Bottom"

local ESP_OFFSET_Y=-20; local ESP_SCALE_X=0.80; local ESP_SCALE_Y=0.85
local _origUpdate=ESP.Update
if _origUpdate then
    ESP.Update=function(self,...)
        _origUpdate(self,...)
        for _,obj in pairs(ESP.Objects or {}) do
            if obj.Box then
                local b=obj.Box
                if b.Size then b.Size=Vector2.new(b.Size.X*ESP_SCALE_X,b.Size.Y*ESP_SCALE_Y) end
                if b.Position then
                    b.Position=Vector2.new(
                        b.Position.X+(b.Size and b.Size.X*(1-ESP_SCALE_X)/2 or 0),
                        b.Position.Y+ESP_OFFSET_Y
                    )
                end
            end
        end
    end
end

-- ── FOV + CROSSHAIR ──────────────────────────────────────────
local fovCircle=Drawing.new("Circle")
fovCircle.Visible=false; fovCircle.Filled=false
fovCircle.Color=ACCENT; fovCircle.Thickness=1.5
fovCircle.NumSides=64; fovCircle.Radius=aimbotFOV

local chLines={}
for i=1,4 do
    local l=Drawing.new("Line")
    l.Visible=false; l.Color=ACCENT; l.Thickness=1.5; l.Transparency=0
    table.insert(chLines,l)
end

local function updateCrosshair()
    local c=Camera.ViewportSize/2
    local s=crosshairSize; local gap=4
    chLines[1].From=Vector2.new(c.X-s-gap,c.Y); chLines[1].To=Vector2.new(c.X-gap,c.Y)
    chLines[2].From=Vector2.new(c.X+gap,c.Y); chLines[2].To=Vector2.new(c.X+s+gap,c.Y)
    chLines[3].From=Vector2.new(c.X,c.Y-s-gap); chLines[3].To=Vector2.new(c.X,c.Y-gap)
    chLines[4].From=Vector2.new(c.X,c.Y+gap); chLines[4].To=Vector2.new(c.X,c.Y+s+gap)
    for _,l in ipairs(chLines) do l.Visible=showCrosshair; l.Color=ACCENT end
end

-- ── TARGET FINDER ────────────────────────────────────────────
local function getTarget()
    local lc=LocalPlayer.Character; if not lc then return nil end
    local mouse=UserInputService:GetMouseLocation()
    local best,bd=nil,math.huge
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        local char=player.Character; if not char then continue end
        local hum=char:FindFirstChild("Humanoid")
        local part=char:FindFirstChild(aimAtPart) or char:FindFirstChild("HumanoidRootPart")
        if not hum or not part or hum.Health<=0 then continue end
        if teamCheck and player.Team==LocalPlayer.Team then continue end
        local sp,onS=Camera:WorldToViewportPoint(part.Position)
        if not onS then continue end
        local dist=(Vector2.new(sp.X,sp.Y)-mouse).Magnitude
        if dist>aimbotFOV then continue end
        if wallCheck then
            local rp=RaycastParams.new()
            rp.FilterDescendantsInstances={lc}; rp.FilterType=Enum.RaycastFilterType.Blacklist
            local r=workspace:Raycast(Camera.CFrame.Position,part.Position-Camera.CFrame.Position,rp)
            if r and not r.Instance:IsDescendantOf(char) then continue end
        end
        if dist<bd then bd=dist; best=part end
    end
    return best
end

-- ── HIT SOUND ────────────────────────────────────────────────
local hitSoundObj=Instance.new("Sound")
hitSoundObj.SoundId="rbxassetid://6042053130"
hitSoundObj.Volume=0.5; hitSoundObj.Parent=SoundService
local lastHit={}
local function checkHits()
    if not hitSound then return end
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        local char=player.Character; if not char then continue end
        local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then continue end
        local hp=hum.Health
        if lastHit[player] and hp<lastHit[player] and hp>0 then hitSoundObj:Play() end
        lastHit[player]=hp
    end
end

-- ── AIMBOT ───────────────────────────────────────────────────
local wasAiming=false
RunService.RenderStepped:Connect(function()
    fovCircle.Position=UserInputService:GetMouseLocation()
    fovCircle.Radius=aimbotFOV; fovCircle.Visible=aimbotToggle
    updateCrosshair()
    local rmbHeld=silentAim or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if wasAiming and (not aimbotToggle or not rmbHeld) then Camera.CameraType=Enum.CameraType.Custom; wasAiming=false end
    if not aimbotToggle or not rmbHeld then return end
    local part=getTarget(); if not part then return end
    Camera.CameraType=Enum.CameraType.Scriptable; wasAiming=true
    local targetCF=CFrame.new(Camera.CFrame.Position,part.Position)
    if aimShake then
        local shake=aimShakeAmt*0.001
        targetCF=targetCF*CFrame.Angles(math.random(-100,100)*shake,math.random(-100,100)*shake,0)
    end
    Camera.CFrame=Camera.CFrame:Lerp(targetCF,1-aimbotSmooth)
    local sp=Camera:WorldToViewportPoint(part.Position)
    local mp=UserInputService:GetMouseLocation()
    local delta=Vector2.new(sp.X,sp.Y)-mp
    if delta.Magnitude>50 then delta=delta.Unit*50 end
    if mousemoverel then mousemoverel(delta.X*(1-aimbotSmooth),delta.Y*(1-aimbotSmooth)) end
    if autoClick and mouse1click then mouse1click() end
end)

-- ── INF JUMP + BHOP ──────────────────────────────────────────
UserInputService.JumpRequest:Connect(function()
    if not infJump then return end
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.Heartbeat:Connect(function()
    if bHop and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local char=LocalPlayer.Character; if not char then return end
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState()==Enum.HumanoidStateType.Landed then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ── MAIN HEARTBEAT ───────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    hum.WalkSpeed=speedBoost and speedBoostVal or walkSpeed

    local parts={}
    if aimbotToggle then table.insert(parts,"aim") end
    if silentAim then table.insert(parts,"silent") end
    if killAura then table.insert(parts,"aura") end
    if godMode then table.insert(parts,"god") end
    if flyEnabled then table.insert(parts,"fly") end
    if hitboxExpander then table.insert(parts,"hitbox") end
    wmStatus.Text=#parts>0 and table.concat(parts,"  ·  ") or "idle"

    if godMode then hum.Health=hum.MaxHealth; hum.MaxHealth=math.huge end
    if noclipEnabled then
        for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end

    local hrp=char:FindFirstChild("HumanoidRootPart")
    if killAura and hrp then
        for _,player in ipairs(Players:GetPlayers()) do
            if player==LocalPlayer then continue end
            local ec=player.Character; if not ec then continue end
            local eh=ec:FindFirstChildOfClass("Humanoid")
            local er=ec:FindFirstChild("HumanoidRootPart")
            if not eh or not er or eh.Health<=0 then continue end
            if teamCheck and player.Team==LocalPlayer.Team then continue end
            if (hrp.Position-er.Position).Magnitude<=killAuraRange then
                pcall(function() eh:TakeDamage(math.huge) end)
            end
        end
    end

    local tool=char:FindFirstChildOfClass("Tool")
    if tool and infAmmo then
        for _,v in ipairs(tool:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n=v.Name:lower()
                if n=="ammo" or n=="currentammo" or n=="clip" or n=="magazine" or n=="bullets" then
                    pcall(function() v.Value=999 end)
                end
            end
        end
    end

    if rainbowEnabled and tool then
        rainbowHue=(rainbowHue+0.004)%1
        for _,p in ipairs(tool:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("MeshPart") then
                pcall(function() p.Color=Color3.fromHSV(rainbowHue,1,1) end)
            end
        end
    end

    checkHits()
end)

RunService.RenderStepped:Connect(function()
    if fullbright then
        local L=game:GetService("Lighting")
        L.Brightness=2; L.ClockTime=14; L.FogEnd=100000
        L.GlobalShadows=false; L.Ambient=Color3.fromRGB(255,255,255); L.OutdoorAmbient=Color3.fromRGB(255,255,255)
    end
    if customFOV then Camera.FieldOfView=customFOVVal end
end)

LocalPlayer.Idled:Connect(function()
    if not antiAFK then return end
    VirtualUser:Button2Down(Vector2.new(0,0),Camera.CFrame); task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Camera.CFrame)
end)

local function enableFly()
    local char=LocalPlayer.Character; if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end; hum.PlatformStand=true
    flyBodyVel=Instance.new("BodyVelocity")
    flyBodyVel.Velocity=Vector3.zero; flyBodyVel.MaxForce=Vector3.new(1e5,1e5,1e5); flyBodyVel.Parent=hrp
    flyBodyGyro=Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque=Vector3.new(1e5,1e5,1e5); flyBodyGyro.D=100; flyBodyGyro.CFrame=hrp.CFrame; flyBodyGyro.Parent=hrp
end
local function disableFly()
    local char=LocalPlayer.Character
    if char then local h=char:FindFirstChildOfClass("Humanoid"); if h then h.PlatformStand=false end end
    if flyBodyVel then flyBodyVel:Destroy(); flyBodyVel=nil end
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro=nil end
end
RunService.RenderStepped:Connect(function()
    if not flyEnabled or not flyBodyVel or not flyBodyGyro then return end
    local char=LocalPlayer.Character; if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local cf=Camera.CFrame; local vel=Vector3.zero; local k=UserInputService
    if k:IsKeyDown(Enum.KeyCode.W) then vel=vel+cf.LookVector end
    if k:IsKeyDown(Enum.KeyCode.S) then vel=vel-cf.LookVector end
    if k:IsKeyDown(Enum.KeyCode.A) then vel=vel-cf.RightVector end
    if k:IsKeyDown(Enum.KeyCode.D) then vel=vel+cf.RightVector end
    if k:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,1,0) end
    if k:IsKeyDown(Enum.KeyCode.LeftControl) then vel=vel-Vector3.new(0,1,0) end
    flyBodyVel.Velocity=vel*flySpeed; flyBodyGyro.CFrame=cf
end)

local function startAutoFarm()
    autoFarmConn=RunService.Heartbeat:Connect(function()
        if not autoFarm then return end
        local char=LocalPlayer.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for _,obj in ipairs(workspace:GetDescendants()) do
            if not autoFarm then break end
            pcall(function()
                local n=obj.Name:lower()
                if (obj:IsA("BasePart") or obj:IsA("MeshPart"))
                and (n:find("coin") or n:find("cash") or n:find("gem") or n:find("xp")
                or n:find("pickup") or n:find("orb") or n:find("drop") or n:find("collect")) then
                    if (hrp.Position-obj.Position).Magnitude<200 then
                        hrp.CFrame=CFrame.new(obj.Position); task.wait(0.05)
                    end
                end
            end)
        end
    end)
end
local function stopAutoFarm()
    if autoFarmConn then autoFarmConn:Disconnect(); autoFarmConn=nil end
end

-- ════════════════════════════════════════════════════════════
--  RAYFIELD UI
-- ════════════════════════════════════════════════════════════

local Rayfield=loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window=Rayfield:CreateWindow({
    Name             = "Rivals Hub  "..SCRIPT_VER,
    LoadingTitle     = "Rivals Hub",
    LoadingSubtitle  = "by traplixy gaming",
    Theme            = "Serenity",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = false,
    ConfigurationSaving    = {Enabled=true,FileName="RivalsHub"},
    Discord                = {Enabled=false},
    KeySystem              = false,
})

-- ── 🎯 AIMBOT ────────────────────────────────────────────────
local AimbotTab=Window:CreateTab("🎯  Aimbot",nil)
AimbotTab:CreateSection("— Core Settings —")
AimbotTab:CreateToggle({Name="Enable Aimbot",CurrentValue=false,Flag="AimbotOn",
    Callback=function(v) aimbotToggle=v; notify(v and "✅ Aimbot Enabled" or "❌ Aimbot Disabled",v and "Hold RMB to lock on." or "",v and "success" or "error") end})
AimbotTab:CreateToggle({Name="Silent Aim  (no RMB needed)",CurrentValue=false,Flag="SilentAim",
    Callback=function(v) silentAim=v; notify(v and "✅ Silent Aim ON" or "❌ Silent Aim OFF","",v and "success" or "error") end})
AimbotTab:CreateToggle({Name="Auto Click  (auto shoot on target)",CurrentValue=false,Flag="AutoClick",
    Callback=function(v) autoClick=v; notify(v and "✅ Auto Click ON" or "❌ Auto Click OFF","",v and "success" or "error") end})
AimbotTab:CreateToggle({Name="Aim Shake  (human-like movement)",CurrentValue=false,Flag="AimShake",
    Callback=function(v) aimShake=v end})
AimbotTab:CreateLabel("RMB = hold to aim  |  Silent = always on")
AimbotTab:CreateDivider()
AimbotTab:CreateSection("— Configuration —")
AimbotTab:CreateSlider({Name="FOV Radius",Range={20,500},Increment=10,Suffix=" px",CurrentValue=120,Flag="AimFOV",
    Callback=function(v) aimbotFOV=v end})
AimbotTab:CreateSlider({Name="Smoothness",Range={0,95},Increment=5,Suffix="%",CurrentValue=25,Flag="AimSmooth",
    Callback=function(v) aimbotSmooth=v/100 end})
AimbotTab:CreateSlider({Name="Aim Shake Amount",Range={1,10},Increment=1,CurrentValue=2,Flag="AimShakeAmt",
    Callback=function(v) aimShakeAmt=v end})
AimbotTab:CreateDropdown({Name="Target Hitbox",Options={"Head","HumanoidRootPart","UpperTorso","LowerTorso"},
    CurrentOption={"Head"},Flag="AimPart",
    Callback=function(v) aimAtPart=v[1]; notify("🎯 Hitbox","Targeting: "..v[1]) end})
AimbotTab:CreateDivider()
AimbotTab:CreateSection("— Filters —")
AimbotTab:CreateToggle({Name="Wall Check",CurrentValue=false,Flag="WallCheck",Callback=function(v) wallCheck=v end})
AimbotTab:CreateToggle({Name="Team Check",CurrentValue=false,Flag="TeamCheck",Callback=function(v) teamCheck=v end})

-- ── ⚔️ COMBAT ────────────────────────────────────────────────
local CombatTab=Window:CreateTab("⚔️  Combat",nil)
CombatTab:CreateSection("— Offense —")
CombatTab:CreateToggle({Name="🔴 Kill Aura",CurrentValue=false,Flag="KillAura",
    Callback=function(v) killAura=v; notify(v and "✅ Kill Aura ON" or "❌ Kill Aura OFF",v and "Damaging nearby enemies." or "",v and "success" or "error") end})
CombatTab:CreateSlider({Name="Aura Range",Range={5,100},Increment=5,Suffix=" studs",CurrentValue=15,Flag="KillAuraRange",
    Callback=function(v) killAuraRange=v end})
CombatTab:CreateToggle({Name="📦 Hitbox Expander",CurrentValue=false,Flag="HitboxExpander",
    Callback=function(v)
        hitboxExpander=v
        if not v then removeHitboxExpander() end
        notify(v and "✅ Hitbox Expander ON" or "❌ Hitbox Expander OFF",v and "Enemy hitboxes expanded." or "Hitboxes restored.",v and "success" or "error")
    end})
CombatTab:CreateSlider({Name="Hitbox Size",Range={1,20},Increment=1,Suffix=" studs",CurrentValue=5,Flag="HitboxSize",
    Callback=function(v)
        hitboxSize=v
        if hitboxExpander then removeHitboxExpander(); applyHitboxExpander() end
    end})
CombatTab:CreateToggle({Name="🔊 Hit Sound",CurrentValue=false,Flag="HitSound",
    Callback=function(v) hitSound=v; notify(v and "✅ Hit Sound ON" or "❌ Hit Sound OFF","",v and "success" or "error") end})
CombatTab:CreateDivider()
CombatTab:CreateSection("— Defense —")
CombatTab:CreateToggle({Name="🛡️ God Mode",CurrentValue=false,Flag="GodMode",
    Callback=function(v) godMode=v; notify(v and "✅ God Mode ON" or "❌ God Mode OFF",v and "You cannot die." or "",v and "success" or "error") end})
CombatTab:CreateDivider()
CombatTab:CreateSection("— Weapons —")
CombatTab:CreateToggle({Name="🔫 Infinite Ammo",CurrentValue=false,Flag="InfAmmo",
    Callback=function(v) infAmmo=v; notify(v and "✅ Inf Ammo ON" or "❌ Inf Ammo OFF",v and "Ammo locked to 999." or "",v and "success" or "error") end})

-- ── 👁️ ESP ───────────────────────────────────────────────────
local ESPTab=Window:CreateTab("👁️  ESP",nil)
ESPTab:CreateSection("— Visibility —")
ESPTab:CreateToggle({Name="Enable ESP",CurrentValue=false,Flag="ESPOn",Callback=function(v) ESP.Enabled=v end})
ESPTab:CreateToggle({Name="Boxes",CurrentValue=false,Flag="ESPBox",Callback=function(v) ESP.ShowBox=v end})
ESPTab:CreateToggle({Name="Names",CurrentValue=false,Flag="ESPName",Callback=function(v) ESP.ShowName=v end})
ESPTab:CreateToggle({Name="Health Bars",CurrentValue=false,Flag="ESPHealth",Callback=function(v) ESP.ShowHealth=v end})
ESPTab:CreateToggle({Name="Tracers",CurrentValue=false,Flag="ESPTracer",Callback=function(v) ESP.ShowTracer=v end})
ESPTab:CreateToggle({Name="Distance",CurrentValue=false,Flag="ESPDist",Callback=function(v) ESP.ShowDistance=v end})
ESPTab:CreateToggle({Name="Skeleton",CurrentValue=false,Flag="ESPSkel",Callback=function(v) ESP.ShowSkeletons=v end})
ESPTab:CreateToggle({Name="Team Check",CurrentValue=false,Flag="ESPTeam",Callback=function(v) ESP.TeamCheck=v end})
ESPTab:CreateDivider()
ESPTab:CreateSection("— Style —")
ESPTab:CreateDropdown({Name="Box Style",Options={"2D","Corner Box Esp"},CurrentOption={"2D"},Flag="ESPBoxType",
    Callback=function(v) ESP.BoxType=v[1] end})
ESPTab:CreateDropdown({Name="Tracer Origin",Options={"Bottom","Top","Middle"},CurrentOption={"Bottom"},Flag="ESPTracerPos",
    Callback=function(v) ESP.TracerPosition=v[1] end})
ESPTab:CreateDivider()
ESPTab:CreateSection("— Box Correction —")
ESPTab:CreateSlider({Name="Vertical Offset",Range={-80,80},Increment=2,Suffix=" px",CurrentValue=-20,Flag="ESPOffsetY",
    Callback=function(v) ESP_OFFSET_Y=v end})
ESPTab:CreateSlider({Name="Width Scale",Range={50,120},Increment=5,Suffix="%",CurrentValue=80,Flag="ESPScaleX",
    Callback=function(v) ESP_SCALE_X=v/100 end})
ESPTab:CreateSlider({Name="Height Scale",Range={50,120},Increment=5,Suffix="%",CurrentValue=85,Flag="ESPScaleY",
    Callback=function(v) ESP_SCALE_Y=v/100 end})

-- ── 🧍 PLAYER ────────────────────────────────────────────────
local PlayerTab=Window:CreateTab("🧍  Player",nil)
PlayerTab:CreateSection("— Movement —")
PlayerTab:CreateToggle({Name="Infinite Jump",CurrentValue=false,Flag="InfJump",
    Callback=function(v) infJump=v; notify(v and "✅ Inf Jump ON" or "❌ Inf Jump OFF","",v and "success" or "error") end})
PlayerTab:CreateToggle({Name="Bunny Hop  (hold Space)",CurrentValue=false,Flag="BHop",
    Callback=function(v) bHop=v; notify(v and "✅ BHop ON" or "❌ BHop OFF","",v and "success" or "error") end})
PlayerTab:CreateSlider({Name="Walk Speed",Range={16,250},Increment=2,Suffix=" stud/s",CurrentValue=16,Flag="WalkSpd",
    Callback=function(v) walkSpeed=v end})
PlayerTab:CreateToggle({Name="⚡ Speed Boost",CurrentValue=false,Flag="SpeedBoost",
    Callback=function(v) speedBoost=v; notify(v and "✅ Speed Boost ON" or "❌ Speed Boost OFF","",v and "success" or "error") end})
PlayerTab:CreateSlider({Name="Boost Speed",Range={20,500},Increment=10,Suffix=" stud/s",CurrentValue=50,Flag="SpeedBoostVal",
    Callback=function(v) speedBoostVal=v end})
PlayerTab:CreateToggle({Name="🕊️ Fly  (WASD + Space/Ctrl)",CurrentValue=false,Flag="FlyEnabled",
    Callback=function(v)
        flyEnabled=v
        if v then enableFly(); notify("✅ Fly ON","WASD=move  Space=up  Ctrl=down","success")
        else disableFly(); notify("❌ Fly OFF","","error") end
    end})
PlayerTab:CreateSlider({Name="Fly Speed",Range={10,200},Increment=10,Suffix=" stud/s",CurrentValue=50,Flag="FlySpeed",
    Callback=function(v) flySpeed=v end})
PlayerTab:CreateToggle({Name="Noclip",CurrentValue=false,Flag="Noclip",
    Callback=function(v) noclipEnabled=v; notify(v and "✅ Noclip ON" or "❌ Noclip OFF","",v and "success" or "error") end})
PlayerTab:CreateDivider()
PlayerTab:CreateSection("— Teleport —")
PlayerTab:CreateButton({Name="📍 Teleport to Spawn",
    Callback=function()
        local char=LocalPlayer.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart")
        local spawn=workspace:FindFirstChildOfClass("SpawnLocation")
        if hrp and spawn then hrp.CFrame=spawn.CFrame+Vector3.new(0,5,0); notify("📍 Teleported","Moved to spawn.","success")
        else notify("⚠️ Failed","No spawn found.","error") end
    end})
PlayerTab:CreateButton({Name="📍 Teleport to Nearest Player",
    Callback=function()
        local char=LocalPlayer.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local nearest,nd=nil,math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d=(hrp.Position-p.Character.HumanoidRootPart.Position).Magnitude
                if d<nd then nd=d; nearest=p end
            end
        end
        if nearest then hrp.CFrame=nearest.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0); notify("📍 Teleported","Moved to: "..nearest.Name,"success")
        else notify("⚠️ No Players","None found.","error") end
    end})
PlayerTab:CreateButton({Name="📍 Teleport to Random Player",
    Callback=function()
        local char=LocalPlayer.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local others={}
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(others,p) end
        end
        if #others==0 then notify("⚠️ No Players","None found.","error"); return end
        local t=others[math.random(1,#others)]
        hrp.CFrame=t.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0); notify("📍 Teleported","Moved to: "..t.Name,"success")
    end})

-- ── ⚙️ MISC ──────────────────────────────────────────────────
local MiscTab=Window:CreateTab("⚙️  Misc",nil)
MiscTab:CreateSection("— Visuals —")
MiscTab:CreateToggle({Name="Fullbright",CurrentValue=false,Flag="Fullbright",
    Callback=function(v) fullbright=v; notify(v and "✅ Fullbright ON" or "❌ Fullbright OFF","",v and "success" or "error") end})
MiscTab:CreateToggle({Name="🎯 Custom Crosshair",CurrentValue=false,Flag="Crosshair",
    Callback=function(v) showCrosshair=v; notify(v and "✅ Crosshair ON" or "❌ Crosshair OFF","",v and "success" or "error") end})
MiscTab:CreateSlider({Name="Crosshair Size",Range={2,20},Increment=1,CurrentValue=8,Flag="CrosshairSize",
    Callback=function(v) crosshairSize=v end})
MiscTab:CreateToggle({Name="🔭 Custom FOV",CurrentValue=false,Flag="CustomFOV",
    Callback=function(v) customFOV=v; if not v then Camera.FieldOfView=70 end
        notify(v and "✅ Custom FOV ON" or "❌ Custom FOV OFF","",v and "success" or "error") end})
MiscTab:CreateSlider({Name="FOV Value",Range={40,120},Increment=5,CurrentValue=70,Flag="CustomFOVVal",
    Callback=function(v) customFOVVal=v end})
MiscTab:CreateToggle({Name="🌈 Rainbow Gun",CurrentValue=false,Flag="Rainbow",
    Callback=function(v)
        rainbowEnabled=v
        if not v then
            local char=LocalPlayer.Character
            if char then
                local tool=char:FindFirstChildOfClass("Tool")
                if tool then
                    for _,p in ipairs(tool:GetDescendants()) do
                        if p:IsA("BasePart") or p:IsA("MeshPart") then
                            pcall(function() p.Color=Color3.fromRGB(163,162,165) end)
                        end
                    end
                end
            end
        end
    end})
MiscTab:CreateDivider()
MiscTab:CreateSection("— Farm —")
MiscTab:CreateToggle({Name="🌾 Auto Farm",CurrentValue=false,Flag="AutoFarm",
    Callback=function(v)
        autoFarm=v
        if v then startAutoFarm(); notify("✅ Auto Farm ON","Collecting nearby items.","success")
        else stopAutoFarm(); notify("❌ Auto Farm OFF","","error") end
    end})
MiscTab:CreateDivider()
MiscTab:CreateSection("— Utility —")
MiscTab:CreateToggle({Name="Anti-AFK",CurrentValue=false,Flag="AntiAFK",Callback=function(v) antiAFK=v end})
MiscTab:CreateButton({Name="🔄 Rejoin Server",
    Callback=function()
        notify("🔄 Rejoining","Teleporting to server...","success")
        task.wait(1); game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer)
    end})
MiscTab:CreateButton({Name="📋 Copy Username",
    Callback=function()
        if setclipboard then setclipboard(LocalPlayer.Name); notify("📋 Copied",LocalPlayer.Name,"success") end
    end})

-- ── ℹ️ INFO ───────────────────────────────────────────────────
local InfoTab=Window:CreateTab("ℹ️  Info",nil)
InfoTab:CreateSection("— Account —")
InfoTab:CreateLabel("User: ".._verifiedUser)
InfoTab:CreateLabel("Plan: ".._verifiedPlan)
InfoTab:CreateDivider()
InfoTab:CreateSection("— Credits —")
InfoTab:CreateLabel("Script by: traplixy gaming")
InfoTab:CreateLabel("UI: Rayfield by Sirius")
InfoTab:CreateLabel("All rights reserved — traplixy gaming")
InfoTab:CreateDivider()
InfoTab:CreateSection("— Features "..SCRIPT_VER.." —")
InfoTab:CreateLabel("🎯  Aimbot — RMB / Silent / Auto Click / Shake")
InfoTab:CreateLabel("⚔️  Combat — Kill Aura / Hitbox Expander / God Mode / Inf Ammo")
InfoTab:CreateLabel("👁️  ESP — Boxes / Names / Health / Tracers / Distance")
InfoTab:CreateLabel("🧍  Player — Jump / BHop / Speed / Fly / Noclip")
InfoTab:CreateLabel("📍  Teleport — Spawn / Nearest / Random")
InfoTab:CreateLabel("🎯  Crosshair / 🔭 Custom FOV / 🌈 Rainbow Gun")
InfoTab:CreateLabel("🌾  Auto Farm / 🔄 Rejoin / 📋 Copy Username")

notify("✅ Rivals Hub "..SCRIPT_VER.." Ready","Welcome, ".._verifiedUser.."!","success")
Rayfield:LoadConfiguration()
