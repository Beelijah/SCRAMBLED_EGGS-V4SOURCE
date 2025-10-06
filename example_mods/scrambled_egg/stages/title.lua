--[[        
            HEY READ THIS PRETTY PLEASE

            if you're here looking to
            edit things about the main
            menu, you should open the
            mainmenu.lua file instead.
            this script is meant for the
            situps cutscene before you go
            into the title screen.

            you can still edit those variables in the cutscene down there tho
]]
local introBuffer = 1 -- any value for the intro buffer in seconds (default is 1)
local totalChantTime = 10 -- when the cutscene should end after a specific amount of time

local shouldFinishClapping = false
local hasFanChantEnded = false
local formattedDate = os.date("%d/%m/%Y")

function onCreate() -- please do not delete these lines or this script.
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': VS scrambled eggs");

    if checkFileExists('hasFanChanted.txt') then
        if getTextFromFile('hasFanChanted.txt') == formattedDate then     
            hasFanChantEnded = true
            hasFinishedFanChant = true
            saveFile('hasFanChanted.txt', formattedDate)
            loadSong('mainmenu')
        else
            deleteFile('hasFanChanted.txt')
        end
    end

    setProperty('boyfriend.visible', false)
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)

    setProperty('healthBar.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('boyfriend.visible', false)

    makeAnimatedLuaSprite('roblox-friends', 'littledancingroblox', -175, 150)
    addAnimationByPrefix('roblox-friends', 'crowd1', 'crowd1', '1', true)
    addAnimationByPrefix('roblox-friends', 'crowd2', 'crowd2', '1', true)
    addAnimationByPrefix('roblox-friends', 'crowd3', 'crowd3', '1', true)
    setObjectOrder('roblox-friends', 5)
    setProperty('roblox-friends.visible', true)
    scaleObject('roblox-friends', 0.75, 0.75)
    addLuaSprite('roblox-friends')

    makeAnimatedLuaSprite('eahs-egg', 'egg-and-huy-situps', 425, 250)
    addAnimationByPrefix('eahs-egg', 'eggsitup1', 'eggsitup1', '5')
    addAnimationByPrefix('eahs-egg', 'eggsitup2', 'eggsitup2', '5')
    addAnimationByPrefix('eahs-egg', 'eggsitup3', 'eggsitup3', '5')
    addAnimationByPrefix('eahs-egg', 'egghandstand1', 'egghandstand1', '5')
    addAnimationByPrefix('eahs-egg', 'egghandstand2', 'egghandstand2', '5')
    addAnimationByPrefix('eahs-egg', 'egghandstand3', 'egghandstand3', '5')

    addOffset('eahs-egg', 'egghandstand1', -50, 100)
    addOffset('eahs-egg', 'egghandstand2', -50, 100)
    addOffset('eahs-egg', 'egghandstand3', -50, 100)

    setObjectOrder('eahs-egg', 5)
    setProperty('eahs-egg.visible', true)
    scaleObject('eahs-egg', 0.75, 0.75)
    addLuaSprite('eahs-egg')

    makeAnimatedLuaSprite('eahs-huy', 'egg-and-huy-situps', 250, 275)
    addAnimationByPrefix('eahs-huy', 'huy1-NEWER', 'huy1-NEWER', '5')
    addAnimationByPrefix('eahs-huy', 'huy2', 'huy2', '5')
    setObjectOrder('eahs-huy', 6)
    setProperty('eahs-huy.visible', true)
    scaleObject('eahs-huy', 0.75, 0.75)
    addLuaSprite('eahs-huy')

    makeLuaSprite('huy-ARM', 'huy1-arm', 250, 275)
    scaleObject('huy-ARM', 0.75, 0.75)
    setObjectOrder('huy-ARM', 5)
    addLuaSprite('huy-ARM')

    makeLuaSprite('titleIntroBG', 'titleBG', -450, 100)
    scaleObject('titleIntroBG', 1, 1)
    setObjectOrder('titleIntroBG', 4)
    addLuaSprite('titleIntroBG')

    makeLuaSprite('blackIntroCover', 'black', -500, 0)
    scaleObject('blackIntroCover', 50, 50)
    setObjectOrder('blackIntroCover', 50)
    addLuaSprite('blackIntroCover')

    makeLuaText('skipReminder', 'PRESS ANY KEY TO SKIP', 1280, 0, 500)
    setTextAlignment('skipReminder', 'center')
    setTextFont('skipReminder', 'vcr-lol.ttf')
    setTextSize('skipReminder', 64)

    if checkFileExists('hasFanChanted.txt') then
        if getTextFromFile('hasFanChanted.txt') ~= formattedDate then     
            addLuaText('skipReminder')
        end
    else
        addLuaText('skipReminder')
    end

    doTweenAlpha('skipReminder1', 'skipReminder', '0', '1')

    if introBuffer > 0 then
        runTimer('waitForCameraToMoveBeforeActuallyShowingItBecauseItDoesThatStupidZoomThingy', introBuffer)
    else
        setProperty('blackIntroCover.visible', false)
        onStartTitleDance()
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'skipReminder1' then
        doTweenAlpha('skipReminder2', 'skipReminder', '1', '1')
    end
    if tag == 'skipReminder2' then
        doTweenAlpha('skipReminder1', 'skipReminder', '0', '1')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'waitForCameraToMoveBeforeActuallyShowingItBecauseItDoesThatStupidZoomThingy' then
        doTweenAlpha('alphaIntroCoverTween1', 'blackIntroCover', 0, 1)
        onStartTitleDance()
    end

    if tag == 'totalChantTime' then
        shouldFinishClapping = true
        playAnim('roblox-friends', 'crowd3', true)
    end

    if tag == 'chantLoop1' then
        if not shouldFinishClapping then
            runTimer('chantLoop2', 0.52)

            playAnim('roblox-friends', 'crowd2', true)
        end
    end

    if tag == 'chantLoop2' then
        if not shouldFinishClapping then
            runTimer('chantLoop1', 0.52)

            playAnim('roblox-friends', 'crowd1', true)
        end
    end


    if tag == 'situpLoop2-1' then
        if not shouldFinishClapping then
            runTimer('situpLoop1', 0.52)

            playAnim('eahs-egg', 'eggsitup2')
        end
    end

    if tag == 'situpLoop1' then
        if not shouldFinishClapping then
            runTimer('situpLoop2', 0.52)

            playAnim('eahs-egg', 'eggsitup1')
        else
            playAnim('eahs-egg', 'egghandstand1')
            playAnim('eahs-huy', 'huy2')

            setProperty('huy-ARM.visible', false)
            runTimer('handstandwait1', 0.25)
        end
    end

    if tag == 'handstandwait1' then
            playAnim('eahs-egg', 'egghandstand2')

            runTimer('handstandwait2', 0.25)
    end

    if tag == 'handstandwait2' then
            playAnim('eahs-egg', 'egghandstand3')
    end

    if tag == 'situpLoop2' then
        if not shouldFinishClapping then
            runTimer('situpLoop3', 0.52)

            playAnim('eahs-egg', 'eggsitup2')
        end
    end

    if tag == 'situpLoop3' then
        if not shouldFinishClapping then
            runTimer('situpLoop2-1', 0.52)

            playAnim('eahs-egg', 'eggsitup3')
        end
    end

    if tag == 'totalTrueChantTime' then
        endFanChant()
    end
end

function onStartTitleDance()
    playSound('chant', 1, 'fan-chant', false)
    runTimer('totalChantTime', 5.6)
    runTimer('totalTrueChantTime', totalChantTime)
    runTimer('chantLoop1', 0.52)
    runTimer('situpLoop3', 0.52)

    playAnim('roblox-friends', 'clap1')
    playAnim('eahs-egg', 'eggsitup2')
end

function onUpdate(elapsed)
    if keyboardPressed('R') then
        restartSong()
    end

    if keyboardPressed('ANY') and not keyboardPressed('MINUS') and not keyboardPressed('PLUS') and not keyboardPressed('ZERO') then
        if not hasFanChantEnded then
            endFanChant()
        end
    end
end

function endFanChant()
    hasFanChantEnded = true
    hasFinishedFanChant = true
    saveFile('hasFanChanted.txt', formattedDate)
    loadSong('mainmenu')
end

function onStartCountdown()
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)

    setProperty('healthBar.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)

    setProperty('botplayTxt.visible', false) -- ruins the illusion of this actually being a song,
    setProperty('botplayTxt.y', -500)        -- not a main menu.

    return Function_Stop;
end

function onSongStart()
    noteTweenAlpha('hideHUDthingyaaa0', 0, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa1', 1, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa2', 2, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa3', 3, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa4', 4, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa5', 5, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa6', 6, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa7', 7, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')

end

function onEndSong()
    return Function_Stop;
end