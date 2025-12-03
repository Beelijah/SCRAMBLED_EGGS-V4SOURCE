-- this is like my favorite v1 song but it sucks really bad
-- so this is not really a "fixes" script but more of an
-- "entire remaster" script

local otherBeat = true
local fps = 0.000000015
local colorDuration = fps

function onCreatePost()
    makeLuaSprite('bg2', 'white', -1000, 0)
    scaleObject('bg2', 99, 99)
    setObjectOrder('bg2', getObjectOrder('bg'))
    addLuaSprite('bg2')

    makeLuaSprite('blackCoverGame', 'black', -300, -300)
    setObjectCamera('blackCoverGame', 'hud')
    scaleObject('blackCoverGame', 500, 500)
    addLuaSprite('blackCoverGame')

    makeAnimatedLuaSprite('lg', 'LETS-GO', 0, 0)
    setObjectCamera('lg', 'hud')
    addAnimationByPrefix('lg', 'lets', 'lets', 999, true)
    addAnimationByPrefix('lg', 'go', 'go', 999, true)
    scaleObject('lg', 1.5, 1.5)
    screenCenter('lg')
    addLuaSprite('lg')

    makeLuaSprite('blackCover', 'black', -300, -300)
    setObjectCamera('blackCover', 'hud')
    scaleObject('blackCover', 500, 500)
    addLuaSprite('blackCover', true)

    setProperty('blackCoverGame.visible', false)
    setProperty('blackCover.visible', false)
    setProperty('lg.visible', false)

    setScrollFactor('gf', 1, 1)
    setCharacterY('gf', getCharacterY('gf') + 20) -- i found this in the API while just scrolling around
    triggerEvent('Play Animation', 'locator', 'GF')
    setCameraFollowPoint(getCameraFollowX() + 100, getCameraFollowY() - 85)

    if not flashingLights then -- wow epilepsy support
        colorDuration = crochet / 2000
    else
        colorDuration = fps
    end
end

function onBeatHit()
    if otherBeat then
        playAnim('blythe', 'idle', true)
        playAnim('appa', 'idle', true)
        otherBeat = false
    else
        otherBeat = true
    end

    IconFlipX = getProperty('iconP2.flipX')
    if IconFlipX then
        setProperty('iconP2.flipX', false)
    else
        setProperty('iconP2.flipX', true)
    end

    if curStep > 270 and curStep < 320 then
        random = getRandomInt(1, 5, oldrandom) -- get a random number between 1 & 5 that isn't the last one

        if random == 1 then
            color = '00FF00'
        elseif random == 2 then
            color = '0000FF'
        elseif random == 3 then
            color = 'FF9100'
        elseif random == 4 then
            color = '00FF00'
        elseif random == 5 then
            color = 'FF0000'
        end

        oldrandom = random
        doTweenColor('colorChange', 'bg2', color, colorDuration)
    else
        doTweenColor('colorChange', 'bg2', 'FFFFFF', colorDuration)
    end
end

function onSectionHit()
    if not mustHitSection then
        setCameraFollowPoint(getCameraFollowX() + 100, getCameraFollowY() - 85)
    elseif gfSection and mustHitSection then
        setCameraFollowPoint(getCameraFollowX() - 100, getCameraFollowY() - 80)
    end
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Duet Note' then
        if noteData == 0 then
            currentGFanim = 'left'
        elseif noteData == 1 then
            currentGFanim = 'down'
        elseif noteData == 2 then
            currentGFanim = 'up'
        elseif noteData == 3 then
            currentGFanim = 'right'
        end

        cancelTimer('stopGFAnim')
        runTimer('stopGFAnim', crochet / 500)
    end

    if gfSection then
        cancelTimer('stopGFAnim')
        currentGFanim = 'none'
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'stopGFAnim' then
        currentGFanim = 'none'
    end
end

function onUpdate(elapsed)
    fps = elapsed

    if curStep > 639 then
        triggerEvent('Play Animation', 'singUP', 'BF')
        triggerEvent('Play Animation', 'singUP', 'GF')
        triggerEvent('Play Animation', 'singUP', 'Opponent')
    else
        if currentGFanim == 'left' then -- best way i could think to do it with GF
            triggerEvent('Play Animation', 'singLEFT', 'GF')
        elseif currentGFanim == 'down' then
            triggerEvent('Play Animation', 'singDOWN', 'GF')
        elseif currentGFanim == 'up' then
            triggerEvent('Play Animation', 'singUP', 'GF')
        elseif currentGFanim == 'right' then
            triggerEvent('Play Animation', 'singRIGHT', 'GF')
        end
    end
end

function onStepHit()
    if curStep > 271 and curStep < 350 then
        setProperty('bg.visible', false)
    else
        setProperty('bg.visible', true)
    end

    if curStep == 444 then -- let's
        setProperty('blackCoverGame.visible', true)
        setProperty('lg.visible', true)

        setProperty('healthBar.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
        setProperty('scoreTxt.alpha', 0)
        setProperty('timeTxt.alpha', 0)
        setProperty('timeBar.alpha', 0)
    end

    if curStep == 446 then -- go
        playAnim('lg', 'go', true)
    end

    if curStep == 448 then -- hide legs throw (lets go)
        setProperty('blackCoverGame.visible', false)
        setProperty('lg.visible', false)

        doTweenAlpha('8', 'healthBar', 1, crochet / 500, 'linear')
        doTweenAlpha('9', 'iconP1', 1, crochet / 500, 'linear')
        doTweenAlpha('10', 'iconP2', 1, crochet / 500, 'linear')
        doTweenAlpha('11', 'scoreTxt', 1, crochet / 500, 'linear')
        doTweenAlpha('12', 'timeTxt', 1, crochet / 500, 'linear')
        doTweenAlpha('13', 'timeBar', 1, crochet / 500, 'linear')
    end

    if curStep == 656 then -- hide all
        setProperty('blackCover.visible', true)
    end
end