local hasCheckedKey = false
local hasSeenCutscene
local hasAchievement = isAchievementUnlocked('lovesScrambledEggs25')
local huyFadeTime = 0.35

function onEndSong()
    unlockAchievement('hasBeatFinale')
end

function onCreate()
    hasSeenCutscene = seenCutscene

    setProperty('lockCover.x', -600)
    setProperty('lockCover.y', -700)

    --hasAchievement = false -- keep this commented out, this is only for testing

    --hasAchievement = true -- GUYS THIS IS REVOLUTIONARY TECHNOLOGY
--  ^^ REMOVE THOSE TWO DASHES
    -- TO SKIP THE LOCK SCREEN
    -- LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE, LOOK HERE!!!

    setProperty('aaaaaa.x', 10000)

    if not hasAchievement then
        hasSeenCutscene = false
    end

    if not hasSeenCutscene then

        setProperty('lockCover.x', -600)
        setProperty('lockCover.y', -700)

        doTweenAlpha('hideHUDlock8', 'healthBar', 0, 0.00000001, 'linear')
        doTweenAlpha('hideHUDlock9', 'iconP1', 0, 0.00000001, 'linear')
        doTweenAlpha('hideHUDlock10', 'iconP2', 0, 0.00000001, 'linear')
        doTweenAlpha('hideHUDlock11', 'scoreTxt', 0, 0.00000001, 'linear')
        doTweenAlpha('hideHUDlock12', 'timeTxt', 0, 0.00000001, 'linear')
        doTweenAlpha('hideHUDlock13', 'timeBar', 0, 0.00000001, 'linear')

        makeLuaSprite('lock', 'locked')
        setObjectCamera('lock', 'hud')

        scaleObject('lock', 5, 5, true)

        setProperty('lock.x', 1280 / 2 - 145)
        setProperty('lock.y', 720 / 2 - 185)

        setProperty('lock.antialiasing', false)

        addLuaSprite('lock', true)

        makeLuaText('enterText', 'PRESS ENTER', 0, 395)
        setTextFont('enterText', 'vcr-lol.ttf')
        setTextSize('enterText', 115)
        setTextWidth('enterText', 1000)
        setTextHeight('enterText', 185)
        setTextAutoSize('enterText', false)
        setTextColor('enterText', 'black') -- set 'gray' to 'red' for red (duh)
        setTextAlignment('enterText', 'center')
        setTextBorder('enterText', 2, 'white')
        setProperty('enterText.x', 160)
        setProperty('enterText.y', 540)
        addLuaText('enterText')
    end
end

function onUpdate(elapsed)
    local currentKeyPressed = keyPressed('accept')
    local otherCurrentKeyPressed = keyPressed('back')
    local timeOfUnlockSound = getSoundTime('unlockSound')
    local hasSetSpriteToUnlocked = false
    local stopRunningLockStuff = false
    local isSkipKeyPressed = keyPressed('up')

    if isSkipKeyPressed then
        if not hasAchievement then
            debugPrint('             skipped')
            setAchievementScore('lovesScrambledEggs25', 1, true)
            setAchievementScore('lovesScrambledEggs25', 5, true)
            restartSong(true)
        end
    end

    if curStep == 1 then
        setProperty('lockCover.visible', false)
    end

    if curStep == 1168 then
        doTweenAlpha('hideBGijkl', 'lockCover', 0, 0.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'quartOut')
        setProperty('lockCover.visible', true)
        doTweenAlpha('hideBG', 'lockCover', 1, 2, 'quartOut')
    end

    if curStep > 1190 then
        setProperty('aaaaaa.x', -1900)
        setProperty('aaaaaa.y', -1645)

        setProperty('fg.visible', false)

        setProperty('comboGroup.y', 150) -- https://gamebanana.com/questions/65321
        setProperty('comboGroup.x', -300)
    end        

    if timeOfUnlockSound > 5000 then
        stopRunningLockStuff = true
        
        restartSong(false)
    end

    if hasSeenCutscene then
        stopRunningLockStuff = true
    end
    
    if not stopRunningLockStuff then
        if timeOfUnlockSound > 1529 then
            hasSetSpriteToUnlocked = true

            removeLuaSprite('lock')

            makeLuaSprite('lock', 'unlocked')
            setObjectCamera('lock', 'hud')

            scaleObject('lock', 5, 5, true)

            setProperty('lock.x', 1280 / 2 - 145)
            setProperty('lock.y', 720 / 2 - 185)

            setProperty('lock.antialiasing', false)

            addLuaSprite('lock', true)
        end


        if currentKeyPressed then
            if not hasCheckedKey then
                hasCheckedKey = true

                if hasAchievement then
                    playSound('unlock', 1, 'unlockSound')
                else
                    playSound('locked', 1)

                    removeLuaText('enterText')

                    makeLuaText('enterText', 'PRESS BACKSPACE', 0, 395)
                    setTextFont('enterText', 'vcr-lol.ttf')
                    setTextSize('enterText', 115)
                    setTextWidth('enterText', 1050)
                    setTextHeight('enterText', 185)
                    setTextAutoSize('enterText', false)
                    setTextColor('enterText', 'black') -- set 'gray' to 'red' for red (duh)
                    setTextAlignment('enterText', 'center')
                    setTextBorder('enterText', 2, 'white')
                    setProperty('enterText.x', 113)
                    setProperty('enterText.y', 540)
                    addLuaText('enterText')

                    makeLuaText('helpText', 'YOU MUST BEAT 5 SONGS TO CONTINUE', 0, 395)
                    setTextFont('helpText', 'vcr-lol.ttf')
                    setTextSize('helpText', 100)
                    setTextWidth('helpText', 1280)
                    setTextHeight('helpText', 300)
                    setTextAutoSize('helpText', false)
                    setTextColor('helpText', 'black') -- set 'gray' to 'red' for red (duh)
                    setTextAlignment('helpText', 'center')
                    setTextBorder('helpText', 2, 'white')
                    setProperty('helpText.x', 0)
                    setProperty('helpText.y', 0)
                    addLuaText('helpText')

                end
            end
        elseif otherCurrentKeyPressed then
            if not hasAchievement then
                exitSong()
            end
        end
    end
end

function onStartCountdown()
    if not hasSeenCutscene then 
        return Function_Stop;
    end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    if curStep > 1190 then 
        if not isSustain then 
            setProperty('lockCover.visible', true)
            cancelTween('hideHuy')

            doTweenAlpha('showHuy', 'lockCover', 0, 0.00000001, 'linear')
            doTweenAlpha('hideHuy', 'lockCover', 1, huyFadeTime, 'linear')
        end
    end
end