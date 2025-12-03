local audioQuality = 6
local audioQualityHasChanged = false
local oldAudioQuality = 1
local timeUntilNextQualityChange = 1.1 -- this number must be above 1
local canUseNumToChangeQuality = false
local canAudioQualityChange = true
local sectionNum = 0

-- by scrambled_egg3 (except for the event thingy)

-- 8, 11, 16, 22, 32, 44
-- 1, 2,  3,  4,  5,  6

-- ^ audioQuality to filename

function onCreate() -- add files to ram to avoid stutters when swapping quality for the first time
    makeLuaSprite('blackStartingCover', 'black', 0, 0)
    scaleObject('blackStartingCover', 10, 10)
    setObjectCamera('blackStartingCover', 'hud')
    addLuaSprite('blackStartingCover', true)

    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)

    setProperty('2B1.visible', false)
    setProperty('2B2.visible', false)
    setProperty('2B3.visible', false)
    setProperty('2B4.visible', false)
    setProperty('2B5.visible', false)
    setProperty('2G.visible', false)

    setProperty('3B1.visible', false)
    setProperty('3B2.visible', false)
    setProperty('3B3.visible', false)
    setProperty('3B4.visible', false)
    setProperty('3B5.visible', false)
    setProperty('3G.visible', false)

    setProperty('1B.visible', false)
    setProperty('1G.visible', false)
    
    setProperty('4B1.visible', false)
    setProperty('4B2.visible', false)
    setProperty('4B3.visible', false)
    setProperty('4G.visible', false)

    setProperty('5G.visible', false)
    setProperty('5B.visible', false)

    setProperty('6.visible', true)

    setProperty('0.visible', false)
    setProperty('crt4by3.visible', false)
    setProperty('4by3.visible', false)

    setProperty('crt.visible', false)

    precacheSound('inst8') -- music
    precacheSound('inst11')
    precacheSound('inst16')
    precacheSound('inst22')
    precacheSound('inst32')
    precacheSound('inst44')

    precacheSound('egg8')
    precacheSound('egg11')
    precacheSound('egg16')
    precacheSound('egg22')
    precacheSound('egg32')
    precacheSound('egg44')

    precacheImage('characters/egg-finale1') -- character images
    precacheImage('characters/egg-finale2')
    precacheImage('characters/egg-finale3')
    precacheImage('characters/egg-finale4')
    precacheImage('characters/egg-finale5')
    precacheImage('characters/egg-finale6')

    precacheImage('characters/huy-finale1')
    precacheImage('characters/huy-finale2')
    precacheImage('characters/huy-finale3')
    precacheImage('characters/huy-finale4')
    precacheImage('characters/huy-finale5')
    precacheImage('characters/huy-finale6')

    precacheImage('notes6') -- note images
    precacheImage('notes5')
    precacheImage('notes4')
    precacheImage('notes3')
    precacheImage('notes2')
    precacheImage('notes1')
    precacheImage('notes0')

    precacheImage('notes-splashes6')
    precacheImage('notes-splashes5')
    precacheImage('notes-splashes4')
    precacheImage('notes-splashes3')
    precacheImage('notes-splashes2')
    precacheImage('notes-splashes1')
    precacheImage('notes-splashes0')
end

function noteMiss(index, noteData, noteType, isSustain)
    print('Blast Processing: Received a player miss! (Step: ' .. curStep .. ')')
    if not isSustain then
        if canAudioQualityChange then
            if audioQuality == 2 or audioQuality == 3 or audioQuality == 4 or audioQuality == 5 or audioQuality == 6 then -- if it aint broke, dont fix it.
                print('Blast Processing: Player miss met criteria! Lowering quality...')
                audioQuality = audioQuality - 1
                audioQualityHasChanged = true

                canAudioQualityChange = false
                runTimer('qualitychange', timeUntilNextQualityChange, false)
            else
                print('Blast Processing: Quality is minimum! Cannot lower quality...')
            end
        end
    end
end

function onSongStart()
    playSound('inst44', 1, 'inst', false)
    playSound('egg44', 1, 'voices', false)

    doTweenAlpha('blackStartingCoverFadeOut', 'blackStartingCover', 0, 1)
end

