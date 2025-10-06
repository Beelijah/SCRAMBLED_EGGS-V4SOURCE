local IsmousePressed = false
local loopa = 1
local loopaStart = 0
local circleSize = 0.5
local shouldBeRemovingArt = false
local secondsNotWriting = 0
local framesNotWriting = 0
local hasWritten = 0
local bgMoveTime = 10
local spotlightMoveTime = 3

local moveSpotlightX = 267
local moveSpotlightY = -345

local moddingText = hello

local correctDraws = 0
local incorrectDraws = 0

function onCreate()
    setProperty('spotlight.visible', false)
    setProperty('paperremind.visible', false)
    doTweenY('paperreminderoffset', 'paperremind', 360, 0.00001, 'linear')

    doTweenX('moveSpotlight', 'spotlight', moveSpotlightX, spotlightMoveTime, 'quartOut')
    doTweenY('moveSpotlight2', 'spotlight', moveSpotlightY, spotlightMoveTime, 'quartOut')
    
    --setProperty('otherScreenBG.x', 445)
    --setProperty('otherScreenBG2.x', -450)

    --doTweenX('screenBGxTween', 'otherScreenBG', 1343, bgMoveTime, 'linear')
    --doTweenX('screenBGxTween2', 'otherScreenBG2', 450, bgMoveTime, 'linear')


    --setProperty('bfBG.x', -44)
    --setProperty('bfBG2.x', -925)

    --doTweenY('screenBGxTween3', 'bfBG', 837, bgMoveTime, 'linear')
    --doTweenY('screenBGxTween4', 'bfBG2', -44, bgMoveTime, 'linear')
end

