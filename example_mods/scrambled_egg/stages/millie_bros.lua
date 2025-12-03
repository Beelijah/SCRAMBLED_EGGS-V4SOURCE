local legsCurrentY = 0
local headCurrentY = 0
local camZoomOrigin = 0.75
local health = 1
local secondsSinceLastNote = 0
local framesSinceLastNote = 0
local hasFixes = true
local deltaTime = 1

-- feel free to edit these if you're messing with the game
local rayRunBounceIntensity = 5
local hasDoneWhiteTigerMove = false

local targetStep = 2176
-- template made by scrambled_egg3

function onBeatHit()
    local IconFlipX = getProperty('rayIcon.flipX')
    local IconX = getProperty('rayIcon.x')

    print('flipX: ', IconFlipX, ' x: ', IconX)

    if IconFlipX then
        setProperty('rayIcon.flipX', false)
        setProperty('rayIcon.x', 300)
    else
        setProperty('rayIcon.flipX', true)
        setProperty('rayIcon.x', 150)
    end

    if curStep > 2175 then
        if curStep < 2688 then
            triggerEvent('Add Camera Zoom', '0.015', '0.03')
        end
    end
end

function onCreate()
    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end
    
    setProperty('grass_anim.visible', false) -- REPLACE "object" WITH YOUR OBJECT NAME!!!
    setProperty('blythe-fly.visible', false)
    setProperty('appa-fly.visible', false)
    setProperty('ray-legs.visible', false)
    setProperty('picoUpArm.visible', false)

    makeLuaSprite('picoIcon', 'icons/icon-pico_run')
    makeLuaSprite('rayIcon', 'icons/icon-ray_run')

    -- making 2 whole characters in lua for the small little effect of a silhouette
    makeAnimatedLuaSprite('picoWhite', 'characters/MM_PicoWhite', -210, 300) -- init stuff

    if hasFixes then
        addAnimationByPrefix('picoWhite', 'singUP', "PicoUp0", 24, false) -- animations
        addAnimationByPrefix('picoWhite', 'singLEFT', "PicoLeft0", 24, false)
        addAnimationByPrefix('picoWhite', 'singRIGHT', "PicoRight0", 24, false)
        addAnimationByPrefix('picoWhite', 'singDOWN', "PicoDown0", 24, false)
    else
        addAnimationByPrefix('picoWhite', 'singUP', "PicoUp0", 24, true) -- animations
        addAnimationByPrefix('picoWhite', 'singLEFT', "PicoLeft0", 24, true)
        addAnimationByPrefix('picoWhite', 'singRIGHT', "PicoRight0", 24, true)
        addAnimationByPrefix('picoWhite', 'singDOWN', "PicoDown0", 24, true)
    end

    addAnimationByPrefix('picoWhite', 'shoot', "PicoShoot", 24, false)
    addAnimationByPrefix('picoWhite', 'idle', "Pico Idle Dance", 24, true)

    addOffset('picoWhite', 'singUP', -112, 58) -- offsets
    addOffset('picoWhite', 'singLEFT', 18, -17)
    addOffset('picoWhite', 'singRIGHT', -79, 34)
    addOffset('picoWhite', 'singDOWN', -32, -87)
    addOffset('picoWhite', 'shoot', 205, 170)
    addOffset('picoWhite', 'idle', 0, 0)

    playAnim('picoWhite', 'singUP', true) -- update offsets
    playAnim('picoWhite', 'singLEFT', true) 
    playAnim('picoWhite', 'singRIGHT', true)
    playAnim('picoWhite', 'singDOWN', true) 
    playAnim('picoWhite', 'shoot', true)
    playAnim('picoWhite', 'idle', true)

    addLuaSprite('picoWhite', true) -- add sprite to game
    setObjectCamera('picoWhite', 'game')
    doTweenAlpha('sdlfgijsldkgjsdlkgjsd', 'picoWhite', 0, 0.001, 'linear')
    setProperty('picoWhite.x', 657)
    setProperty('picoWhite.y', 441)

    -- CHARACTER TWO

    makeAnimatedLuaSprite('rayWhite', 'characters/ray-evilWhite', -210, 300) -- init stuff

    addAnimationByPrefix('rayWhite', 'singUP', "up", 24, true) -- animations
    addAnimationByPrefix('rayWhite', 'singLEFT', "left", 24, true)
    addAnimationByPrefix('rayWhite', 'singRIGHT', "right", 24, true)
    addAnimationByPrefix('rayWhite', 'singDOWN', "down", 24, true)
    addAnimationByIndices('rayWhite', 'idle', "idle", {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10}, 24, true)

    addOffset('rayWhite', 'singUP', 0, 3) -- offsets
    addOffset('rayWhite', 'singLEFT', 3, 0)
    addOffset('rayWhite', 'singRIGHT', -25, 5)
    addOffset('rayWhite', 'singDOWN', -20, 40)
    addOffset('rayWhite', 'idle', 0, 0)

    playAnim('rayWhite', 'singUP', true) -- update offsets
    playAnim('rayWhite', 'singLEFT', true) 
    playAnim('rayWhite', 'singRIGHT', true)
    playAnim('rayWhite', 'singDOWN', true) 
    playAnim('rayWhite', 'idle', true)

    addLuaSprite('rayWhite', true) -- add sprite to game
    setObjectCamera('rayWhite', 'game')
    doTweenAlpha('sdlfgijsldkgjsdlkgjsdssssss', 'rayWhite', 0, 0.001, 'linear')
    setProperty('rayWhite.x', -14)
    setProperty('rayWhite.y', 58)
    scaleObject('rayWhite', 2, 2)

    -- end of 2 characters
    -- tiger silhouette

    makeAnimatedLuaSprite('tigerWhite', 'tigerWhite-anim', 0, 0) -- init stuff
    addAnimationByPrefix('tigerWhite', 'tiger', "tiger", 2, true) -- animation

    playAnim('tigerWhite', 'tiger', true) -- play the anim

    addLuaSprite('tigerWhite', true) -- add sprite to game
    setObjectCamera('tigerWhite', 'game')
    doTweenAlpha('sdlfgijsldkgjsdlkgjasdasdasdsd', 'tigerWhite', 0, 0.001, 'linear')
    setProperty('tigerWhite.x', -1050)
    setProperty('tigerWhite.y', 410)

    -- Force the onUpdate function to run every frame
    -- used this a long time ago... do we still need it?

    -- hell no
    --local function callOnUpdate(elapsed)
    --    onUpdate(elapsed)
    --    return callOnUpdate
    --end
    --setOnUpdate(callOnUpdate)
