local paranoiaFxEnabled = false -- this code was ai generated, every other script in v3 and all scripts in v4 are not.
local WindowDance = false
local SineElap = 0
local initialWindowX = 0
local initialWindowY = 0
local DESIRED_WINDOW_WIDTH = 1280
local DESIRED_WINDOW_HEIGHT = 720

local shouldHideHUD = true
local introTime = 1
local shouldDoCountdown = false
local hasFixes = true -- fixes code is not ai generated
-- looking through this ai code makes me want to throw up, for every 1 line of real code
-- has like 10 of just random garbage that it does for genuinely no reason

local actualMonitorWidth = 0
local actualMonitorHeight = 0

local DEFAULT_OPPONENT_CAMERA_X = -287
local DEFAULT_OPPONENT_CAMERA_Y = 136
local DEFAULT_BF_CAMERA_X = 485
local DEFAULT_BF_CAMERA_Y = 155.5

local currentDanceOffsetX_Multiplier = 1000
local currentDanceOffsetY_Multiplier = 1000

local CAMERA_MOVEMENT_DATA = {
    {start_step = 0, end_step = 31, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 32, end_step = 63, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 64, end_step = 95, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 96, end_step = 127, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 128, end_step = 159, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 160, end_step = 191, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 192, end_step = 255, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 256, end_step = 319, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 320, end_step = 323, target_follow_x = -397, target_follow_y = 246, normal_context = "opponent"},
    {start_step = 324, end_step = 327, target_follow_x = -177, target_follow_y = 26, normal_context = "opponent"},
    {start_step = 328, end_step = 331, target_follow_x = -177, target_follow_y = 136, normal_context = "opponent"},
    {start_step = 332, end_step = 335, target_follow_x = -397, target_follow_y = 136, normal_context = "opponent"},
    {start_step = 336, end_step = 383, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 384, end_step = 391, target_follow_x = 335, target_follow_y = 55.5, normal_context = "bf"},
    {start_step = 392, end_step = 399, target_follow_x = 735, target_follow_y = 255.5, normal_context = "bf"},
    {start_step = 400, end_step = 447, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 448, end_step = 511, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 512, end_step = 575, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 576, end_step = 639, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 640, end_step = 703, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 704, end_step = 767, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 768, end_step = 831, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 832, end_step = 895, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 896, end_step = 975, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 976, end_step = 991, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 992, end_step = 995, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 996, end_step = 999, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1000, end_step = 1003, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1004, end_step = 1007, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1008, end_step = 1009, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1010, end_step = 1011, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1012, end_step = 1013, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1014, end_step = 1015, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1016, end_step = 1016, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1017, end_step = 1017, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1018, end_step = 1018, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1019, end_step = 1019, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1020, end_step = 1020, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1021, end_step = 1021, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1022, end_step = 1022, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1023, end_step = 1103, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1104, end_step = 1167, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1168, end_step = 1231, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1232, end_step = 1295, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1296, end_step = 1311, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1232, end_step = 1327, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1296, end_step = 1343, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1344, end_step = 1359, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1360, end_step = 1423, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1424, end_step = 1487, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1488, end_step = 1679, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1680, end_step = 1759, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1760, end_step = 1823, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1824, end_step = 1887, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 1888, end_step = 1951, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 1952, end_step = 2015, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 2016, end_step = 2047, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 2048, end_step = 2061, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 2062, end_step = 2111, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 2112, end_step = 2143, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},
    {start_step = 2144, end_step = 2175, target_follow_x = DEFAULT_OPPONENT_CAMERA_X, target_follow_y = DEFAULT_OPPONENT_CAMERA_Y, normal_context = "opponent"},
    {start_step = 2176, end_step = 2242, target_follow_x = DEFAULT_BF_CAMERA_X, target_follow_y = DEFAULT_BF_CAMERA_Y, normal_context = "bf"},

}

local isInBorderlessFullscreen = false

function onEndSong()
end

