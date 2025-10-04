local tylerX = 0
local tylerY = 0
local eggX = 0
local eggY = 0

local easing = 'quartInOut'

local iconLoopa = 1
local deleteIconLoopa = 0
local iconSpeed = 5
local iconRevolutions = 2

function onCreate()
    tylerX = getProperty('dad.x')
    tylerY = getProperty('dad.y')
    eggX = getProperty('boyfriend.x')
    eggY = getProperty('boyfriend.y')

    setProperty('dadW.visible', false)
    setProperty('bfW.visible', false)

    --doTweenY('iconsMove1', 'bfW', 689, 1, easing)
    --doTweenY('iconsMove2', 'boyfriend', 274, 1, easing)
    --doTweenY('iconsMove3', 'dad', 226, 1, easing)
    --doTweenY('iconsMove4', 'dadW', 672, easing)

    os.execute('start "" "' .. io.popen('cd'):read('*a'):gsub('[\n\r\t]', '') .. '\\mods\\scrambled_egg\\stages\\takeover\\takeover.bat"') -- run the batch script

    makeLuaSprite('wallpaper', '../stages/takeover/wallpaper', -650, -365)
    setObjectCamera('wallpaper')
    scaleObject('wallpaper', 1.35, 1.35)
    setScrollFactor('wallpaper', 0, 0)
    setObjectOrder('wallpaper', getObjectOrder('bfW'))
    addLuaSprite('wallpaper')

    setProperty('wallpaper.visible', false)
    setProperty('fire.visible', false)

    if getModSetting('takeoverFxEnabled') then
        setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
    end 

    --makeLuaSprite('wallpaperCOVER', '../stages/takeover/wallpapercover')
    --setObjectCamera('wallpaperCOVER')
end

function onPause()
    if getModSetting('takeoverFxEnabled') then
        setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
        setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
    end
end

function onResume()
    if getModSetting('takeoverFxEnabled') then
        setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
        if curStep > 928 then
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", true)
        else
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
        end
    else
        setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
    end
end

function onEndSong()
    setPropertyFromClass("openfl.Lib", "application.window.resizable", true)

    if getModSetting('takeoverFxEnabled') then
        setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
    end
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
    
    if getModSetting('takeoverFxEnabled') then
        setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
   end
end

function onStartCountdown()
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
    --debugPrint('CAMX: ' .. getCameraFollowX() .. ' CAMY: ' .. getCameraFollowY())
    --debugPrint('BFX: ' .. getProperty('boyfriend.x') .. ' BFY: ' .. getProperty('boyfriend.y'))
    --debugPrint('BFWX: ' .. getProperty('bfW.x') .. ' BFWY: ' .. getProperty('bfW.y'))
    --debugPrint('DADX: ' .. getProperty('dad.x') .. ' DADY: ' .. getProperty('dad.y'))
    --debugPrint('DADWX: ' .. getProperty('dadW.x') .. ' DADWY: ' .. getProperty('dadW.y'))
    --debugPrint(' ')

    if getModSetting('takeoverFxEnabled') then
        if keyboardPressed('7') then
            setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
        end

        if keyboardPressed('ENTER') then
            setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
        end

        if curStep < 927 then
            if getModSetting('takeoverFxEnabled') then
                setPropertyFromClass("openfl.Lib", "application.window.width", 1280)
                setPropertyFromClass("openfl.Lib", "application.window.height", 720)
            end
        end
    end

    if curStep > 928 then
        setCameraFollowPoint(563, 452)
    end
    if curStep > 790 and curStep < 928 then
        setCameraFollowPoint(-30, 550)
    end
end

function onStepHit()
    if curStep == 893 then
        setProperty('fire.visible', true)
    end

    if curStep == 928 then
        setProperty('fire.visible', false)
        triggerEvent('Lightning', '1', '2')
        triggerEvent('Change Character', 'Dad', 'tyler')
      --addLuaSprite('wallpaperCOVER')

        setProperty('dadW.visible', true)
        setProperty('bfW.visible', true)

        setProperty('wallpaper.visible', true)

        doTweenY('iconsMove1', 'bfW', 689 - 150, 1, easing)
        doTweenY('iconsMove2', 'boyfriend', 274 - 150, 1, easing)
        doTweenY('iconsMove3', 'dad', 226 - 150, 1, easing)
        doTweenY('iconsMove4', 'dadW', 672 - 150, 1, easing)

        runTimer('iconSpawner', 1)

        if getModSetting('takeoverFxEnabled') then
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", true)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'warningTimer' then
        saveFile(modFolder .. '/data/hasSeenTakeoverWarning', 'true')
        restartSong()
    end

    if tag == 'iconSpawner' then
        local iconIndexNum = getRandomInt(1, 8)
        local iconImage = 'Chrome'

        if iconIndexNum == 1 then
            iconImage = 'Chrome'
        elseif iconIndexNum == 2 then
            iconImage = 'Discord'
        elseif iconIndexNum == 3 then
            iconImage = 'FNF'
        elseif iconIndexNum == 4 then
            iconImage = 'Minecraft'
        elseif iconIndexNum == 5 then
            iconImage = 'OBS'
        elseif iconIndexNum == 6 then
            iconImage = 'Roblox'
        elseif iconIndexNum == 7 then
            iconImage = 'Spotify'
        elseif iconIndexNum == 8 then
            iconImage = 'Steam'
        end

        makeAnimatedLuaSprite('icon' .. iconLoopa, 'windows-icons/apps')

        addAnimationByPrefix('icon' .. iconLoopa, 'Chrome', 'Chrome')
        addAnimationByPrefix('icon' .. iconLoopa, 'Discord', 'Discord')
        addAnimationByPrefix('icon' .. iconLoopa, 'FNF', 'FNF')
        addAnimationByPrefix('icon' .. iconLoopa, 'Minecraft', 'Minecraft')
        addAnimationByPrefix('icon' .. iconLoopa, 'OBS', 'OBS')
        addAnimationByPrefix('icon' .. iconLoopa, 'Roblox', 'Roblox')
        addAnimationByPrefix('icon' .. iconLoopa, 'Spotify', 'Spotify')
        addAnimationByPrefix('icon' .. iconLoopa, 'Steam', 'Steam')

        playAnim('icon' .. iconLoopa, iconImage, true)
        addLuaSprite('icon' .. iconLoopa)
        setProperty('icon' .. iconLoopa .. '.x', -1100)
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