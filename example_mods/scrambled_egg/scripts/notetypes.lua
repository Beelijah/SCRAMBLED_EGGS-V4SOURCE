local hasFixes = true

local swordVolume = 1
local isMuted = false
local muteTimer = 0
local health = 1
local mushroomScale = 1
local isPoisoned = false
local loseHealthPerFrame = 0

-- by scrambled_egg3 for the vs scrambled eggs mod

function goodNoteHit(index, noteData, noteType, isSustain)
    if isMuted then
        if not isSustain then
            addMisses(1)
            setHits(0)
            addScore(-10)
            setHealth(health - 0.035)
        end
    elseif not isMuted then
        if songName == 'chat' then
            if not isSustain then
                setHealth(health + 0.035) -- little bonus for babies who cant beat it
            end
        end
    end

    if noteType == 'Poison Note' then
        local poisonTime = 3                     -- how long to be poisoned for in seconds.
        local healthDecreasedBy = -0.25          -- how much the health is decreased by, 2 is max hp, 0 is dead.
        local poisonTimeInFrames = framerate * 3 -- same as poisonTime except in frames.

        if isPoisoned then
            loseHealthPerFrame = loseHealthPerFrame * 2
        else
            loseHealthPerFrame = healthDecreasedBy / poisonTimeInFrames
        end

        isPoisoned = true
        runTimer('poisonTimer', poisonTime)
    end
    
    if noteType == 'Bullet Note' then
        triggerEvent('Play Animation','shoot', 'bf')
        triggerEvent('Screen Shake', '0.2, 0.005', '0.2, 0.005')
        if songName == 'cat-overdue' then 
            playAnim('picoWhite', 'shoot', true)
        end
        health = getHealth()
        if health < 2 then
            addHealth(0.25)
        end
    elseif noteType == 'Pico White Note' then -- notedata: 0 = left, 1 = down, 2 = up, 3 = right
        if noteData == 0 then
            playAnim('picoWhite', 'singLEFT', true)
        elseif noteData == 1 then
            playAnim('picoWhite', 'singDOWN', true)
        elseif noteData == 2 then
            playAnim('picoWhite', 'singUP', true)
        elseif noteData == 3 then
            playAnim('picoWhite', 'singRIGHT', true)
        end
    elseif noteType == 'Sword Note' then
        playSound('RobloxSwordAttack', swordVolume)
        triggerEvent('Play Animation','dodge', 'bf')
        triggerEvent('Play Animation','attack2', 'dad')
    elseif noteType == 'Mute Note' then
        muteTimer = 3 * framerate

        return Function_Stop;
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'poisonTimer' then
        isPoisoned = false
    end
   
    if tag == 'rayGrowUp1' then
        playSound('MushroomSound2', 1)
        runTimer('rayGrowUp2', 0.33)

        triggerEvent('Play Animation', 'idle', 'BF')
    end

    if tag == 'rayGrowUp2' then
        playSound('MushroomSound3', 1)

        triggerEvent('Play Animation', 'big', 'BF')
    end
end

