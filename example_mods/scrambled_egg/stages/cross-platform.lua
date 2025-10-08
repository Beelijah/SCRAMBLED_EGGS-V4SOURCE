local hasSkippedCutscene = true -- dont set this to false or else you can skip while its counting down to the song

-- haha funny platform thats crossing
function onTweenCompleted(tag, vars)
    if tag == 'flashbangShow' then
        doTweenAlpha('flashbangHide3', 'flashbang', 0, 1)

        setProperty('mcsky.visible', true)
        setProperty('roblox-ground2.visible', false)
        setProperty('roblox-groundtop2.visible', false)
        setProperty('border.visible', true)
    end

    if tag == 'flashbangShowSkip' then
        doTweenAlpha('flashbangHide4', 'flashbang', 0, 1)
    end
end

function updateOpacity()
    cancelTween('C-FADE1')
    cancelTween('C-FADE2')

    setProperty('mc-cutscene.visible', true)
    setProperty('egg-scared.visible', true)
    setProperty('mc-cutscene.alpha', 1)
    setProperty('egg-scared.alpha', 1)
    doTweenAlpha('C-FADE1', 'mc-cutscene', 0, 0.75, 'linear')
    doTweenAlpha('C-FADE2', 'egg-scared', 0, 0.75, 'linear')
end

function onCreate()
    makeLuaSprite('flashbang', 'white', -2000, -500)
    scaleObject('flashbang', 50, 50)
    setObjectOrder('flashbang', 50)
    addLuaSprite('flashbang')

    makeLuaSprite('blackIntroCover', 'black', -2000, -500)
    scaleObject('blackIntroCover', 50, 50)
    setObjectOrder('blackIntroCover', 50)
    addLuaSprite('blackIntroCover')
    setObjectCamera('blackIntroCover')

    makeLuaText('skipText', 'PRESS "F" TO SKIP', 1280, 0, 615)
    setTextAlignment('skipText', 'center')
    setTextBorder('skipText', '5', '000000')
    setTextSize('skipText', 75)
    addLuaText('skipText')

    makeAnimatedLuaSprite('egg-scared', 'egg-scared', 550, 0)
    addAnimationByPrefix('egg-scared', 'normal', 'normal', 24, false)
    addAnimationByPrefix('egg-scared', 'scared', 'scared', 1000, false)
    addLuaSprite('egg-scared', true)
    setObjectCamera('egg-scared', 'hud')

    makeAnimatedLuaSprite('mc-cutscene', 'mc-cutscene', -950, -225)
    addAnimationByPrefix('mc-cutscene', '1', 'anim01', 24, true)
    addAnimationByPrefix('mc-cutscene', '2', 'anim02', 24, true)
    addAnimationByPrefix('mc-cutscene', '3', 'anim03', 24, true)
    addAnimationByPrefix('mc-cutscene', '4', 'anim04', 24, true)
    addLuaSprite('mc-cutscene', true)
    scaleObject('mc-cutscene', 1.25, 1.25)
    setObjectCamera('mc-cutscene', 'hud')

    setProperty('egg-scared.visible', false)
    setProperty('mc-cutscene.visible', false)
    setProperty('skipText.alpha', 0)

    setProperty('mcsky.visible', false)
    setProperty('border.visible', false)
    doTweenAlpha('flashbangHide', 'flashbang', 0, 0.01)
    doTweenAlpha('blackIntroShow', 'blackIntroCover', 1, 0.001)
end

function onSongStart()
    doTweenAlpha('blackIntroHide', 'blackIntroCover', 0, 5)
    doTweenAlpha('skipTextShow', 'skipText', 1, 1)

    hasSkippedCutscene = false
end

function onUpdate(elapsed)
    if keyboardPressed('F') then
        if not hasSkippedCutscene then
            if getSongPosition() < 22000 then
                hasSkippedCutscene = true

                runHaxeCode([[FlxG.sound.music.time = 22000;]]);
                runHaxeCode([[resyncVocals();]]);

                cancelTween('blackIntroHide')
                doTweenAlpha('hideBlackIntroCover', 'blackIntroCover', 0, 0.0001)
                doTweenAlpha('flashbangShowSkip', 'flashbang', 1, 0.0001)
                setProperty('skipText.visible', false)
            end
        end
    end
end

function onStepHit()
    if curStep == 250 then
        doTweenAlpha('skipTextHide', 'skipText', 0, 1)
    end

    if curStep == 512 then
        doTweenAlpha('blackIntroShow', 'blackIntroCover', 1, 0.001)
        setProperty('egg-scared.visible', true)
        setProperty('mc-cutscene.visible', true)
        setProperty('egg-scared.alpha', 0)
        setProperty('mc-cutscene.alpha', 0)
    end

    if curStep == 632 then
        playAnim('egg-scared', 'scared', true)
    end

    if curStep == 640 then
        doTweenAlpha('blackIntroHide', 'blackIntroCover', 0, 0.001)
        
        setProperty('egg-scared.visible', false)
        setProperty('mc-cutscene.visible', false)
    end

    if curStep == 1440 then -- start flashback
        doTweenAlpha('flashbangShowSkip', 'flashbang', 1, 0.0001)
    end

    if curStep == 1696 then -- finish flashback
        doTweenAlpha('flashbangShowSkip', 'flashbang', 1, 0.0001)
    end
end

function onEvent(event, value1, value2, strumTime)
    if event == 'Change Character' then
        if value2 == 'egg-mc' or value2 == 'egg-mc-maid' then -- shhh
            doTweenAlpha('flashbangShow', 'flashbang', 1, 0.0001)
        end
    end

    if event == 'CSText' then
        if value1 == '5' then
            playAnim('mc-cutscene', '1', true)
            updateOpacity()
        elseif value1 == '6' then
            playAnim('mc-cutscene', '2', true)
            updateOpacity()
        elseif value1 == '7' then
            playAnim('mc-cutscene', '3', true)
            updateOpacity()
        elseif value1 == '8' then
            playAnim('mc-cutscene', '4', true)
            updateOpacity()
        end
    end
end