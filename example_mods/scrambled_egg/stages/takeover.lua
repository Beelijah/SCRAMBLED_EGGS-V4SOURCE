--      v if your window is peeking out from the taskbar then make this value lower
local taskbarOffset = 50

local tylerX = 0
local tylerY = 0
local eggX = 0
local eggY = 0

local monitorWidth = getPropertyFromClass('openfl.Lib','application.window.stage.fullScreenWidth') or 1920 -- thank the vs sonic rewrite round 2 trinity scripter gods
local monitorHeight = getPropertyFromClass('openfl.Lib','application.window.stage.fullScreenHeight') or 1080

--monitorWidth = 1920
--monitorHeight = 1080

local oldX = 100
local oldY = 100

local easing = 'quartInOut'

local iconLoopa = 1
local deleteIconLoopa = 0
local iconSpeed = 5
local iconRevolutions = 2
local windowMovement = true

local windowSizeWidth = (8 / 9 * monitorHeight) * 1.333333333333333333333333333333 -- worst code
local windowSizeHeight = monitorHeight / 1.5

local centerWindowX = monitorWidth / 2 - windowSizeWidth / 2
local centerWindowY = monitorHeight / 2 - windowSizeHeight / 2

local powerX = 7.5
local powerY = 10

local windowX = 0
local windowY = 0

local fs, mx = false, false
local ffi = require("ffi")

function onCreate()
    tylerX = getProperty('dad.x')
    tylerY = getProperty('dad.y')
    eggX = getProperty('boyfriend.x')
    eggY = getProperty('boyfriend.y')

    if getTextFromFile('windowmovements.txt') == 'T' then
        windowMovement = false
    end
    if getTextFromFile('windowmovements.txt') == 'F' then
        windowMovement = true
    end

    setProperty('dadW.visible', false)
    setProperty('bfW.visible', false)

    --doTweenY('iconsMove1', 'bfW', 689, 1, easing)
    --doTweenY('iconsMove2', 'boyfriend', 274, 1, easing)
    --doTweenY('iconsMove3', 'dad', 226, 1, easing)
    --doTweenY('iconsMove4', 'dadW', 672, easing)

    --if buildTarget == 'windows' or buildTarget == 'windows_x86' then
    --    os.execute('start "" "' .. io.popen('cd'):read('*a'):gsub('[\n\r\t]', '') .. '\\mods\\scrambled_egg\\stages\\takeover\\takeover.bat"') -- run the batch script
    --end

    makeLuaSprite('wallpaper', 'takeoverCOLOR', -1000, -1000)
    scaleObject('wallpaper', 100, 100)
    setScrollFactor('wallpaper', 0, 0)
    setObjectOrder('wallpaper', getObjectOrder('bfW'))
    addLuaSprite('wallpaper')

    makeLuaSprite('obj', 'takeoverCOLOR', windowSizeWidth, windowSizeHeight)
    scaleObject('obj', 0.00001, 0.00001)
    addLuaSprite('obj')

    makeLuaSprite('obj2', 'takeoverCOLOR', centerWindowX, centerWindowY)
    scaleObject('obj2', 0.00001, 0.00001)
    addLuaSprite('obj2')

    setProperty('wallpaper.visible', false)
    setProperty('fire.visible', false)

    if windowMovement then
        setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
    end 

    --makeLuaSprite('wallpaperCOVER', '../stages/takeover/wallpapercover')
    --setObjectCamera('wallpaperCOVER')

    if windowMovement then
        setPropertyFromClass("openfl.Lib", "application.window.x", centerWindowX) -- door stuck
        setPropertyFromClass("openfl.Lib", "application.window.y", centerWindowY) -- unstuck
    end

    precacheImage('windows-icons/apps')
    setScrollFactor('bg', 1, 1)
end

function onEndSong()
    setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
end

function onStartCountdown()
    addHaxeLibrary('Lib', 'openfl')

    if not checkFileExists(modFolder .. '/data/hasSeenTakeoverWarning') then
        makeLuaSprite('black', '../images/black')
        setObjectCamera('black', 'hud')
        scaleObject('black', 6, 6)
        addLuaSprite('black')

        makeLuaSprite('blackWARNING', '../images/takeover/warning')
        setObjectCamera('blackWARNING', 'hud')
        scaleObject('blackWARNING', 1, 1)
        setProperty('blackWARNING.x', 400)
        setProperty('blackWARNING.y', 100)
        addLuaSprite('blackWARNING')

        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)
        setProperty('healthBar.visible', false)

        runTimer('warningTimer', 5)

        return Function_Stop;
    end
