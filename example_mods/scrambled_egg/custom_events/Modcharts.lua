local notesJump = false
local notesBounceMillie = false
local notesGoDU = false -- true = down, false = up

-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you credit me

-- middlescroll's strumX: -278
-- normal's       strumX: 42

-- downscroll's   strumY: 570
-- upscrolls's    strumY: 50

-- each note is 120 pixels apart

function onCreate()
    if week == 'eggV2' then
        makeLuaSprite('MillieNote', 'millieNote')
        setObjectCamera('MillieNote', 'hud')
        addLuaSprite('MillieNote', true)
        scaleObject('MillieNote', 0.75, 0.75, true)
        setProperty('MillieNote.visible', false)

        makeAnimatedLuaSprite('healthBarBedrock', 'bedrock', -210, 300)
        addAnimationByPrefix('healthBarBedrock', 'placeBedrock', "bedrock", 30, false)
        addOffset('healthBarBedrock', 'placeBedrock', 0, 0)
        playAnim('healthBarBedrock', 'placeBedrock', true)
        addLuaSprite('healthBarBedrock', true)
        setObjectCamera('healthBarBedrock', 'hud')
        setProperty('healthBarBedrock.visible', false)
        setProperty('healthBarBedrock.x', -330)
        if not downscroll then
            setProperty('healthBarBedrock.y', 545)
        else
            setProperty('healthBarBedrock.y', -17)
        end
        scaleObject('healthBarBedrock', 0.35, 0.35, true)
    end
end

