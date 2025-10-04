local barsRotateSpeed = 50

shouldbeclearinghud = true

-- step 0000 (act 1.0)
-- step 1728 (act 2.0)
-- step 3168 (act 3.0)
-- step 4422 (act 3.5)
-- step 4811 (act 4.0)

function onSectionHit()
    if curStep > 111 then
        if mustHitSection then -- bf code
            setProperty('dad.visible', false)
            setProperty('boyfriend.visible', true)
        elseif not mustHitSection then -- dad code
            setProperty('dad.visible', true)
            setProperty('boyfriend.visible', false)
        end
    end
end

function onEvent(name, value1, value2)
    if name == 'YCBU Text' then
        makeLuaText('YCBUTEXT', value1, 1280)
        setTextFont('YCBUTEXT', 'mariones.ttf')
        setTextSize('YCBUTEXT', 100)
        setTextHeight('YCBUTEXT', 720)
        setTextAutoSize('YCBUTEXT', false)
        setTextColor('YCBUTEXT', 'red')
        setTextAlignment('YCBUTEXT', 'center')
        setProperty('YCBUTEXT.y', 275)
        addLuaText('YCBUTEXT')
        cancelTimer('whiteTextTimer')
        runTimer('whiteTextTimer', 0.03333)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'whiteTextTimer' then
        setTextColor('YCBUTEXT', 'white')
    end
end

function onCreate()
    setProperty('boyfriend.x', 0)
    setProperty('boyfriend.visible', false)
    setProperty('dad.visible', false)

    setProperty('bars.visible', true)

    setProperty('greenfloor.visible', false)
    setProperty('greenbush.visible', false)
    setProperty('greentree.visible', false)
    setProperty('greensky.visible', false)

    setProperty('castlelava.visible', false)
    setProperty('castle2.visible', false)
    setProperty('castlebar.visible', false)
    setProperty('castle.visible', false)
    setProperty('castlebg.visible', false)

    setProperty('static.visible', false)
    setProperty('mixed.visible', false)

    doTweenAngle('barsrotate1', 'bars', 359, barsRotateSpeed) 
    setProperty('bars.y', -3500)
    setProperty('bars.x', 0)
    scaleObject('bars', 4, 10)
end

function onStartCountdown()
    setProperty('comboGroup.y', 150) -- https://gamebanana.com/questions/65321
    setProperty('comboGroup.x', -300)
end

function onSongStart()
    shouldbeclearinghud = false
end