end

function onSectionHit()
    playAnim('appa', 'idle', true)
    playAnim('blythe', 'idle', true)

    if secondsSinceLastNote < 2 then
        playAnim('rayWhite', 'idle', true)

        if curStep < 2032 then
            playAnim('picoWhite', 'idle', true)
        end
    end
end

function onUpdate(elapsed)
    local currentStep = getProperty('curStep')
    local picoIconX = 900
    -- print("onUpdate running. Elapsed:", elapsed, "Current Step:", currentStep) -- remove this if you dont want it to spam your console

    framesSinceLastNote = framesSinceLastNote + 1
    secondsSinceLastNote = framesSinceLastNote / framerate

    deltaTime = elapsed / (1/60) -- made this at 60 fps so this should work

    if currentStep == 272 then
        --setProperty('camZooming', false)
        --doTweenZoom('camZoomStart', 'game', 1, 0.75, 'quartOut')

        setHealth(1.15)
    end

    if currentStep == 553 then
        setHealth(2)
    end
    
    if currentStep == 1950 then
        if not hasDoneWhiteTigerMove then
            doTweenX('tigerWhiteMove', 'tigerWhite', 2160, 6) -- dont need 'linear' since it defaults to it
            hasDoneWhiteTigerMove = true                      -- haha very funny as i say this and then use linear a few lines later
        end
    end

    if currentStep == 303 then
        --setProperty('camZooming', false)
        --doTweenZoom('camZoomEnd', 'game', 0.75, 0.75, 'quartOut')
    end

    if currentStep == 1904 then -- fade in
        playAnim('picoWhite', 'idle', true)
        playAnim('rayWhite', 'idle', true)

         doTweenAlpha('sdlfgijsldkgjsdlkgjasdasdasdsd', 'tigerWhite', 1, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdgr', 'picoWhite', 1, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdfsdfssdgr', 'rayWhite', 1, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdfdg', 'bg', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsddfg', 'grass', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdfxc', 'dirt', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdxacx', 'appa', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdxvas', 'blythe', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdcdge', 'dad', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdasgfg', 'boyfriend', 0, 3.5, 'linear')
        doTweenAlpha('sdlfgijsldkgjsdlkgjsdasgfgwegfweg', 'grass2', 0, 3.5, 'linear')
    end

    if currentStep == 2048 then -- a lil reset so ray doesn't repeat the same animation for as long as this section goes
        playAnim('rayWhite', 'idle', true)
    end

    if currentStep == 2144 then -- fade out
        doTweenAlpha('jasdasdasdsd', 'tigerWhite', 0, 3.5, 'linear')
        doTweenAlpha('jsdlkgjsdaasda', 'rayWhite', 0, 1, 'linear')
        doTweenAlpha('jsdaasda', 'picoWhite', 0, 1, 'linear')
        doTweenAlpha('jsdab', 'bg', 1, 1, 'linear')
        doTweenAlpha('jsdac', 'grass', 1, 1, 'linear')
        doTweenAlpha('jsdad', 'dirt', 1, 1, 'linear')
        doTweenAlpha('jsdae', 'appa', 1, 1, 'linear')
        doTweenAlpha('jsdaf', 'blythe', 1, 1, 'linear')
        doTweenAlpha('jsdag', 'dad', 1, 1, 'linear')
        doTweenAlpha('jsdah', 'boyfriend', 1, 1, 'linear')
        doTweenAlpha('jsdahasdfojksafdjiofasdjklsafdjklasdfjklslajdfkjklfsdjadsfkjljkldsakjljklfdsakljds', 'grass2', 1, 1, 'linear')
    end

    if currentStep >= targetStep then
        setProperty('grass_anim.visible', true)
        setProperty('ray-legs.visible', true)

        setProperty('rayWhite.visible', false)
        setProperty('picoWhite.visible', false)

        health = getHealth()

        if currentStep <= 2699 then
            if health > 0.35 then
                if hasFixes then
                    addHealth(-0.0005 * deltaTime)
                else
                    addHealth(-0.0005)
                end
            end
        else
            setHealth(2)
        end

        doTweenAlpha('awioaejfgoaiwjgaoiwe', 'iconP1', 0, 0.001, 'linear')
        doTweenAlpha('awioaejfgoaiwjgaoiwf', 'iconP2', 0, 0.001, 'linear')

        addLuaSprite('picoIcon', true)
        addLuaSprite('rayIcon', true)

        setObjectCamera('picoIcon', 'hud')
        setObjectCamera('rayIcon', 'hud')

        if downscroll == false then
            setProperty('picoIcon.y', 575)
            setProperty('rayIcon.y', 575)
        elseif downscroll == true then
            setProperty('picoIcon.y', 0)
            setProperty('rayIcon.y', 0)
        end

        picoIconX = 300 * health + 300

        setProperty('picoIcon.x', picoIconX)

        if currentStep == targetStep then
            if difficultyName == "Hard" then -- there was gonna be other difficulties back then
                if hasFixes then
                    setHealth(1.5)
                else
                    setHealth(1.25)
                end
            elseif difficultyName == "Normal" then
                setHealth(1.5)
            else
                setHealth(2)
            end

            legsCurrentY = getProperty('ray-legs.y')
            headCurrentY = getProperty('dad.y')
            doTweenY('legsMoveUpTween', 'ray-legs', legsCurrentY + rayRunBounceIntensity, 0.1, 'quartOut')
            doTweenY('a', 'dad', headCurrentY + rayRunBounceIntensity, 0.1, 'quartOut')

            doTweenY('c', 'appa', 470, 0.6, 'quartOut')
            doTweenY('cc', 'surfboard', 265, 0.6, 'quartOut')

            doTweenY('d', 'blythe', 470, 0.6, 'quartOut')
            doTweenY('dd', 'surfboard2', 265, 0.6, 'quartOut')
        end

        if currentStep == 2688 then
            doTweenAlpha('asdowjeifwioefgjwfowijas', 'picoIcon', 0, 1, 'linear')
            doTweenAlpha('asdowjeifwioefgjwfowija', 'rayIcon', 0, 1, 'linear')

            doTweenX('b', 'dad', -1100, 2, 'linear')
            doTweenX('bb', 'ray-legs', -1100, 2, 'linear')

            doTweenX('bbb', 'appa', -1300, 2, 'linear')
            doTweenX('bbbb', 'surfboard', -1300, 2, 'linear')

            doTweenX('bbbbb', 'blythe', -1100, 2, 'linear')
            doTweenX('bbbbbb', 'surfboard2', -1100, 2, 'linear')
        end
    end
end

function onEndSong()
    --unlockAchievement('hasBeatCatOverdue')
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if boyfriendName == 'pico-MM_Phase3' then
        if noteData == 2 then
            setProperty('picoUpArm.visible', true)
        else
            setProperty('picoUpArm.visible', false)
        end
    else
        setProperty('picoUpArm.visible', false)

        if noteType == 'Pico White Note' then
            framesSinceLastNote = 0
        end
    end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Ray White Note' then
        framesSinceLastNote = 0
    end
end

function onTweenCompleted(tag)
    legsCurrentY = getProperty('ray-legs.y')
    headCurrentY = getProperty('dad.y')
    --print("onTweenCompleted running. legsCurrentY:", legsCurrentY, "headCurrentY:", headCurrentY) -- remove this if you dont want it to spam your console
    if tag == 'legsMoveUpTween' then
        doTweenY('legsMoveDownTween', 'ray-legs', legsCurrentY - rayRunBounceIntensity, 0.1, 'quartOut')
        doTweenY('aa', 'dad', headCurrentY - rayRunBounceIntensity, 0.1, 'quartOut')
	elseif tag == 'legsMoveDownTween' then 
        doTweenY('legsMoveUpTween', 'ray-legs', legsCurrentY + rayRunBounceIntensity, 0.1, 'quartOut')
        doTweenY('aaa', 'dad', headCurrentY + rayRunBounceIntensity, 0.1, 'quartOut')
    elseif tag == 'c' then
        doTweenY('ccc', 'appa', 514, 0.2, 'quartOut')
        doTweenY('ddd', 'blythe', 514, 0.2, 'quartOut')
    elseif tag == 'ccc' then
        doTweenY('cccc', 'appa', 524, 0.75, 'quartOut')
        doTweenY('dddd', 'blythe', 524, 0.75, 'quartOut')
        doTweenY('ddddd', 'surfboard2', 275, 0.75, 'quartOut')
        doTweenY('GoobersMoveDown', 'surfboard', 275, 0.75, 'quartOut')
    elseif tag == 'GoobersMoveDown' then
        doTweenY('GoobersMoveUp', 'appa', 86, 0.5, 'quartOut')
        doTweenY('dddddd', 'blythe', 86, 0.5, 'quartOut')
        doTweenY('cSurf', 'surfboard', -165, 0.5, 'quartOut')
        doTweenY('ddddddd', 'surfboard2', -165, 0.5, 'quartOut')
    elseif tag == 'GoobersMoveUp' then
        doTweenY('GoobersMoveDown', 'appa', 106, 0.5, 'quartOut')
        doTweenY('dddddddddddddddddddddddddddddddddd', 'blythe', 106, 0.5, 'quartOut')
        doTweenY('cSurf', 'surfboard', -145, 0.5, 'quartOut')
        doTweenY('dddddddddddddd', 'surfboard2', -145, 0.5, 'quartOut')
    elseif tag == 'camZoomEnd' then
        setProperty('camZooming', true)
    elseif tag == 'tigerWhiteMove' then
        setProperty('tigerWhite.x', -1050)
    end
end