isDebugging = false
hasHiddenRivalry = false

-- by scrambled_egg3 (except for the event thingy)

-- middlescroll's strumX: -278
-- normal's       strumX: 42

-- downscroll's   strumY: 570
-- upscrolls's    strumY: 50

-- each note is 120 pixels apart

function onStartCountdown()
    if middlescroll or downscroll then
        makeLuaText('RetryText', 'Please disable middlescroll and/or downscroll. Press any key to exit.', 1280, 0, 500)
        setTextAlignment('RetryText')
        setTextSize('RetryText', 30)
        addLuaText('RetryText')
        return Function_Stop;
    end
end

function onCreate()
    makeLuaSprite('blackStartingCover', 'black', 0, 0)
    scaleObject('blackStartingCover', 10, 10)
    setObjectCamera('blackStartingCover', 'hud')
    addLuaSprite('blackStartingCover', true)

    makeLuaSprite('rivalry', 'the-redguy-rivalry', 200, 100)
    scaleObject('rivalry', 1, 1)
    setObjectCamera('rivalry', 'hud')
    addLuaSprite('rivalry', true)
    doTweenAlpha('rivalryFadeThatsNotLowTaperBecauseItsNotFunnyAnymore', 'rivalry', 0, 0.00000000001)

    --addLuaScript('mods/scrambled_egg/stages/test')
    --addLuaScript('mods/scrambled_egg/stages/testwallpaper')

    if not middlescroll or downscroll then
        makeLuaText('curStepText', 'test', '1280')
        setTextAlignment('curStepText')
        setTextSize('curStepText', 50)
    end

    if isDebugging then -- this isn't for errors i just like step counter
        addLuaText('curStepText')
    end
end

function onUpdate(elapsed)
    if middlescroll or downscroll then
        if keyboardPressed('ANY') then
            endSong()
        end
    end

    setTextString('curStepText', curStep)

    --debugPrint('o1: ' .. defaultOpponentStrumX0 .. ' o2: ' .. defaultOpponentStrumX1 .. ' o3: ' .. defaultOpponentStrumX2 .. ' o4: ' .. defaultOpponentStrumX3)
end

function onSongStart()
    doTweenAlpha('blackStartingCoverFadeOut', 'blackStartingCover', 0, 1)
    doTweenAlpha('rivalryFadeThatsNotLowTaperBecauseItsNotFunnyAnymore1', 'rivalry', 1, 1)
end