function onPause()
    pauseSound('inst')
    pauseSound('voices')
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Ring Note' then
        addHealth(0.1) -- bonus since this song is a huge difficulty spike and you hit the ring
        if canAudioQualityChange then
            if not isSustain then
                if audioQuality == 1 or audioQuality == 2 or audioQuality == 3 or audioQuality == 4 or audioQuality == 5 then -- if it aint broke, dont fix it.
                    audioQuality = audioQuality + 1
                    audioQualityHasChanged = true

                    canAudioQualityChange = false
                    runTimer('qualitychange', timeUntilNextQualityChange, false)
                elseif audioQuality == 6 then
                    addHealth(0.25) -- BIG BONUS if you're full quality and still hit the ring
                end
            end
        end
    elseif not isSustain then
        addHealth(0.025) -- little bonus since this song is a huge difficulty spike
    end
end

function onResume()
    resumeSound('inst')
    resumeSound('voices')

    if not getSoundTime('inst') == getSongPosition() then
        --debugPrint('mismatching sync! (' .. getSoundTime('voices') .. ' ' .. getSoundTime('inst') .. ')')
        print('mismatching sync! (', getSoundTime('voices'), ' ', getSoundTime('inst'), ')')

        setSoundTime('inst', getSongPosition())   -- inst  sync
        setSoundTime('voices', getSongPosition()) -- vocal sync
    end
end

function onStepHit() -- quality level 0 is hit on steps 896 & 1120 + 1408 (ends on steps 1024 & 1152 (final one never ends))
    local roundedrating = math.floor(rating * 10000 + 0.5) / 100
    local finalScoreTextText = 'Score: ' .. score .. ' | Misses: ' .. misses .. ' | Accuracy: ' .. roundedrating .. '%'

    if curStep == 896 then
        oldAudioQuality = audioQuality

        audioQuality = 0
        audioQualityHasChanged = true
    end

    if curStep == 1120 then
        oldAudioQuality = audioQuality

        audioQuality = 0
        audioQualityHasChanged = true
    end

    if curStep == 1408 then
        oldAudioQuality = audioQuality

        makeLuaText('finalScoreText', finalScoreTextText, 1280, 0, 50)
        setTextFont('finalScoreText', 'vcr-lol.ttf')
        setTextSize('finalScoreText', 35)
        setTextAlignment('finalScoreText', 'center')
        addLuaText('finalScoreText')

        audioQuality = 0
        audioQualityHasChanged = true
    end

    if curStep == 1024 then
        audioQuality = oldAudioQuality
        audioQualityHasChanged = true
    end

    if curStep == 1152 then
        audioQuality = oldAudioQuality
        audioQualityHasChanged = true
    end
end

function onGameOver()
    stopSound('inst')
    stopSound('voices')
end