end

function onUpdate(elapsed)
    windowSizeWidth = getProperty('obj.x')
    windowSizeHeight = getProperty('obj.y')

    windowX = getProperty('obj2.x')
    windowY = getProperty('obj2.y')

    --debugPrint('CAMX: ' .. getCameraFollowX() .. ' CAMY: ' .. getCameraFollowY())
    --debugPrint('BFX: ' .. getProperty('boyfriend.x') .. ' BFY: ' .. getProperty('boyfriend.y'))
    --debugPrint('BFWX: ' .. getProperty('bfW.x') .. ' BFWY: ' .. getProperty('bfW.y'))
    --debugPrint('DADX: ' .. getProperty('dad.x') .. ' DADY: ' .. getProperty('dad.y'))
    --debugPrint('DADWX: ' .. getProperty('dadW.x') .. ' DADWY: ' .. getProperty('dadW.y'))
    --debugPrint(' ')

    if windowMovement then
        if getPropertyFromClass('openfl.Lib', 'application.window.fullscreen') then
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
        end

        if keyboardPressed('7') then
            setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
        end

        if keyboardPressed('ENTER') then
            setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
        end

        setPropertyFromClass("openfl.Lib", "application.window.width", getProperty('obj.x'))
        setPropertyFromClass("openfl.Lib", "application.window.height", getProperty('obj.y'))

        if curStep > 911 then
            setPropertyFromClass("openfl.Lib", "application.window.x", windowX)
            setPropertyFromClass("openfl.Lib", "application.window.y", windowY)
        end

        if curStep < 32 and curStep > 0 then
            setPropertyFromClass("openfl.Lib", "application.window.x", windowX)
            setPropertyFromClass("openfl.Lib", "application.window.y", windowY)

            setCameraFollowPoint(windowX - centerWindowX + cX, windowY - centerWindowY + cY)
            setProperty('cameraSpeed', 999)
        end
    end

    if curStep < 10 then
        noteTweenAlpha('hideHUDevent0', 0, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent1', 1, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent2', 2, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent3', 3, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent4', 4, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent5', 5, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent6', 6, 0, elapsed / 2, 'linear')
        noteTweenAlpha('hideHUDevent7', 7, 0, elapsed / 2, 'linear')

        doTweenAlpha('hideHUDevent8', 'healthBar', 0, elapsed / 2, 'linear')
        doTweenAlpha('hideHUDevent9', 'iconP1', 0, elapsed / 2, 'linear')
        doTweenAlpha('hideHUDevent10', 'iconP2', 0, elapsed / 2, 'linear')
        doTweenAlpha('hideHUDevent11', 'scoreTxt', 0, elapsed / 2, 'linear')
        doTweenAlpha('hideHUDevent12', 'timeTxt', 0, elapsed / 2, 'linear')
        doTweenAlpha('hideHUDevent13', 'timeBar', 0, elapsed / 2, 'linear')
    end

    if curStep > 928 then
        setCameraFollowPoint(563, 452)
    end

    if curStep > 790 and curStep < 928 then
        setCameraFollowPoint(-30, 550)
    end
end

function onSectionHit()
    if curStep > 790 then
        setProperty('cameraSpeed', 0.00005)
        if curStep < 928 then
            setCameraFollowPoint(-30, 550)
        else
            setCameraFollowPoint(563, 452)
        end
        setProperty('cameraSpeed', 1)
    elseif curStep > 31 then
        setProperty('cameraSpeed', 1)
    end
end

