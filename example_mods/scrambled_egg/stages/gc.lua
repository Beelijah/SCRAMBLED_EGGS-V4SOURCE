function onCreate() -- please do not delete these lines or this script.
    triggerEvent('updateRPC', 'roaming the menus - gameplay changers', false)
    
    setProperty('skipCountdown', true)
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': VS scrambled eggs");

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
end

function onUpdate(elapsed)
    if keyboardPressed('BACKSPACE') or keyboardPressed('ESCAPE') then
        runTimer('waitToSave', 0.1)
    end

    if keyboardPressed('R') then
        restartSong()
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'waitToSave' then
        loadSong('mainmenu')
    end
end

function onPause()
    return Function_Stop;
end

function onGameOver()
    return Function_Stop;
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
end

function onSongStart()
    triggerEvent('Open Gameplay Changers Menu')
    playMusic('amalgam-undertale', 1.25, true)
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