function onUpdate(elapsed)
    setCameraFollowPoint(257, 531)

    if shouldbeclearinghud then
        noteTweenAlpha('hideHUDUNBEATABLEevent0', 0, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent1', 1, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent2', 2, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent3', 3, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent4', 4, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent5', 5, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent6', 6, 0, 0.0000001, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent7', 7, 0, 0.0000001, 'linear')

        doTweenAlpha('hideHUDUNBEATABLEevent8', 'healthBar', 0, 0.0000001, 'linear')
        doTweenAlpha('hideHUDUNBEATABLEevent9', 'iconP1', 0, 0.0000001, 'linear')
        doTweenAlpha('hideHUDUNBEATABLEevent10', 'iconP2', 0, 0.0000001, 'linear')
        doTweenAlpha('hideHUDUNBEATABLEevent11', 'scoreTxt', 0, 0.0000001, 'linear')
        doTweenAlpha('hideHUDUNBEATABLEevent12', 'timeTxt', 0, 0.0000001, 'linear')
        doTweenAlpha('hideHUDUNBEATABLEevent13', 'timeBar', 0, 0.0000001, 'linear')
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'bfshoes' then
        doTweenAlpha('bfshoes', 'boyfriend', 1, 1, 'linear')
    end

    if tag == 'barsrotate1' then
        doTweenAngle('barsrotate2', 'bars', 0, 0.000000000000001) 
        debugPrint('a')
    end

    if tag == 'barsrotate2' then
        doTweenAngle('barsrotate1', 'bars', 360, barsRotateSpeed) 
    end
end

function noteMiss(index, noteData, noteType, isSustain)
    if curStep > 1344 then
        if curStep < 1694 then
            setHealth(0)
        end
    end
end

function onStepHit()
    if curStep < 111 then
        setProperty('boyfriend.visible', false)
    end

    if curStep == 112 then
        setProperty('boyfriend.visible', true)
        doTweenAlpha('bfshoes', 'boyfriend', 0, 0.0000001, 'linear')
    end

    if curStep == 1360 then
        noteTweenAlpha('hideHUDUNBEATABLEevent0', 0, 1, 1, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent1', 1, 1, 1, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent2', 2, 1, 1, 'linear')
        noteTweenAlpha('hideHUDUNBEATABLEevent3', 3, 1, 1, 'linear')

        noteTweenX('middlescrolUNHBEATABLEl', 4, 412, 1, 'linear')
        noteTweenX('middlescrolUNHBEATABLEm', 5, 524, 1, 'linear')
        noteTweenX('middlescrolUNHBEATABLEn', 6, 636, 1, 'linear')
        noteTweenX('middlescrolUNHBEATABLEo', 7, 748, 1, 'linear')
    end

    if curStep == 1 then
        setProperty('bars.visible', true)

        setProperty('greenfloor.visible', false)
        setProperty('greenbush.visible', false)
        setProperty('greentree.visible', false)
        setProperty('greensky.visible', false)

        setProperty('castlelava.visible', false)
        setProperty('castle2.visible', false)
        setProperty('castlebar.visible', false)
        setProperty('castle.visible', false)
        setProperty('castlebg.visible', false)

        setProperty('static.visible', false)
        setProperty('mixed.visible', false)
    elseif curStep == 1728 then
        setProperty('bars.visible', false)

        setProperty('greenfloor.visible', true)
        setProperty('greenbush.visible', true)
        setProperty('greentree.visible', true)
        setProperty('greensky.visible', true)

        setProperty('castlelava.visible', false)
        setProperty('castle2.visible', false)
        setProperty('castlebar.visible', false)
        setProperty('castle.visible', false)
        setProperty('castlebg.visible', false)

        setProperty('static.visible', false)
        setProperty('mixed.visible', false)
    elseif curStep == 3168 then
        setProperty('bars.visible', false)

        setProperty('greenfloor.visible', false)
        setProperty('greenbush.visible', false)
        setProperty('greentree.visible', false)
        setProperty('greensky.visible', false)

        setProperty('castlelava.visible', true)
        setProperty('castle2.visible', true)
        setProperty('castlebar.visible', true)
        setProperty('castle.visible', true)
        setProperty('castlebg.visible', true)

        setProperty('static.visible', false)
        setProperty('mixed.visible', false)
    elseif curStep == 4422 then
        setProperty('bars.visible', true)

        setProperty('greenfloor.visible', false)
        setProperty('greenbush.visible', false)
        setProperty('greentree.visible', false)
        setProperty('greensky.visible', false)

        setProperty('castlelava.visible', false)
        setProperty('castle2.visible', false)
        setProperty('castlebar.visible', false)
        setProperty('castle.visible', false)
        setProperty('castlebg.visible', false)

        setProperty('static.visible', false)
        setProperty('mixed.visible', false)
    elseif curStep == 4811 then
        setProperty('bars.visible', false)

        setProperty('greenfloor.visible', false)
        setProperty('greenbush.visible', false)
        setProperty('greentree.visible', false)
        setProperty('greensky.visible', false)

        setProperty('castlelava.visible', false)
        setProperty('castle2.visible', false)
        setProperty('castlebar.visible', false)
        setProperty('castle.visible', false)
        setProperty('castlebg.visible', false)

        setProperty('static.visible', false)
        setProperty('mixed.visible', false)
    end
end