function onStepHit()
    if curStep == 8 - 2 then
        doTweenX('obj2x', 'obj2', getProperty('obj2.x') + monitorWidth / powerX * 2, crochet / 500, 'quartInOut')
    end

    if curStep == 16 - 2 then
        doTweenX('obj2x', 'obj2', getProperty('obj2.x') - monitorWidth / powerX, crochet / 650, 'quartInOut')
        doTweenY('obj2y', 'obj2', getProperty('obj2.y') - monitorHeight / powerY, crochet / 500, 'quartInOut')
    end

    if curStep == 24 - 2 then
        doTweenY('obj2y', 'obj2', getProperty('obj2.y') + monitorHeight / powerY * 2, crochet / 500, 'quartInOut')
    end

    if curStep == 30 then
        doTweenY('obj2y', 'obj2', centerWindowY, stepCrochet / 500, 'quartIn')
    end

    if curStep == 32 then
        setProperty('cameraSpeed', 1)
        setScrollFactor('bg', 0.7, 0.7)
    end

    if curStep == 893 then
        setProperty('fire.visible', true)
        if windowMovement then
            setPropertyFromClass("openfl.Lib", "application.window.borderless", true)
        end
    end

    if curStep == 896 then
        if windowMovement then
            setPropertyFromClass("openfl.Lib", "application.window.borderless", false)
        end
    end

    if curStep == 899 then
        if windowMovement then
            setPropertyFromClass("openfl.Lib", "application.window.borderless", true)
        end
    end

    if curStep == 912 then
        if windowMovement then
            setProperty('obj2.x', getPropertyFromClass("openfl.Lib", "application.window.x"))
            setProperty('obj2.y', getPropertyFromClass("openfl.Lib", "application.window.y"))

            oldX = getPropertyFromClass("openfl.Lib", "application.window.x")
            oldY = getPropertyFromClass("openfl.Lib", "application.window.y")
            
            doTweenX('windowWidthTween', 'obj', monitorWidth - 1, crochet / 450, 'quartInOut')
            doTweenY('windowHeightTween', 'obj', monitorHeight - 1 - taskbarOffset, crochet / 450, 'quartInOut')
            
            doTweenX('windowXTween', 'obj2', 0, crochet / 450, 'quartInOut')
            doTweenY('windowYTween', 'obj2', 0, crochet / 450, 'quartInOut')
        end
    end

    if curStep == 928 then
        triggerEvent('Lightning', '1', '2')
        triggerEvent('Change Character', 'Dad', 'tyler')

        setProperty('dadW.visible', true)
        setProperty('bfW.visible', true)

        doTweenY('iconsMove1', 'bfW', 689 - 150, 1, easing)
        doTweenY('iconsMove2', 'boyfriend', 274 - 150, 1, easing)
        doTweenY('iconsMove3', 'dad', 226 - 150, 1, easing)
        doTweenY('iconsMove4', 'dadW', 672 - 150, 1, easing)

        runTimer('iconSpawner', 1)

        removeLuaSprite('bgground')
        removeLuaSprite('bgtrees')
        removeLuaSprite('bg')
        
        removeLuaSprite('fgtrees')
        removeLuaSprite('fire')
        removeLuaSprite('fg')

        setProperty('boyfriend.antialiasing', false)
        setProperty('dad.antialiasing', false)
        setProperty('dadW.antialiasing', false)
        setProperty('bfW.antialiasing', false)
    end

    if curStep == 920 then
        setProperty('wallpaper.visible', true)
    end

    if curStep == 922 then
        setProperty('wallpaper.visible', false)
    end

    if curStep == 924 then
        setProperty('wallpaper.visible', true)

        if windowMovement then
            if buildTarget ~= 'windows' then
                ffi, fs, mx = nil, nil, nil
                return
            end
            ffi.cdef([[
                typedef void* HWND;
                typedef int BOOL;
                typedef unsigned char BYTE;
                typedef unsigned long DWORD;
                HWND GetActiveWindow();
                long SetWindowLongA(HWND hWnd, int nIndex, long dwNewLong);
                BOOL SetLayeredWindowAttributes(HWND hwnd, DWORD crKey, BYTE bAlpha, DWORD dwFlags);
            ]])
            local hwnd = ffi.C.GetActiveWindow()
            ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
            ffi.C.SetLayeredWindowAttributes(hwnd, 0x101010, 0, 0x00000001)
            fs = getPropertyFromClass('openfl.Lib', 'application.window.fullscreen')
            mx = getPropertyFromClass('openfl.Lib', 'application.window.maximized')
            runHaxeCode([[
                Lib.application.window.borderless = true;
                Lib.application.window.maximized = false;
                Lib.application.window.fullscreen = false;
            ]])
        end
    end

    if curStep == 1472 then
        ffi.C.SetWindowLongA(ffi.C.GetActiveWindow(), -20, 0x00000000)

        doTweenX('windowWidthTween', 'obj', (8 / 9 * monitorHeight) * 1.333333333333333333333333333333, crochet / 250, 'quartInOut')
        doTweenY('windowHeightTween', 'obj', monitorHeight / 1.5, crochet / 250, 'quartInOut')
        
        doTweenX('windowXTween', 'obj2', oldX, crochet / 250, 'quartInOut')
        doTweenY('windowYTween', 'obj2', oldY, crochet / 250, 'quartInOut')

        setPropertyFromClass("openfl.Lib", "application.window.borderless", false)
    end