function onUpdate(elapsed)
    --print('muteTimer: ',muteTimer,' isMuted: ',isMuted)
    health = getHealth()

    if muteTimer > 0 then
        muteTimer = muteTimer - 1
        isMuted = true
    elseif muteTimer == 0 then
        isMuted = false
    end

    if songName == 'cat-overdone' then
        if isPoisoned then
            if health > loseHealthPerFrame - loseHealthPerFrame - loseHealthPerFrame then
                addHealth(loseHealthPerFrame)
            end
        end
    end

    if songName == 'chat' then
        if isMuted then
            setProperty('bg.visible', false)
        else
            setProperty('bg.visible', true)
        end
    end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Ray White Note' then -- notedata: 0 = left, 1 = down, 2 = up, 3 = right
        if noteData == 0 then
            playAnim('rayWhite', 'singLEFT', true)
        elseif noteData == 1 then
            playAnim('rayWhite', 'singDOWN', true)
        elseif noteData == 2 then
            playAnim('rayWhite', 'singUP', true)
        elseif noteData == 3 then
            playAnim('rayWhite', 'singRIGHT', true)
        end
    elseif noteType == 'Sword Note' then
        triggerEvent('Play Animation','attack1', 'dad')
        playSound('RobloxSwordEquip', swordVolume)
    elseif noteType == 'Opponent Poison Note' then        
        if mustHitSection then
            if not middlescroll then
                CHANGEDdefaultPlayerStrumX0 = defaultPlayerStrumX0 + 335
                CHANGEDdefaultPlayerStrumX1 = defaultPlayerStrumX1 + 410
                CHANGEDdefaultPlayerStrumX2 = defaultPlayerStrumX2 + 485
                CHANGEDdefaultPlayerStrumX3 = defaultPlayerStrumX3 + 550
            else
                CHANGEDdefaultPlayerStrumX0 = defaultPlayerStrumX0 + 335 - 190
                CHANGEDdefaultPlayerStrumX1 = defaultPlayerStrumX1 + 410 - 190
                CHANGEDdefaultPlayerStrumX2 = defaultPlayerStrumX2 + 485 - 190
                CHANGEDdefaultPlayerStrumX3 = defaultPlayerStrumX3 + 550 - 190
            end
        else
            if not middlescroll then
                CHANGEDdefaultPlayerStrumX0 = defaultPlayerStrumX0 + 335 - 190 * 2 + 25
                CHANGEDdefaultPlayerStrumX1 = defaultPlayerStrumX1 + 410 - 190 * 2 + 25
                CHANGEDdefaultPlayerStrumX2 = defaultPlayerStrumX2 + 485 - 190 * 2 + 25
                CHANGEDdefaultPlayerStrumX3 = defaultPlayerStrumX3 + 550 - 190 * 2 + 25
            else
                CHANGEDdefaultPlayerStrumX0 = defaultPlayerStrumX0 + 335 - 190 * 2 - 130
                CHANGEDdefaultPlayerStrumX1 = defaultPlayerStrumX1 + 410 - 190 * 2 - 130
                CHANGEDdefaultPlayerStrumX2 = defaultPlayerStrumX2 + 485 - 190 * 2 - 130
                CHANGEDdefaultPlayerStrumX3 = defaultPlayerStrumX3 + 550 - 190 * 2 - 130
            end
        end

        setProperty('poisonMushroom.x', 470)

        if noteData == 0 then
            doTweenX('poisonMushroomToNote', 'poisonMushroom', CHANGEDdefaultPlayerStrumX0, stepCrochet / 250, 'quartOut')
        elseif noteData == 1 then
            doTweenX('poisonMushroomToNote', 'poisonMushroom', CHANGEDdefaultPlayerStrumX1, stepCrochet / 250, 'quartOut')
        elseif noteData == 2 then
            doTweenX('poisonMushroomToNote', 'poisonMushroom', CHANGEDdefaultPlayerStrumX2, stepCrochet / 250, 'quartOut')
        elseif noteData == 3 then
            doTweenX('poisonMushroomToNote', 'poisonMushroom', CHANGEDdefaultPlayerStrumX3, stepCrochet / 250, 'quartOut')
        end

        if not mustHitSection then
            if not downscroll then
                doTweenY('poisonMushroomToDown', 'poisonMushroom', 1055, stepCrochet / 250, 'quartOut')
            else
                doTweenY('poisonMushroomToDown', 'poisonMushroom', -300, stepCrochet / 250, 'quartOut')
            end
        else
            if not downscroll then
                doTweenY('poisonMushroomToDown', 'poisonMushroom', 1200, stepCrochet / 250, 'quartOut')
            else
                doTweenY('poisonMushroomToDown', 'poisonMushroom', -250, stepCrochet / 250, 'quartOut')
            end
        end

        -- place the opponent notes 10 steps before regular poison note for player

        triggerEvent('Play Animation','singRIGHT', 'dad')

        setProperty('poisonMushroom.y', 473)
        setProperty('poisonMushroom.visible', true)
    elseif noteType == 'Mushroom' then
        setProperty('Mushroom.x', 470)
        setProperty('Mushroom.y', 565)
        setProperty('Mushroom.visible', true)

        doTweenX('MushroomToRay', 'Mushroom', 1050, stepCrochet / 250, 'quartOut')
        setObjectOrder('Mushroom', getObjectOrder('boyfriendGroup') - 1)
    end
end

function noteMiss(index, noteData, noteType, isSustain)
    --debugPrint('notetype: ' .. noteType)

    if noteType == 'Sword Note' then
        setHealth(health - 0.25)
        playSound('RobloxSwordAttack', swordVolume)
        triggerEvent('Play Animation','attack2', 'dad')
    end

    if isMuted then
        if not isSustain then
            setHealth(health + 0.01)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'poisonMushroomToDown' then
        setProperty('poisonMushroom.visible', false)
    end

    if tag == 'MushroomToRay' then
        setProperty('Mushroom.visible', false)

        playSound('MushroomSound1', 1)
        runTimer('rayGrowUp1', 0.205)

        setProperty('boyfriend.flipX', true)
        triggerEvent('Play Animation', 'big', 'BF')
    end
end

function onCreate()
    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end

    if songName == 'cat-overdone' then
        makeLuaSprite('poisonMushroom', 'noteSkins/poisonNote')
        setObjectCamera('poisonMushroom', 'game')
        scaleObject('poisonMushroom', mushroomScale, mushroomScale)
        addLuaSprite('poisonMushroom', true)

        makeLuaSprite('Mushroom', 'Mushroom')
        setObjectCamera('Mushroom', 'game')
        scaleObject('Mushroom', mushroomScale, mushroomScale)
        addLuaSprite('Mushroom', true)

        setProperty('Mushroom.visible', false)
        setProperty('poisonMushroom.visible', false)
    end
end