function onCountdownStarted()
    local value2 = 0.001

    --debugPrint('            lX: ' .. defaultPlayerStrumX0 .. ' dX: ' .. defaultPlayerStrumX1 .. ' uX: ' .. defaultPlayerStrumX2 .. ' rX: ' .. defaultPlayerStrumX3 .. '        bye')

    makeLuaSprite('moddingMouse', 'Mouse')
    setObjectCamera('moddingMouse', 'hud')
    addLuaSprite('moddingMouse', true)

    scaleObject('moddingMouse', 0.5, 0.5, true)

    doTweenAlpha('hideHUDthingy2', 'iconP1', 0, value2, 'linear')
    doTweenAlpha('hideHUDthingy3', 'iconP2', 0, value2, 'linear')

    noteTweenAlpha('hideHUDnotes0', 0, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes1', 1, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes2', 2, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes3', 3, 0, 0.001, 'linear')

    noteTweenX('middlescroll', 4, 412, value2, 'linear') 
    noteTweenX('middlescrolm', 5, 524, value2, 'linear') 
    noteTweenX('middlescroln', 6, 636, value2, 'linear') 
    noteTweenX('middlescrolo', 7, 748, value2, 'linear') 

    noteTweenY('hideTHEopponent', 0, 1000, value2, 'linear') 
    noteTweenY('hideTHEopponenu', 1, 1000, value2, 'linear') 
    noteTweenY('hideTHEopponenv', 2, 1000, value2, 'linear') 
    noteTweenY('hideTHEopponenw', 3, 1000, value2, 'linear') 
end

function onUpdate(elapsed)
    local mouseX = 0
    local mouseY = 0
    local debugKeyPressed = false
    local circleNameTMP = 'circle' .. loopaStart
    local paperY = 0
    local cameraX
    local cameraY
    local circleSkin
    paperY = getProperty('paper.y')

    cameraX = getCameraFollowX()
    cameraY = getCameraFollowY()

    circleSkin = 'littleCircleBlue' -- changed to remove issues with v4

    --print('cameraX: ', cameraX, ' cameraY: ', cameraY)

    if paperY > 850 then -- checks whether paper is off-screen or on-screen
        shouldBeRemovingArt = true
    else
        shouldBeRemovingArt = false
    end

    if curStep == 765 then
        doTweenAlpha('GFinstantFadeOut', 'gf', 0, 0.00000001, 'linear')
    end

    if curStep == 768 then
        doTweenAlpha('GFslowlyFadeIn', 'gf', 1, 14, 'linear')
        setProperty('camZooming', false)
        doTweenZoom('CamZoomIn', 'game', 1.35, 14, 'linear')
    end

    if curStep > 767 then
        if curStep < 912 then
            setCameraFollowPoint(1062, 464)
        end
    end

    if curStep == 912 then
        doTweenZoom('CamZoomOut', 'game', 0.67, 0.00000001, 'linear')
        setProperty('camZooming', true)
        setCameraFollowPoint(912, 684)
    end

    if curStep > 975 then
        if curStep < 1104 then
            setProperty('spotlight.visible', true)
        else
            doTweenAlpha('hideSpotlight', 'spotlight', 0, 1, 'quartOut')
        end
    end

    circleName = 'circle' .. loopa

    --debugPrint('circleName: ' .. circleName .. ' circleNameTMP: ' .. circleNameTMP)

    mouseX = getMouseX('hud')
    mouseY = getMouseY('hud')

    --debugPrint('mouseX: ' .. mouseX .. ' mouseY: ' .. mouseY)

    setProperty('moddingMouse.x', mouseX)
    setProperty('moddingMouse.y', mouseY)

    IsmousePressed = mousePressed()
    debugKeyPressed = keyPressed('back')

    if not inGameOver then
        if not shouldBeRemovingArt then
            if not IsmousePressed then
                framesNotWriting = framesNotWriting + 1
                secondsNotWriting = framesNotWriting / framerate
                --print('frames not writing: ', framesNotWriting, ' has written: ', hasWritten, ' seconds not writing: ', secondsNotWriting)
            else
                framesNotWriting = 0
                secondsNotWriting = 0
                hasWritten = 1
            end
        end
    end

    if secondsNotWriting > 30 then
        setHealth(0)
    elseif hasWritten == 1 then
        setProperty('paperremind.visible', false)
    elseif secondsNotWriting > 10 then
        if hasWritten == 0 then
            setProperty('paperremind.visible', true)
    elseif secondsNotWriting < 10 or hasWritten == 1 then
        setProperty('paperremind.visible', false)
        end
    end

    if shouldBeRemovingArt then 
        if loopaStart == loopa then
        else
            circleNameTMP = 'circle' .. loopaStart
            print('circleNameTMP: ', circleNameTMP)
            removeLuaSprite('circle' .. loopaStart, false)
            loopaStart = loopaStart + 1
        end
    end

    if IsmousePressed then
        if not shouldBeRemovingArt then 
            if mouseX > 382 and mouseX < 860 and mouseY > 415 and mouseY < 600 then
                loopa = loopa + 1

                makeLuaSprite(circleName, circleSkin, mouseX + 10, mouseY) -- tl;dr: make a million circles when mouse is clicked and in paper box
                addLuaSprite(circleName, true)
                setObjectCamera(circleName, 'hud')
                scaleObject(circleName, circleSize, circleSize, true)

                removeLuaSprite('moddingMouse', false)
                makeLuaSprite('moddingMouse', 'Mouse')
                setObjectCamera('moddingMouse', 'hud')
                addLuaSprite('moddingMouse', true)
                scaleObject('moddingMouse', 0.5, 0.5, true)
                setProperty('moddingMouse.x', mouseX)
                setProperty('moddingMouse.y', mouseY)
            end
        end
    end

    if debugKeyPressed then -- basically if you press backspace it also erases :D
        if not shouldBeRemovingArt then 
            if loopaStart == loopa then
                print('stop ;(')
            else
                circleNameTMP = 'circle' .. loopaStart
                print('circleNameTMP: ', circleNameTMP)
                removeLuaSprite('circle' .. loopaStart, false)
                loopaStart = loopaStart + 1
            end
        end
    end
end

function onEvent(name, value1, value2)
    if name == 'Write' then
        if value1 == 1 then
            correctDraws = 0
            incorrectDraws = 0

            moddingText = value2
        end
    end
end

function onCountdownTick(counter)
    noteTweenAlpha('hideHUDnotes0', 0, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes1', 1, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes2', 2, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes3', 3, 0, 0.001, 'linear')
end

function onSongStart()  
    noteTweenAlpha('hideHUDnotes0', 0, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes1', 1, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes2', 2, 0, 0.001, 'linear')
    noteTweenAlpha('hideHUDnotes3', 3, 0, 0.001, 'linear')
end

function onTweenCompleted(tag)
    if tag == 'paperComeUpMouseRefresh' then
        removeLuaSprite('moddingMouse', false)
        makeLuaSprite('moddingMouse', 'Mouse')
        setObjectCamera('moddingMouse', 'hud')
        addLuaSprite('moddingMouse', true)
        scaleObject('moddingMouse', 0.5, 0.5, true)
    elseif tag == 'screenBGxTween' then
        --setProperty('otherScreenBG.x', 445)
        --setProperty('otherScreenBG2.x', -450)

        --doTweenX('screenBGxTween', 'otherScreenBG', 1343, bgMoveTime, 'linear')
        --doTweenX('screenBGxTween2', 'otherScreenBG2', 450, bgMoveTime, 'linear')


        --setProperty('bfBG.x', -44)
        --setProperty('bfBG2.x', -925)

        --doTweenY('screenBGxTween3', 'bfBG', 837, bgMoveTime, 'linear')
        --doTweenY('screenBGxTween4', 'bfBG2', -44, bgMoveTime, 'linear')
    elseif tag == 'moveSpotlight' then

        --moveSpotLightX = math.cos(SineElap)
        --moveSpotLightY = math.sin(SineElap)

        --debugPrint('x: ' .. moveSpotLightX .. ' y: ' .. moveSpotLightY)

        --moveSpotlightX = STARTmoveSpotlightX + getRandomInt(-15, 15)
        --moveSpotlightY = STARTmoveSpotlightY + getRandomInt(-15, 15)
        
        --doTweenX('moveSpotlight', 'bfBG2', 50000, spotlightMoveTime / 8, 'quartOut')

        --doTweenX('moveSpotlight2', 'spotlight', moveSpotlightX, spotlightMoveTime, 'quartOut')
        --doTweenY('moveSpotlight3', 'spotlight', moveSpotlightY, spotlightMoveTime, 'quartOut')

        doTweenX('moveSpotlight2', 'spotlight', 282, spotlightMoveTime, 'linear')
        doTweenY('moveSpotlight3', 'spotlight', -330, spotlightMoveTime / 2, 'linear')  

    elseif tag == 'moveSpotlight2' then

        doTweenX('moveSpotlight', 'spotlight', 252, spotlightMoveTime, 'linear')
        doTweenY('moveSpotlight1', 'spotlight', -340, spotlightMoveTime / 2, 'linear')

    end
end