function onUpdate(elapsed)
    local curAudioTime = 0

    if canUseNumToChangeQuality then
        if keyboardPressed('ONE') then
            audioQuality = 1
            audioQualityHasChanged = true
        elseif keyboardPressed('TWO') then
            audioQuality = 2
            audioQualityHasChanged = true
        elseif keyboardPressed('THREE') then
            audioQuality = 3
            audioQualityHasChanged = true
        elseif keyboardPressed('FOUR') then
            audioQuality = 4
            audioQualityHasChanged = true
        elseif keyboardPressed('FIVE') then
            audioQuality = 5
            audioQualityHasChanged = true
        elseif keyboardPressed('SIX') then
            audioQuality = 6
            audioQualityHasChanged = true
        elseif keyboardPressed('SEVEN') then
            audioQuality = 7
            audioQualityHasChanged = true
        elseif keyboardPressed('G') then
            audioQuality = 0
            audioQualityHasChanged = true
        end
    end

    if audioQualityHasChanged then
        audioQualityHasChanged = false

        print('Blast Processing: Received a request to change quality to ' .. audioQuality .. '.')

        setProperty('qualityFADE.x', -4200)

        doTweenAlpha('quality-fade', 'qualityFADE', 0, 1)

        stopSound('inst')
        stopSound('voices')

        if audioQuality == 1 then
            playSound('inst8', 1, 'inst', false) -- audio stuff
            playSound('egg8', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale1') -- character stuff
            triggerEvent('Change Character', 'bf', 'egg-finale1')

            setProperty('2B1.visible', false) -- stage stuff
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1G.visible', true)
            setProperty('1B.visible', true)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', false)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)

            setProperty('crt.visible', true)
        elseif audioQuality == 2 then
            playSound('inst11', 1, 'inst', false)
            playSound('egg11', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale2')
            triggerEvent('Change Character', 'bf', 'egg-finale2')

            setProperty('2B1.visible', true)
            setProperty('2B2.visible', true)
            setProperty('2B3.visible', true)
            setProperty('2B4.visible', true)
            setProperty('2B5.visible', true)
            setProperty('2G.visible', true)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1G.visible', false)
            setProperty('1B.visible', true)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', false)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)

            setProperty('crt.visible', true)
        elseif audioQuality == 3 then
            playSound('inst16', 1, 'inst', false)
            playSound('egg16', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale3')
            triggerEvent('Change Character', 'bf', 'egg-finale3')

            setProperty('2B1.visible', false)
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', true)
            setProperty('3B2.visible', true)
            setProperty('3B3.visible', true)
            setProperty('3B4.visible', true)
            setProperty('3B5.visible', true)
            setProperty('3G.visible', true)

            setProperty('1G.visible', false)
            setProperty('1B.visible', true)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', false)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)

            setProperty('crt.visible', true)
        elseif audioQuality == 4 then
            playSound('inst22', 1, 'inst', false)
            playSound('egg22', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale4')
            triggerEvent('Change Character', 'bf', 'egg-finale4')

            setProperty('2B1.visible', false)
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1B.visible', false)
            setProperty('1G.visible', false)

            setProperty('4B1.visible', true)
            setProperty('4B2.visible', true)
            setProperty('4B3.visible', true)
            setProperty('4G.visible', true)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', false)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)


            setProperty('crt.visible', false)
        elseif audioQuality == 5 then
            playSound('inst32', 1, 'inst', false)
            playSound('egg32', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale5')
            triggerEvent('Change Character', 'bf', 'egg-finale5')

            setProperty('2B1.visible', false)
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1B.visible', false)
            setProperty('1G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', true)
            setProperty('5B.visible', true)

            setProperty('6.visible', false)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)

            setProperty('crt.visible', false)
        elseif audioQuality == 6 then
            playSound('inst44', 1, 'inst', false)
            playSound('egg44', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale6')
            triggerEvent('Change Character', 'bf', 'egg-finale6')

            setProperty('2B1.visible', false)
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1B.visible', false)
            setProperty('1G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', true)

            setProperty('0.visible', false)
            setProperty('crt4by3.visible', false)
            setProperty('4by3.visible', false)

            setProperty('crt.visible', false)
        elseif audioQuality == 0 then
            playSound('inst8', 1, 'inst', false)
            playSound('egg8', 1, 'voices', false)

            triggerEvent('Change Character', 'Dad', 'huy-finale0')
            triggerEvent('Change Character', 'bf', 'egg-finale0')

            setProperty('2B1.visible', false)
            setProperty('2B2.visible', false)
            setProperty('2B3.visible', false)
            setProperty('2B4.visible', false)
            setProperty('2B5.visible', false)
            setProperty('2G.visible', false)

            setProperty('3B1.visible', false)
            setProperty('3B2.visible', false)
            setProperty('3B3.visible', false)
            setProperty('3B4.visible', false)
            setProperty('3B5.visible', false)
            setProperty('3G.visible', false)

            setProperty('1B.visible', false)
            setProperty('1G.visible', false)

            setProperty('4B1.visible', false)
            setProperty('4B2.visible', false)
            setProperty('4B3.visible', false)
            setProperty('4G.visible', false)

            setProperty('5G.visible', false)
            setProperty('5B.visible', false)

            setProperty('6.visible', false)

            setProperty('0.visible', true)
            setProperty('crt4by3.visible', true)
            setProperty('4by3.visible', true)

            setProperty('crt.visible', true)

            setProperty('healthBar.visible', false)
            setProperty('scoreTxt.visible', false)
            setProperty('timeTxt.visible', false)
            setProperty('timeBar.visible', false)

            noteTweenAlpha('hideHUD0', 0, 0, 0.000000001, 'linear')
            noteTweenAlpha('hideHUD1', 1, 0, 0.000000001, 'linear')
            noteTweenAlpha('hideHUD2', 2, 0, 0.000000001, 'linear')
            noteTweenAlpha('hideHUD3', 3, 0, 0.000000001, 'linear')

            if curStep > 1350 then -- on the final one we can hide hud
                noteTweenAlpha('hi123123HUD0', 4, 0, 0.000000001, 'linear')
                noteTweenAlpha('hi123123HUD1', 5, 0, 0.000000001, 'linear')
                noteTweenAlpha('hi123123HUD2', 6, 0, 0.000000001, 'linear')
                noteTweenAlpha('hi123123HUD3', 7, 0, 0.000000001, 'linear')
            end

            noteTweenX('middasdroll', 4, 412, 0.000000001, 'linear') 
            noteTweenX('middasdrolm', 5, 524, 0.000000001, 'linear') 
            noteTweenX('middasdroln', 6, 636, 0.000000001, 'linear') 
            noteTweenX('middasdrolo', 7, 748, 0.000000001, 'linear') 
        end

        if audioQuality == 1 or audioQuality == 2 or audioQuality == 3 or audioQuality == 4 or audioQuality == 5 or audioQuality == 6 then -- if it aint broke, dont fix it.
            setProperty('healthBar.visible', true)
            setProperty('scoreTxt.visible', true)
            setProperty('timeTxt.visible', true)
            setProperty('timeBar.visible', true)

            noteTweenAlpha('showHUD231', 0, 1, 0.000000001, 'linear')
            noteTweenAlpha('showHUD232', 1, 1, 0.000000001, 'linear')
            noteTweenAlpha('showHUD233', 2, 1, 0.000000001, 'linear')
            noteTweenAlpha('showHUD234', 3, 1, 0.000000001, 'linear')

            noteTweenX('noeNormaerhrtEvent4', 4, defaultPlayerStrumX0, 0.000000001, 'linear')
            noteTweenX('noteNormredhgEvent5', 5, defaultPlayerStrumX1, 0.000000001, 'linear')
            noteTweenX('noteNormredhgEvent6', 6, defaultPlayerStrumX2, 0.000000001, 'linear')
            noteTweenX('noteNormredhgEvent7', 7, defaultPlayerStrumX3, 0.000000001, 'linear')
        end

        triggerEvent('Change Note Skin', 'notes' .. audioQuality, 'notes-splashes' .. audioQuality) -- the reason why i dont just put the code here is because i have no idea how this works ;-;

        setSoundTime('inst', getSongPosition())   -- inst  sync
        setSoundTime('voices', getSongPosition()) -- vocal sync
    end
end

function onSectionHit() -- wow low fps fixes finally in the big 4.2
    sectionNum = sectionNum + 1

    if sectionNum == 5 then
        setSoundTime('inst', getSongPosition())   -- inst  sync
        setSoundTime('voices', getSongPosition()) -- vocal sync

        sectionNum = 0
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'quality-fade' then
        setProperty('qualityFADE.x', -42000)

        doTweenAlpha('quality-fadeEND', 'qualityFADE', 1, 0.00000001)
        print('Blast Processing: Finished changing quality to ' .. audioQuality .. '.')
    end
end


function onEvent(name, value1, value2)--  not by scrambled_egg3 v
    if name == 'Change Note Skin' then--  https://gamebanana.com/questions/22595
        if value1 == '' then
        else
            for i = 0, getProperty('opponentStrums.length')-1 do
                setPropertyFromGroup('opponentStrums', i, 'texture', value1);
            end
            for i = 0, getProperty('unspawnNotes.length')-1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
                    setPropertyFromGroup('unspawnNotes', i, 'texture', value1);
                end
            end
            for i = 0, getProperty('playerStrums.length')-1 do
                setPropertyFromGroup('playerStrums', i, 'texture', value1);
            end
            for i = 0, getProperty('unspawnNotes.length')-1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                    if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= 'Ring Note' then
                        setPropertyFromGroup('unspawnNotes', i, 'texture', value1);
                    end
                end
            end
        end
    
        if value2 == '' then
        else
            for i = 0, getProperty('unspawnNotes.length')-1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
                    if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= 'Ring Note' then
                        setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', value2);
                    end
                end
            end
            for i = 0, getProperty('unspawnNotes.length')-1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                    if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= 'Ring Note' then
                        setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', value2);
                    end
                end
            end
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'qualitychange' then
        canAudioQualityChange = true
    end
end