function onEvent(name, value1, value2)
    if name == 'Modcharts' then
        if value1 == '0' then -- just setting everything back to normal
            noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0, value2, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1, value2, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY2, value2, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY3, value2, 'quartOut')

            noteTweenX('noteNormalX.ModchartEvent4', 4, defaultPlayerStrumX0, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent5', 5, defaultPlayerStrumX1, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent6', 6, defaultPlayerStrumX2, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent7', 7, defaultPlayerStrumX3, value2, 'quartOut')
        end

        if value1 == '1' then -- left and down notes go, well, down. (or up if you're a downscroll user)

            noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY2, value2, 'quartOut') -- this sets the other half of the strum back to normal
            noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY3, value2, 'quartOut')

            if not downscroll then 
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0 + 100, value2, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1 + 100, value2, 'quartOut')

            else
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0 - 100, value2, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1 - 100, value2, 'quartOut')
            end
        end

        if value1 == '2' then -- up and right notes go down. (or up if you're a downscroll user)

            noteTweenY('noteNormalY.ModchartEvent2', 4, defaultPlayerStrumY2, value2, 'quartOut') -- this sets the other half of the strum back to normal
            noteTweenY('noteNormalY.ModchartEvent3', 5, defaultPlayerStrumY3, value2, 'quartOut')

            if not downscroll then 
                noteTweenY('noteNormalY.ModchartEvent0', 6, defaultPlayerStrumY0 + 100, value2, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 7, defaultPlayerStrumY1 + 100, value2, 'quartOut')
            else
                noteTweenY('noteNormalY.ModchartEvent0', 6, defaultPlayerStrumY0 - 100, value2, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 7, defaultPlayerStrumY1 - 100, value2, 'quartOut')
            end
        end

        if value1 == '3' then -- spread the notes
            noteTweenX('noteNormalX.ModchartEvent4', 4, defaultPlayerStrumX0 - 75, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent5', 5, defaultPlayerStrumX1 - 25, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent6', 6, defaultPlayerStrumX2 + 25, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent7', 7, defaultPlayerStrumX3 + 75, value2, 'quartOut')
        end

        if value1 == '4' then -- spread the notes more
            noteTweenX('noteNormalX.ModchartEvent4', 4, defaultPlayerStrumX0 - 150, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent5', 5, defaultPlayerStrumX1 - 50, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent6', 6, defaultPlayerStrumX2 + 50, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent7', 7, defaultPlayerStrumX3 + 150, value2, 'quartOut')
        end

        if value1 == '5' then -- hide opponent
            noteTweenAlpha('modChartNotes0', 0, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes1', 1, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes2', 2, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes3', 3, 0, value2, 'quartOut')
        end

        if value1 == '6' then -- show opponent
            noteTweenAlpha('modChartNotes0', 0, 1, value2, 'quartOut')
            noteTweenAlpha('modChartNotes1', 1, 1, value2, 'quartOut')
            noteTweenAlpha('modChartNotes2', 2, 1, value2, 'quartOut')
            noteTweenAlpha('modChartNotes3', 3, 1, value2, 'quartOut')
        end

        if value1 == '7' then
            notesJump = true
        end

        if value1 == '8' then
            notesJump = false
        end

        if value1 == '-1' then -- the end modchart, mainly just for my mod.
            noteTweenAlpha('modChartNotes0', 0, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes1', 1, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes2', 2, 0, value2, 'quartOut')
            noteTweenAlpha('modChartNotes3', 3, 0, value2, 'quartOut')

            noteTweenX('noteNormalX.ModchartEvent4', 4, 412 - 150, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent5', 5, 524 - 50, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent6', 6, 636 + 50, value2, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent7', 7, 748 + 150, value2, 'quartOut')
        end

        if value1 == '-2' then -- for "good friends" in my mod.
            notesBounceMillie = true

            noteTweenY('noteMillie.ModchartEvent0', 0, defaultOpponentStrumY0 + 1, crochet / 1000, 'linear') -- UNCOMMENT THIS!!!
        end

        if value1 == '-3' then -- for "good friends" in my mod.
            notesBounceMillie = false
        end

        if value1 == '-4' then
            setProperty('healthBarBedrock.visible', true)
            playAnim('healthBarBedrock', 'placeBedrock', true, true)

            setProperty('MillieNote.x', 275)
            setProperty('MillieNote.visible', true)
            if not downscroll then
                doTweenY('MillieTweenDownBedrock', 'MillieNote', 450, crochet / 1000, 'quartOut')
            else
                doTweenY('MillieTweenDownBedrock', 'MillieNote', -115, crochet / 1000, 'quartOut')
            end
        end

        if value1 == '-5' then -- secret middlescroll option
            noteTweenX('middlescroll', 4, 412, value2, 'linear') 
            noteTweenX('middlescrolm', 5, 524, value2, 'linear') 
            noteTweenX('middlescroln', 6, 636, value2, 'linear') 
            noteTweenX('middlescrolo', 7, 748, value2, 'linear') 
        end
    end
end


function onBeatHit()
    if notesJump or notesGoDU then -- true = down, false = up
        if not downscroll then
            if notesGoDU then
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY2, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY3, crochet / 1000, 'quartOut')
            else
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0 - 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY0 - 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY0 - 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY0 - 50, crochet / 1000, 'quartOut')
            end
        elseif downscroll then
            if notesGoDU then
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY2, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY3, crochet / 1000, 'quartOut')
            else
                noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0 + 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY0 + 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY0 + 50, crochet / 1000, 'quartOut')
                noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY0 + 50, crochet / 1000, 'quartOut')
            end       
        end

        if notesGoDU then
            notesGoDU = false
        elseif not notesGoDU then
            notesGoDU = true
        end
    end
end

        -- noteTweenY('noteNormalY.ModchartEvent0235235', 4, defaultPlayerStrumY0, crochet / 1000, 'quartOut')
        -- noteTweenY('noteNormalY.ModchartEvent1242342', 5, defaultPlayerStrumY1, crochet / 1000, 'quartOut')
        -- noteTweenY('noteNormalY.ModchartEvent2124124', 6, defaultPlayerStrumY2, crochet / 1000, 'quartOut')
        -- noteTweenY('noteNormalY.ModchartEvent3643645', 7, defaultPlayerStrumY3, crochet / 1000, 'quartOut')

