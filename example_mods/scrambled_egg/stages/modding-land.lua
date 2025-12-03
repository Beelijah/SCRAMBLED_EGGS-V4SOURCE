local everyOtherBeat = false
local hasFadedEye = false
local secondsElapsed = 0
local fps = 0.0000000000015
local hasFixes = true

function onEndSong()
    --unlockAchievement('hasBeatModdingLand')
end

function onUpdate(elapsed)
    fps = elapsed

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

function onCreatePost()
    if hasFixes then
        noteTweenX('middlescroll', 4, 412, fps / 1.01, 'linear')
        noteTweenX('middlescrolm', 5, 524, fps / 1.01, 'linear')
        noteTweenX('middlescroln', 6, 636, fps / 1.01, 'linear')
        noteTweenX('middlescrolo', 7, 748, fps / 1.01, 'linear')

        noteTweenX('hideHUDevent0-2', 0, -500, fps / 1.01, 'linear')
        noteTweenX('hideHUDevent1-2', 1, -500, fps / 1.01, 'linear')
        noteTweenX('hideHUDevent2-2', 2, -500, fps / 1.01, 'linear')
        noteTweenX('hideHUDevent3-2', 3, -500, fps / 1.01, 'linear')

        triggerEvent('Change Character', 'BF', 'redguy-new-pixel')
    end
end

function onCreate()
    local curEyeX = getProperty('eye.x')
    local curEyeY = getProperty('eye.y')

    if hasFixes then
        setProperty('eye.alpha', 0)
    else
        doTweenAlpha('EyeFadeOut', 'eye', 0, 0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'quartOut') -- bro
    end

    setProperty('eye.x', curEyeX - 28)
    setProperty('eye.y', curEyeY + 15)

    if getTextFromFile('fixes.txt') == 'F' then -- why is onCreate() all the way down here
        hasFixes = false
    end
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