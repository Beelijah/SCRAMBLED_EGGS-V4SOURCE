local everyOtherBeat = false
local hasFadedEye = false
local secondsElapsed = 0

--   vcr-lol.ttf

function onEndSong()
    unlockAchievement('hasBeatModdingLand')
end

function onUpdate(elapsed)
    if curStep > 447 then
        setProperty('border.visible', false)
        setProperty('floor.visible', false)
        setProperty('bg2.visible', false)
        setProperty('bg.visible', false)

        setProperty('eye.visible', false)

        setProperty('EVILfloor.visible', true)
        setProperty('EVILbg2.visible', true)
        setProperty('EVILbg.visible', true)
    elseif curStep < 448 then
        setProperty('border.visible', true)
        setProperty('floor.visible', true)
        setProperty('bg2.visible', true)
        setProperty('bg.visible', true)

        setProperty('EVILfloor.visible', false)
        setProperty('EVILbg2.visible', false)
        setProperty('EVILbg.visible', false)
    end

    if curStep > 1503 then
        triggerEvent('Add Camera Zoom', '5', '5')

        setProperty('border.visible', false)
        setProperty('floor.visible', false)
        setProperty('bg2.visible', false)
        setProperty('bg.visible', false)
        setProperty('EVILfloor.visible', false)
        setProperty('EVILbg2.visible', false)
        setProperty('EVILbg.visible', false)

        setProperty('dad.visible', false)
        setProperty('boyfriend.visible', false)
    end

    if curStep == 432 then
        if not hasFadedEye then
            --debugPrint('                ' .. getCameraFollowX() .. '               ' .. getCameraFollowY())
            hasFadedEye = true

            doTweenAlpha('EyeFade', 'eye', 1, 1.4, 'quartOut')

            setProperty('camZooming', false)
            doTweenZoom('camZoomStart', 'game', 1.5, 1.4, 'quartOut')
        end
    end
end

function onSongStart()
    secondsElapsed = 1
    runTimer('addSeconds')
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'addSeconds' then
        secondsElapsed = secondsElapsed + 1
        runTimer('addSeconds')
    end
end

function onCreate()
    local curEyeX = getProperty('eye.x')
    local curEyeY = getProperty('eye.y')
    doTweenAlpha('EyeFadeOut', 'eye', 0, 0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'quartOut')

    setProperty('eye.x', curEyeX - 28)
    setProperty('eye.y', curEyeY + 15)
end

function onBeatHit()
    --debugPrint(everyOtherBeat)

    if everyOtherBeat then
        everyOtherBeat = false

        if curStep > 447 then
            triggerEvent('Add Camera Zoom', '0.015', '0.03')
        end
    elseif not everyOtherBeat then
        everyOtherBeat = true
    end
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if not isSustain then 
        if curStep > 751 and curStep < 783 then
            triggerEvent('Add Camera Zoom', '0.008', '0.015')
        end
    end
end