function onTweenCompleted(tag)
    local hasInitMillieLoop = false
    local hasUpdatedMilleFinish = false

    if tag == 'specialMillieTweenXEND' then -- stops millie
        setProperty('MillieNote.visible', false)
    end

    if not downscroll then
        if tag == 'MillieTweenDownBedrock' then
            doTweenX('MillieTweenXBedrock', 'MillieNote', defaultPlayerStrumX1, 1.5, 'linear')
            doTweenAlpha('hideHUDthingy1123', 'iconP1', 0, 1.5, 'linear')
            doTweenAlpha('hideHUDthingy1124', 'iconP2', 0, 1.5, 'linear')
        end

        if tag == 'MillieTweenXBedrock' then
            doTweenX('MillieTweenXBedrockFinal', 'MillieNote', defaultPlayerStrumX3, 0.5, 'linear')
            doTweenY('MillieTweenYBedrock2ndFinal', 'MillieNote', 350, 0.25, 'quartOut')
        end

        if tag == 'MillieTweenYBedrock2ndFinal' then
            doTweenY('MillieTweenYBedrockFinal', 'MillieNote', 720, 0.25, 'quartOut')
        end
    else -- ^ UPSCROLL, DOWNSCROLL v
        if tag == 'MillieTweenDownBedrock' then
            doTweenX('MillieTweenXBedrock', 'MillieNote', defaultPlayerStrumX1, 1.5, 'linear')
            doTweenAlpha('hideHUDthingy1123', 'iconP1', 0, 1.5, 'linear')
            doTweenAlpha('hideHUDthingy1124', 'iconP2', 0, 1.5, 'linear')
        end

        if tag == 'MillieTweenXBedrock' then
            doTweenX('MillieTweenXBedrockFinal', 'MillieNote', defaultPlayerStrumX3, 0.5, 'linear')
            doTweenY('MillieTweenYBedrock2ndFinal', 'MillieNote', -230, 0.25, 'quartOut')
        end
    end


    if notesBounceMillie then
        if tag == 'noteMillie.ModchartEventY' then
            if not hasInitMillieLoop then
                if not downscroll then
                    doTweenY('MillieTweenUp', 'MillieNote', 0, crochet / 2000, 'linear')
                else
                    doTweenY('MillieTweenUp', 'MillieNote', 600, crochet / 2000, 'linear')
                end

                hasInitMillieLoop = true
            end
        end

        if not downscroll then
            if tag == 'MillieTweenUp' then
                doTweenY('MillieTweenDown', 'MillieNote', -75, crochet / 2000, 'quartOut')
            end
        
            if tag == 'MillieTweenDown' then
                doTweenY('MillieTweenUp', 'MillieNote', 0, crochet / 2000, 'linear')
            end
        else
            if tag == 'MillieTweenUp' then
                doTweenY('MillieTweenDown', 'MillieNote', 525, crochet / 2000, 'quartOut')
            end
        
            if tag == 'MillieTweenDown' then
                doTweenY('MillieTweenUp', 'MillieNote', 450, crochet / 2000, 'linear')
            end
        end

        hasUpdatedMillieFinish = false

        if tag == 'specialMillieTweenXspecial' then -- screen loop stuff
            setProperty('MillieNote.x', 0)

            setProperty('MillieNote.visible', true)

            doTweenX('MillieTweenXspecialasdf', 'MillieNote', defaultOpponentStrumX0, crochet / 2000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent0' then   
            noteTweenY('noteMillie.ModchartEvent1', 0, defaultOpponentStrumY0 + 75, crochet / 1000, 'quartOut')
            
            doTweenX('specialMillieTweenXspecial', 'MillieNote', 1280, crochet / 2000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 7, defaultPlayerStrumY3, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent1' then   
            noteTweenY('noteMillie.ModchartEvent2', 1, defaultOpponentStrumY1 + 75, crochet / 1000, 'quartOut')
            
            doTweenX('MillieTweenX', 'MillieNote', defaultOpponentStrumX1, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 0, defaultOpponentStrumY0, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent2' then   
            noteTweenY('noteMillie.ModchartEvent3', 2, defaultOpponentStrumY2 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultOpponentStrumX2, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 1, defaultOpponentStrumY1, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent3' then   
            noteTweenY('noteMillie.ModchartEvent4', 3, defaultOpponentStrumY3 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultOpponentStrumX3, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 2, defaultOpponentStrumY2, crochet / 1000, 'quartOut')
        end

        -- ^ OPPONENT, PLAYER v

        if tag == 'noteMillie.ModchartEvent4' then   
            noteTweenY('noteMillie.ModchartEvent5', 4, defaultPlayerStrumY0 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultPlayerStrumX0, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 3, defaultOpponentStrumY3, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent5' then   
            noteTweenY('noteMillie.ModchartEvent6', 5, defaultPlayerStrumY1 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultPlayerStrumX1, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 4, defaultPlayerStrumY0, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent6' then   
            noteTweenY('noteMillie.ModchartEvent7', 6, defaultPlayerStrumY2 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultPlayerStrumX2, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 5, defaultPlayerStrumY1, crochet / 1000, 'quartOut')
        end

        if tag == 'noteMillie.ModchartEvent7' then   
            noteTweenY('noteMillie.ModchartEvent0', 7, defaultPlayerStrumY3 + 75, crochet / 1000, 'quartOut')

            doTweenX('MillieTweenX', 'MillieNote', defaultPlayerStrumX3, crochet / 1000, 'quartOut')

            noteTweenY('noteMillie.ModchartEventY', 6, defaultPlayerStrumY2, crochet / 1000, 'quartOut')
        end
    elseif not notesBounceMillie then
        if not hasUpdatedMillieFinish then
            noteTweenY('noteNormalY.ModchartEvent0', 4, defaultPlayerStrumY0, crochet / 1000, 'quartOut') -- literally resets EVERYTHING
            noteTweenY('noteNormalY.ModchartEvent1', 5, defaultPlayerStrumY1, crochet / 1000, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent2', 6, defaultPlayerStrumY2, crochet / 1000, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent3', 7, defaultPlayerStrumY3, crochet / 1000, 'quartOut')

            noteTweenX('noteNormalX.ModchartEvent4', 4, defaultPlayerStrumX0, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent5', 5, defaultPlayerStrumX1, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent6', 6, defaultPlayerStrumX2, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEvent7', 7, defaultPlayerStrumX3, crochet / 1000, 'quartOut')

            noteTweenY('noteNormalY.ModchartEvent8', 0, defaultOpponentStrumY0, crochet / 1000, 'quartOut')
            noteTweenY('noteNormalY.ModchartEvent9', 1, defaultOpponentStrumY1, crochet / 1000, 'quartOut')
            noteTweenY('noteNormalY.ModchartEven10', 2, defaultOpponentStrumY2, crochet / 1000, 'quartOut')
            noteTweenY('noteNormalY.ModchartEven11', 3, defaultOpponentStrumY3, crochet / 1000, 'quartOut')

            noteTweenX('noteNormalX.ModchartEven12', 0, defaultOpponentStrumX0, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEven13', 1, defaultOpponentStrumX1, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEven14', 2, defaultOpponentStrumX2, crochet / 1000, 'quartOut')
            noteTweenX('noteNormalX.ModchartEven15', 3, defaultOpponentStrumX3, crochet / 1000, 'quartOut')

            cancelTween('MillieTweenUp')
            cancelTween('MillieTweenDown')
            cancelTween('MillieTweenX')

            if not downscroll then
                doTweenY('MillieTweenUp', 'MillieNote', 0, crochet / 2000, 'linear')
            else
                doTweenY('MillieTweenUp', 'MillieNote', 600, crochet / 2000, 'linear')
            end

            doTweenX('MillieTweenXEND', 'MillieNote', 1280, crochet / 1000, 'quartOut')

            hasUpdatedMillieFinish = true
        end
    end
end