end

function onSongStart()
    cX = getCameraFollowX()
    cY = getCameraFollowY()
    doTweenX('obj2x', 'obj2', getProperty('obj2.x') - monitorWidth / powerX, crochet / 500, 'quartInOut')
end

function onDestroy()
    if buildTarget == 'windows' then
        ffi.C.SetWindowLongA(ffi.C.GetActiveWindow(), -20, 0x00000000)
    end

    setPropertyFromClass("openfl.Lib", "application.window.borderless", false)
    setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'warningTimer' then
        saveFile(modFolder .. '/data/hasSeenTakeoverWarning', 'true')
        restartSong()
    end

    if tag == 'iconSpawner' then
        local iconIndexNum = getRandomInt(1, 8)
        local iconImage = 'Chrome'

        makeAnimatedLuaSprite('icon' .. iconLoopa, 'windows-icons/apps')

        if iconIndexNum == 1 then
            iconImage = 'Chrome'
            addAnimationByPrefix('icon' .. iconLoopa, 'Chrome', 'Chrome')
        elseif iconIndexNum == 2 then
            iconImage = 'Discord'
            addAnimationByPrefix('icon' .. iconLoopa, 'Discord', 'Discord')
        elseif iconIndexNum == 3 then
            iconImage = 'FNF'
            addAnimationByPrefix('icon' .. iconLoopa, 'FNF', 'FNF')
        elseif iconIndexNum == 4 then
            iconImage = 'Minecraft'
            addAnimationByPrefix('icon' .. iconLoopa, 'Minecraft', 'Minecraft')
        elseif iconIndexNum == 5 then
            iconImage = 'OBS'
            addAnimationByPrefix('icon' .. iconLoopa, 'OBS', 'OBS')
        elseif iconIndexNum == 6 then
            iconImage = 'Roblox'
            addAnimationByPrefix('icon' .. iconLoopa, 'Roblox', 'Roblox')
        elseif iconIndexNum == 7 then
            iconImage = 'Spotify'
            addAnimationByPrefix('icon' .. iconLoopa, 'Spotify', 'Spotify')
        elseif iconIndexNum == 8 then
            iconImage = 'Steam'
            addAnimationByPrefix('icon' .. iconLoopa, 'Steam', 'Steam')
        end

        playAnim('icon' .. iconLoopa, iconImage, true)
        addLuaSprite('icon' .. iconLoopa)
        setProperty('icon' .. iconLoopa .. '.x', -1100)
        setProperty('icon' .. iconLoopa .. '.antialiasing', false)
        setProperty('icon' .. iconLoopa .. '.y', getRandomInt(-300, 750))
        setObjectOrder('icon' .. iconLoopa, getObjectOrder('bfW'))
        doTweenX('iconMoveThingy' .. iconLoopa, 'icon' .. iconLoopa, 1900, iconSpeed)
        doTweenAngle('iconMoveThingyROTATE' .. iconLoopa, 'icon' .. iconLoopa, iconRevolutions * 360, iconSpeed)
        iconLoopa = iconLoopa + 1

        runTimer('iconSpawner', getRandomInt(1.01, 1.49))
        runTimer('iconDeleter', iconSpeed)
    end
end

function onTweenCompleted(tag, vars)
    local tagnamethingy = 'iconMoveThingy' .. deleteIconLoopa
    --debugPrint('TAG: ' .. tag)

    if tag == tagnamethingy then
        deleteIconLoopa = deleteIconLoopa + 1
        removeLuaSprite('icon' .. deleteIconLoopa)
    end

    if tag == 'iconsMove1' then
        doTweenY('iconsMove5', 'bfW', 689 - 50, 1, easing)
        doTweenY('iconsMove6', 'boyfriend', 274 - 50, 1, easing)
        doTweenY('iconsMove7', 'dad', 226 - 50, 1, easing)
        doTweenY('iconsMove8', 'dadW', 672 - 50, 1, easing)
    end
    if tag == 'iconsMove5' then
        doTweenY('iconsMove1', 'bfW', 689 - 150, 1, easing)
        doTweenY('iconsMove2', 'boyfriend', 274 - 150, 1, easing)
        doTweenY('iconsMove3', 'dad', 226 - 150, 1, easing)
        doTweenY('iconsMove4', 'dadW', 672 - 150, 1,  easing)
    end
end