function onStepHit()
    if not downscroll then
        if curStep > 128 then
            if not hasHiddenRivalry then
                hasHiddenRivalry = true
                doTweenAlpha('rivalryFadeThatsNotLowTaperBecauseItsNotFunnyAnymore2', 'rivalry', 0, 1)
            end
        end

        if curStep == 560 then
            noteTweenAngle('noteTweenRotateFun1', 4, 360, crochet / 250, 'linear')
            noteTweenAngle('noteTweenRotateFun2', 5, 360, crochet / 250, 'linear')
            noteTweenAngle('noteTweenRotateFun3', 6, 360, crochet / 250, 'linear')
            noteTweenAngle('noteTweenRotateFun4', 7, 360, crochet / 250, 'linear')
        end

        if curStep == 336 then
            noteTweenX('noteTween336-1x', 4, defaultPlayerStrumX3, 1, 'quartOut')
            noteTweenX('noteTween336-2x', 5, defaultPlayerStrumX2, 1, 'quartOut')
            noteTweenX('noteTween336-3x', 6, defaultPlayerStrumX1, 1, 'quartOut')
            noteTweenX('noteTween336-4x', 7, defaultPlayerStrumX0, 1, 'quartOut')

            noteTweenAngle('noteTween336-1A', 4, 180, 1, 'quartOut')
            noteTweenAngle('noteTween336-2A', 5, 180, 1, 'quartOut')
            noteTweenAngle('noteTween336-3A', 6, 180, 1, 'quartOut')
            noteTweenAngle('noteTween336-4A', 7, 180, 1, 'quartOut')
        end

        if curStep == 400 then
            noteTweenX('noteTween400-1x', 4, defaultPlayerStrumX0, 1, 'quartOut')
            noteTweenX('noteTween400-2x', 5, defaultPlayerStrumX1, 1, 'quartOut')
            noteTweenX('noteTween400-3x', 6, defaultPlayerStrumX2, 1, 'quartOut')
            noteTweenX('noteTween400-4x', 7, defaultPlayerStrumX3, 1, 'quartOut')

            noteTweenAngle('noteTween400-1A', 4, 0, 1, 'quartOut')
            noteTweenAngle('noteTween400-2A', 5, 0, 1, 'quartOut')
            noteTweenAngle('noteTween400-3A', 6, 0, 1, 'quartOut')
            noteTweenAngle('noteTween400-4A', 7, 0, 1, 'quartOut')
        end

        if curStep == 423 then
            noteTweenX('noteTween423-1x', 4, 412, 1, 'quartOut') 
            noteTweenX('noteTween423-2x', 5, 524, 1, 'quartOut') 
            noteTweenX('noteTween423-3x', 6, 636, 1, 'quartOut') 
            noteTweenX('noteTween423-4x', 7, 748, 1, 'quartOut') 

            noteTweenY('noteTween423-1y', 4, defaultPlayerStrumY0 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-2y', 5, defaultPlayerStrumY1 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-3y', 6, defaultPlayerStrumY2 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-4y', 7, defaultPlayerStrumY3 + 300, 1, 'quartOut')

            noteTweenDirection('noteTween423-1D', 4, -90, 1, 'quartOut')
            noteTweenDirection('noteTween423-2D', 5, 180, 1, 'quartOut')
            noteTweenDirection('noteTween423-3D', 6, 0, 1, 'quartOut')
            noteTweenDirection('noteTween423-4D', 7, 90, 1, 'quartOut')
        end

        if curStep == 560 then
            noteTweenX('noteTween560-1x2', 4, 412, 1, 'quartOut') 
            noteTweenX('noteTween560-2x2', 5, 524, 1, 'quartOut') 
            noteTweenX('noteTween560-3x2', 6, 636, 1, 'quartOut') 
            noteTweenX('noteTween560-4x2', 7, 748, 1, 'quartOut') 

            noteTweenY('noteTween560-1y', 4, defaultPlayerStrumY0, 1, 'quartOut')
            noteTweenY('noteTween560-2y', 5, defaultPlayerStrumY1, 1, 'quartOut')
            noteTweenY('noteTween560-3y', 6, defaultPlayerStrumY2, 1, 'quartOut')
            noteTweenY('noteTween560-4y', 7, defaultPlayerStrumY3, 1, 'quartOut')

            noteTweenDirection('noteTween560-1D', 4, 90, 1, 'quartOut')
            noteTweenDirection('noteTween560-2D', 5, 90, 1, 'quartOut')
            noteTweenDirection('noteTween560-3D', 6, 90, 1, 'quartOut')
            noteTweenDirection('noteTween560-4D', 7, 90, 1, 'quartOut')

            noteTweenAlpha('modChartsRivals0', 0, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals1', 1, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals2', 2, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals3', 3, 0.5, 1, 'quartOut')

            noteTweenX('noteTween560-1x', 0, 82, 1, 'quartOut')
            noteTweenX('noteTween560-2x', 1, 194, 1, 'quartOut')
            noteTweenX('noteTween560-3x', 2, 971, 1, 'quartOut')
            noteTweenX('noteTween560-4x', 3, 1083, 1, 'quartOut')
        end

        if curStep == 656 then
            noteTweenX('noteTween656-1x2', 0, 412, 1, 'quartOut') 
            noteTweenX('noteTween656-2x2', 1, 524, 1, 'quartOut') 
            noteTweenX('noteTween656-3x2', 2, 636, 1, 'quartOut') 
            noteTweenX('noteTween656-4x2', 3, 748, 1, 'quartOut') 

            noteTweenAlpha('modChartsRivals0', 0, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals1', 1, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals2', 2, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals3', 3, 1, 1, 'quartOut')

            noteTweenAlpha('modChartsRivals4', 4, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals5', 5, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals6', 6, 0.5, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals7', 7, 0.5, 1, 'quartOut')

            noteTweenX('noteTween656-1x', 4, 82, 1, 'quartOut')
            noteTweenX('noteTween656-2x', 5, 194, 1, 'quartOut')
            noteTweenX('noteTween656-3x', 6, 971, 1, 'quartOut')
            noteTweenX('noteTween656-4x', 7, 1083, 1, 'quartOut')
        end

        if curStep == 784 then
            noteTweenX('noteTween784-1x2', 0, defaultPlayerStrumX0, crochet / 250, 'quartOut') 
            noteTweenX('noteTween784-2x2', 1, defaultPlayerStrumX1, crochet / 250, 'quartOut') 
            noteTweenX('noteTween784-3x2', 2, defaultPlayerStrumX2, crochet / 250, 'quartOut') 
            noteTweenX('noteTween784-4x2', 3, defaultPlayerStrumX3, crochet / 250, 'quartOut') 

            noteTweenAlpha('modChartsRivals0', 0, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals1', 1, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals2', 2, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals3', 3, 1, 1, 'quartOut')

            noteTweenAlpha('modChartsRivals4', 4, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals5', 5, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals6', 6, 1, 1, 'quartOut')
            noteTweenAlpha('modChartsRivals7', 7, 1, 1, 'quartOut')

            noteTweenX('noteTween784-1x', 4, defaultOpponentStrumX0, crochet / 250, 'quartOut')
            noteTweenX('noteTween784-2x', 5, defaultOpponentStrumX1, crochet / 250, 'quartOut')
            noteTweenX('noteTween784-3x', 6, defaultOpponentStrumX2, crochet / 250, 'quartOut')
            noteTweenX('noteTween784-4x', 7, defaultOpponentStrumX3, crochet / 250, 'quartOut')
        end

        if curStep == 848 then
            noteTweenY('noteTween848-1x', 4, 570, 1, 'quartOut')
            noteTweenY('noteTween848-2x', 5, 570, 1, 'quartOut')
            noteTweenY('noteTween848-3x', 6, 570, 1, 'quartOut')
            noteTweenY('noteTween848-4x', 7, 570, 1, 'quartOut')

            noteTweenDirection('noteTween848-1D', 4, -90, 1, 'quartOut')
            noteTweenDirection('noteTween848-2D', 5, -90, 1, 'quartOut')
            noteTweenDirection('noteTween848-3D', 6, -90, 1, 'quartOut')
            noteTweenDirection('noteTween848-4D', 7, -90, 1, 'quartOut')
        end

        if curStep == 912 then
            noteTweenY('noteTween912-1y', 4, 50, 1, 'quartOut')
            noteTweenY('noteTween912-2y', 5, 50, 1, 'quartOut')
            noteTweenY('noteTween912-3y', 6, 50, 1, 'quartOut')
            noteTweenY('noteTween912-4y', 7, 50, 1, 'quartOut')

            noteTweenX('noteTween912-3x', 6, 899, 1, 'quartOut')

            noteTweenAlpha('noteTween912-1A', 4, 0, 1)
            noteTweenAlpha('noteTween912-2A', 5, 0, 1)
            noteTweenAlpha('noteTween912-4A', 7, 0, 1)

            noteTweenDirection('noteTween912-1D', 4, 90, 1, 'quartOut')
            noteTweenDirection('noteTween912-2D', 5, 90, 1, 'quartOut')
            noteTweenDirection('noteTween912-3D', 6, 90, 1, 'quartOut')
            noteTweenDirection('noteTween912-4D', 7, 90, 1, 'quartOut')
        end

        if curStep == 976 then
            noteTweenY('noteTween976-1y', 4, 600, 1, 'quartOut')
            noteTweenY('noteTween976-2y', 5, 0, 1, 'quartOut')
            noteTweenY('noteTween976-3y', 6, 600, 1, 'quartOut')
            noteTweenY('noteTween976-4y', 7, 0, 1, 'quartOut')

            noteTweenX('noteTween976-1x', 4, 0, 1, 'quartOut')
            noteTweenX('noteTween976-2x', 5, 0, 1, 'quartOut')
            noteTweenX('noteTween976-3x', 6, 1160, 1, 'quartOut')
            noteTweenX('noteTween976-4x', 7, 1160, 1, 'quartOut')

            noteTweenX('noteTween976-1x3', 0, 412, 1, 'quartOut') 
            noteTweenX('noteTween976-2x3', 1, 524, 1, 'quartOut') 
            noteTweenX('noteTween976-3x3', 2, 636, 1, 'quartOut') 
            noteTweenX('noteTween976-4x3', 3, 748, 1, 'quartOut') 

            noteTweenAlpha('noteTween976-1A', 4, 1, 1)
            noteTweenAlpha('noteTween976-2A', 5, 1, 1)
            noteTweenAlpha('noteTween976-4A', 7, 1, 1)

            noteTweenDirection('noteTween976-3D', 4, -90, 1, 'quartOut')
            noteTweenDirection('noteTween976-4D', 6, -90, 1, 'quartOut')
        end

        if curStep == 1104 then
            noteTweenX('noteTween423-1x', 4, 412, 1, 'quartOut') 
            noteTweenX('noteTween423-2x', 5, 524, 1, 'quartOut') 
            noteTweenX('noteTween423-3x', 6, 636, 1, 'quartOut') 
            noteTweenX('noteTween423-4x', 7, 748, 1, 'quartOut') 

            noteTweenY('noteTween423-1y', 4, defaultPlayerStrumY0 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-2y', 5, defaultPlayerStrumY1 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-3y', 6, defaultPlayerStrumY2 + 300, 1, 'quartOut')
            noteTweenY('noteTween423-4y', 7, defaultPlayerStrumY3 + 300, 1, 'quartOut')

            noteTweenAlpha('noteTween1104-1A', 0, 0, 1)
            noteTweenAlpha('noteTween1104-2A', 1, 0, 1)
            noteTweenAlpha('noteTween1104-3A', 2, 0, 1)
            noteTweenAlpha('noteTween1104-4A', 3, 0, 1)

            noteTweenX('noteTween1104-1x3', 0, defaultOpponentStrumX0, 1, 'quartOut') 
            noteTweenX('noteTween1104-2x3', 1, defaultOpponentStrumX1, 1, 'quartOut') 
            noteTweenX('noteTween1104-3x3', 2, defaultOpponentStrumX2, 1, 'quartOut') 
            noteTweenX('noteTween1104-4x3', 3, defaultOpponentStrumX3, 1, 'quartOut') 

            noteTweenDirection('noteTween1104-1D', 4, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-2D', 5, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-3D', 6, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-4D', 7, 450, 1, 'linear')
        end

        if curStep == 1232 then
            noteTweenY('noteTween423-1z', 4, defaultPlayerStrumY0, 1, 'quartOut')
            noteTweenY('noteTween423-2z', 5, defaultPlayerStrumY1, 1, 'quartOut')
            noteTweenY('noteTween423-3z', 6, defaultPlayerStrumY2, 1, 'quartOut')
            noteTweenY('noteTween423-4z', 7, defaultPlayerStrumY3, 1, 'quartOut')

            noteTweenX('noteTween423-1y', 4, 412, 1, 'quartOut')
            noteTweenX('noteTween423-2y', 5, 524, 1, 'quartOut')
            noteTweenX('noteTween423-3y', 6, 636, 1, 'quartOut')
            noteTweenX('noteTween423-4y', 7, 748, 1, 'quartOut')

            noteTweenX('noteTween423-1B', 0, 412, 1, 'quartOut')
            noteTweenX('noteTween423-2B', 1, 524, 1, 'quartOut')
            noteTweenX('noteTween423-3B', 2, 636, 1, 'quartOut')
            noteTweenX('noteTween423-4B', 3, 748, 1, 'quartOut')

            noteTweenAlpha('noteTween423-1A', 0, 0.35, 1)
            noteTweenAlpha('noteTween423-2A', 1, 0.35, 1)
            noteTweenAlpha('noteTween423-3A', 2, 0.35, 1)
            noteTweenAlpha('noteTween423-4A', 3, 0.35, 1)
        end
    else

    end
end

function onTweenCompleted(tag, vars)
    if tag == 'noteTween1232-4A' then
        noteTweenAlpha('noteTween1232-4AB', 4, 1, 1)
        noteTweenAlpha('noteTween1232-5AB', 5, 1, 1)
        noteTweenAlpha('noteTween1232-6AB', 6, 1, 1)
        noteTweenAlpha('noteTween1232-7AB', 7, 1, 1)
    end

    if tag == 'noteTween1232-4AB' then
        if curStep < 1360 then
            noteTweenAlpha('noteTween1232-4A', 4, 0, 1)
            noteTweenAlpha('noteTween1232-5A', 5, 0, 1)
            noteTweenAlpha('noteTween1232-6A', 6, 0, 1)
            noteTweenAlpha('noteTween1232-7A', 7, 0, 1)
        end
    end

    if tag == 'noteTween1104-1D' then
        noteTweenDirection('noteTween1104-1D2', 4, 90, 0.0000000000001, 'linear')
        noteTweenDirection('noteTween1104-2D2', 5, 90, 0.0000000000001, 'linear')
        noteTweenDirection('noteTween1104-3D2', 6, 90, 0.0000000000001, 'linear')
        noteTweenDirection('noteTween1104-4D2', 7, 90, 0.0000000000001, 'linear')
    end

    if tag == 'noteTween1104-1D2' then
        if curStep < 1232 then
            noteTweenDirection('noteTween1104-1D', 4, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-2D', 5, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-3D', 6, 450, 1, 'linear')
            noteTweenDirection('noteTween1104-4D', 7, 450, 1, 'linear')
        end
    end

    if tag == 'noteTweenRotateFun1' then
        noteTweenAngle('noteTweenRotateFun5', 4, 0, 0.0000000000001, 'linear')
        noteTweenAngle('noteTweenRotateFun6', 5, 0, 0.0000000000001, 'linear')
        noteTweenAngle('noteTweenRotateFun7', 6, 0, 0.0000000000001, 'linear')
        noteTweenAngle('noteTweenRotateFun8', 7, 0, 0.0000000000001, 'linear')
    end

    if tag == 'noteTweenRotateFun5' then
        noteTweenAngle('noteTweenRotateFun1', 4, 360, crochet / 250, 'linear')
        noteTweenAngle('noteTweenRotateFun2', 5, 360, crochet / 250, 'linear')
        noteTweenAngle('noteTweenRotateFun3', 6, 360, crochet / 250, 'linear')
        noteTweenAngle('noteTweenRotateFun4', 7, 360, crochet / 250, 'linear')
    end

    if tag == 'noteTween784-1x' then
        noteTweenX('noteTween784-1xx', 4, defaultPlayerStrumX0, crochet / 250, 'linear')
        noteTweenX('noteTween784-2xx', 5, defaultPlayerStrumX1, crochet / 250, 'linear')
        noteTweenX('noteTween784-3xx', 6, defaultPlayerStrumX2, crochet / 250, 'linear')
        noteTweenX('noteTween784-4xx', 7, defaultPlayerStrumX3, crochet / 250, 'linear')

        noteTweenX('noteTween784-1x2', 0, defaultOpponentStrumX0, crochet / 250, 'linear') 
        noteTweenX('noteTween784-2x2', 1, defaultOpponentStrumX1, crochet / 250, 'linear') 
        noteTweenX('noteTween784-3x2', 2, defaultOpponentStrumX2, crochet / 250, 'linear') 
        noteTweenX('noteTween784-4x2', 3, defaultOpponentStrumX3, crochet / 250, 'linear') 
    end

    if tag == 'noteTween784-1xx' then
        if curStep < 848 then
            noteTweenX('noteTween784-1x', 4, defaultOpponentStrumX0, crochet / 250, 'linear')
            noteTweenX('noteTween784-2x', 5, defaultOpponentStrumX1, crochet / 250, 'linear')
            noteTweenX('noteTween784-3x', 6, defaultOpponentStrumX2, crochet / 250, 'linear')
            noteTweenX('noteTween784-4x', 7, defaultOpponentStrumX3, crochet / 250, 'linear')

            noteTweenX('noteTween784-1x2', 0, defaultPlayerStrumX0, crochet / 250, 'linear') 
            noteTweenX('noteTween784-2x2', 1, defaultPlayerStrumX1, crochet / 250, 'linear') 
            noteTweenX('noteTween784-3x2', 2, defaultPlayerStrumX2, crochet / 250, 'linear') 
            noteTweenX('noteTween784-4x2', 3, defaultPlayerStrumX3, crochet / 250, 'linear') 
        end
    end
end