function onCreatePost()
    setProperty('healthBar.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('scoreTxt.alpha', 0)
end

function onCreate()
    local sickPath

    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end
        
    setProperty('black.visible', false)
    setProperty('headBg.visible', false)

    if getTextFromFile('windowmovements.txt') == 'T' then
        paranoiaFxEnabled = false
    end

    if getTextFromFile('windowmovements.txt') == 'F' then
        paranoiaFxEnabled = true
    end

    sickPath = getProperty('ratingsData[0].image')
    print('is paranoia fx enabled? ' .. tostring(paranoiaFxEnabled))
    print('ui path for sick: ' .. sickPath)
    setPropertyFromClass("openfl.Lib", "application.window.resizable", true)

    if not hasFixes then
        actualMonitorWidth = (getPropertyFromClass('openfl.Lib', 'application.window.display.width') or 1920)
        actualMonitorHeight = (getPropertyFromClass('openfl.Lib', 'application.window.display.height') or 1080)
    else
        actualMonitorWidth = getPropertyFromClass('openfl.Lib','application.window.stage.fullScreenWidth') -- thank the vs sonic rewrite round 2 trinity scripter gods
        actualMonitorHeight = getPropertyFromClass('openfl.Lib','application.window.stage.fullScreenHeight')
    end

    if actualMonitorWidth == 0 then actualMonitorWidth = 1920 end
    if actualMonitorHeight == 0 then actualMonitorHeight = 1080 end

    initialWindowX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
    initialWindowY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))

    setPropertyFromClass('openfl.Lib', 'application.window.x', initialWindowX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', initialWindowY)
end

function onStartCountdown()
    setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    isInBorderlessFullscreen = false

    local startX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
    local startY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))
    
    setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(DESIRED_WINDOW_WIDTH))
    setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(DESIRED_WINDOW_HEIGHT))
    setPropertyFromClass('openfl.Lib', 'application.window.x', startX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', startY)
    
    if hasFixes then
        if not shouldDoCountdown then
            introThingy()
            return Function_Stop;
        else
            runTimer('waitToHideTheFreakingHudYo', 0.001)
        end
    else
        return Function_Continue -- i dont understand
    end
end

function introThingy() -- no need for hasFixes here as it is already activated on this condition
    setProperty('skipCountdown', true)

    playSound('paranoiaIntro')
    shouldDoCountdown = true
    
    runTimer('paranoiaIntroWait', introTime)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'paranoiaIntroWait' then
        startCountdown()
    end

    if tag == 'waitToHideTheFreakingHudYo' then
        shouldHideHUD = false
    end
end

function onStepHit()
    local curStep = getProperty('curStep') -- i dont understand
    local DANCE_SEGMENTS = {
        {start = 336, ending = 384},
        {start = 400, ending = 448}
    }
    local shouldDanceThisStep = false

    for _, segment in ipairs(DANCE_SEGMENTS) do
        if curStep >= segment.start and curStep <= segment.ending then
            shouldDanceThisStep = true
            break
        end
    end
    if shouldDanceThisStep then
        if not WindowDance then
            WindowDance = true
        end
    else
        if WindowDance then
            WindowDance = false
        end
    end

    if curStep == 0 and not WindowDance then -- i dont understand
    end
end

function onUpdate(elapsed)
    local curStep = getProperty('curStep')
    local isCurrentlyMaximized = getPropertyFromClass('openfl.Lib', 'application.window.maximized')

    if shouldHideHUD then
        if hasFixes then
            noteTweenAlpha('hideHUDevent0', 0, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent1', 1, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent2', 2, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent3', 3, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent4', 4, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent5', 5, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent6', 6, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent7', 7, 0, elapsed / 1.01, 'linear')

            doTweenAlpha('hideHUDevent8', 'healthBar', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent9', 'iconP1', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent10', 'iconP2', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent11', 'scoreTxt', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent12', 'timeTxt', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent13', 'timeBar', 0, elapsed / 1.01, 'linear')
        end
    end

    if hasFixes then
        if getPropertyFromClass('openfl.Lib', 'application.window.fullscreen') then
            setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', false)
        end
    end

    if paranoiaFxEnabled and isCurrentlyMaximized and not isInBorderlessFullscreen then
        setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
        local tempInitialX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
        local tempInitialY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))
        setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(DESIRED_WINDOW_WIDTH))
        setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(DESIRED_WINDOW_HEIGHT))
        setPropertyFromClass('openfl.Lib', 'application.window.x', tempInitialX)
        setPropertyFromClass('openfl.Lib', 'application.window.y', tempInitialY)
    end

    local targetWindowX = initialWindowX
    local targetWindowY = initialWindowY
    local targetWindowWidth = DESIRED_WINDOW_WIDTH
    local targetWindowHeight = DESIRED_WINDOW_HEIGHT

    local currentSegmentData = nil

    SineElap = SineElap + (elapsed * 3)

    for _, data in ipairs(CAMERA_MOVEMENT_DATA) do
        if curStep >= data.start_step and curStep <= data.end_step then
            currentSegmentData = data
            break
        end
    end

    if curStep >= 1296 and curStep <= 2242 then
        currentDanceOffsetX_Multiplier = 200
        currentDanceOffsetY_Multiplier = 50
    else
        currentDanceOffsetX_Multiplier = 1000
        currentDanceOffsetY_Multiplier = 1000
    end

    local danceOffsetX = currentDanceOffsetX_Multiplier * math.cos(SineElap) / 5
    local danceOffsetY = currentDanceOffsetY_Multiplier * math.sin(SineElap) / 10

    if paranoiaFxEnabled then
        if curStep >= 1024 and curStep < 1296 then
            if not isInBorderlessFullscreen then
                setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
                setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
                isInBorderlessFullscreen = true
            end
            targetWindowWidth = actualMonitorWidth
            targetWindowHeight = actualMonitorHeight
            targetWindowX = 0
            targetWindowY = 0
        else
            if isInBorderlessFullscreen then
                setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
                isInBorderlessFullscreen = false
                local tempInitialX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
                local tempInitialY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))
                setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(DESIRED_WINDOW_WIDTH))
                setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(DESIRED_WINDOW_HEIGHT))
                setPropertyFromClass('openfl.Lib', 'application.window.x', tempInitialX)
                setPropertyFromClass('openfl.Lib', 'application.window.y', tempInitialY)
            end

            if curStep >= 1008 and curStep < 1024 then
                local startStep = 1008
                local endStep = 1023
                local progress = (curStep - startStep) / (endStep - startStep)

                progress = math.max(0, math.min(1, progress))

                targetWindowWidth = DESIRED_WINDOW_WIDTH + (actualMonitorWidth - DESIRED_WINDOW_WIDTH) * progress
                targetWindowHeight = DESIRED_WINDOW_HEIGHT + (actualMonitorHeight - DESIRED_WINDOW_HEIGHT) * progress

                targetWindowX = math.floor((actualMonitorWidth / 2) - (targetWindowWidth / 2))
                targetWindowY = math.floor((actualMonitorHeight / 2) - (targetWindowHeight / 2))

            elseif curStep >= 1296 and curStep < 1304 then
                local startStep = 1296
                local endStep = 1303
                local progress = (curStep - startStep) / (endStep - startStep)

                progress = math.max(0, math.min(1, progress))

                targetWindowWidth = (actualMonitorWidth - 1) + (DESIRED_WINDOW_WIDTH - (actualMonitorWidth - 1)) * progress
                targetWindowHeight = (actualMonitorHeight - 1) + (DESIRED_WINDOW_HEIGHT - (actualMonitorHeight - 1)) * progress

                targetWindowX = 0 + (initialWindowX - 0) * progress
                targetWindowY = 0 + (initialWindowY - 0) * progress

            elseif curStep >= 1304 and curStep <= 2242 then
                targetWindowWidth = DESIRED_WINDOW_WIDTH
                targetWindowHeight = DESIRED_WINDOW_HEIGHT
                targetWindowX = initialWindowX + danceOffsetX
                targetWindowY = initialWindowY + danceOffsetY

            elseif curStep > 2242 then
                targetWindowWidth = DESIRED_WINDOW_WIDTH
                targetWindowHeight = DESIRED_WINDOW_HEIGHT
                targetWindowX = initialWindowX
                targetWindowY = initialWindowY

            elseif WindowDance then
                targetWindowX = initialWindowX + danceOffsetX
                targetWindowY = initialWindowY + danceOffsetY

            elseif currentSegmentData ~= nil then
                local currentCameraNormalX
                local currentCameraNormalY
                if currentSegmentData.normal_context == "opponent" then
                    currentCameraNormalX = DEFAULT_OPPONENT_CAMERA_X
                    currentCameraNormalY = DEFAULT_OPPONENT_CAMERA_Y
                else
                    currentCameraNormalX = DEFAULT_BF_CAMERA_X
                    currentCameraNormalY = DEFAULT_BF_CAMERA_Y
                end

                local offset_x = currentSegmentData.target_follow_x - currentCameraNormalX
                local offset_y = currentSegmentData.target_follow_y - currentCameraNormalY
                targetWindowX = initialWindowX + offset_x
                targetWindowY = initialWindowY + offset_y
            else
                targetWindowX = initialWindowX
                targetWindowY = initialWindowY
            end
        end

        setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(targetWindowWidth))
        setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(targetWindowHeight))
        setPropertyFromClass('openfl.Lib', 'application.window.x', math.floor(targetWindowX))
        setPropertyFromClass('openfl.Lib', 'application.window.y', math.floor(targetWindowY))
        
        if curStep >= 1024 and curStep <= 1039 then
            setProperty('black.visible', true)
        else
            setProperty('black.visible', false)
        end

        if curStep >= 1296 and curStep <= 9999 then
            setProperty('headBg.visible', true)
        else
            setProperty('headBg.visible', false)
        end


        if curStep == 1040 then
            setPropertyFromClass("openfl.Lib", "application.window.title", "IM IN YOUR HEAD");
        end

        if curStep == 2242 then
            setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': VS scrambled eggs");
        end

    else
        setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
        setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
        isInBorderlessFullscreen = false
        setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(DESIRED_WINDOW_WIDTH))
        setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(DESIRED_WINDOW_HEIGHT))
        local defaultCenterX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
        local defaultCenterY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))
        setPropertyFromClass('openfl.Lib', 'application.window.x', defaultCenterX)
        setPropertyFromClass('openfl.Lib', 'application.window.y', defaultCenterY)
    end

    local camFollowX
    local camFollowY

    if currentSegmentData ~= nil then
        camFollowX = currentSegmentData.target_follow_x
        camFollowY = currentSegmentData.target_follow_y
    else
        camFollowX = DEFAULT_OPPONENT_CAMERA_X
        camFollowY = DEFAULT_OPPONENT_CAMERA_Y
    end

    if WindowDance or (curStep >= 1296 and curStep <= 2242) then
        camFollowX = camFollowX + danceOffsetX
        camFollowY = camFollowY + danceOffsetY
    end
    setCameraFollowPoint(camFollowX, camFollowY)

end

function onGameOver()
    WindowDance = false
    SineElap = 0
    setProperty('black.visible', false)
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine");

    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
    isInBorderlessFullscreen = false
    setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(DESIRED_WINDOW_WIDTH))
    setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(DESIRED_WINDOW_HEIGHT))
    local defaultCenterX = math.floor((actualMonitorWidth / 2) - (DESIRED_WINDOW_WIDTH / 2))
    local defaultCenterY = math.floor((actualMonitorHeight / 2) - (DESIRED_WINDOW_HEIGHT / 2))
    setPropertyFromClass('openfl.Lib', 'application.window.x', defaultCenterX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', defaultCenterY)
end