local curPopup = 1
local mouseXOffset = -100
local currentlySelected = 0
local bgPopupsLoopa = 1
local bgPopupsREMOVINGLoopa = 0
local curBGpopupName = 'popupBG' .. bgPopupsLoopa
local curBGpopupType = 'pops/' .. getRandomInt(1, 5)
local date = os.date("%m/%d/%Y", os.time())
local time = os.date("%I:%M %p", os.time())

local hasPopup1 = false
local hasPopup2 = false
local hasPopup3 = false
local hasPopup4 = false
local hasPopup5 = false

function onEvent(event, value1, value2, strumTime)
    if event == 'Summon Window' then
        curPopup = getRandomInt(1, 5)

        hasPopup1 = luaSpriteExists('popup1')
        hasPopup2 = luaSpriteExists('popup2')
        hasPopup3 = luaSpriteExists('popup3')
        hasPopup4 = luaSpriteExists('popup4')
        hasPopup5 = luaSpriteExists('popup5')

        if curPopup == 1 then
            if not hasPopup1 then
                makeLuaSprite('popup1', 'pops/1')
                setObjectCamera('popup1', 'hud')

                setProperty('popup1.x', value1)
                setProperty('popup1.y', value2)

                addLuaSprite('popup1', true)

                setObjectOrder('popup1', 999)
                hasPopup1 = true
            else
                curPopup = 2
            end
        end

        if curPopup == 2 then
            if not hasPopup2 then
                makeLuaSprite('popup2', 'pops/2')
                setObjectCamera('popup2', 'hud')

                setProperty('popup2.x', value1)
                setProperty('popup2.y', value2)

                addLuaSprite('popup2', true)

                setObjectOrder('popup2', 999)
                hasPopup2 = true
            else
                curPopup = 3
            end
        end

        if curPopup == 3 then
            if not hasPopup3 then
                makeLuaSprite('popup3', 'pops/3')
                setObjectCamera('popup3', 'hud')

                setProperty('popup3.x', value1)
                setProperty('popup3.y', value2)

                addLuaSprite('popup3', true)

                setObjectOrder('popup3', 999)
                hasPopup3 = true
            else
                curPopup = 4
            end
        end

        if curPopup == 4 then
            if not hasPopup4 then
                makeLuaSprite('popup4', 'pops/4')
                setObjectCamera('popup4', 'hud')

                setProperty('popup4.x', value1)
                setProperty('popup4.y', value2)

                addLuaSprite('popup4', true)

                setObjectOrder('popup4', 999)
                hasPopup4 = true
            else
                curPopup = 5
            end
        end

        if curPopup == 5 then
            if not hasPopup5 then
                makeLuaSprite('popup5', 'pops/5')
                setObjectCamera('popup5', 'hud')

                setProperty('popup5.x', value1)
                setProperty('popup5.y', value2)

                addLuaSprite('popup5', true)

                setObjectOrder('popup5', 999)
                hasPopup5 = true
            else
                curPopup = 1
            end
        end
    end

    if event == 'Delete Window' then
        curPopup = getRandomInt(1, 5)

        if hasPopup1 then
            if curPopup == 1 then
                removeLuaSprite('popup1')
                hasPopup1 = false
            end
        else
            curPopup = 2
        end

        if hasPopup2 then
            if curPopup == 2 then
                removeLuaSprite('popup2')
                hasPopup2 = false
            end
        else
            curPopup = 3
        end

        if hasPopup3 then
            if curPopup == 3 then
                removeLuaSprite('popup3')
                hasPopup3 = false
            end
        else
            curPopup = 4
        end

        if hasPopup4 then
            if curPopup == 4 then
                removeLuaSprite('popup4')
                hasPopup4 = false
            end
        else
            curPopup = 5
        end

        if hasPopup5 then
            if curPopup == 5 then
                removeLuaSprite('popup5')
                hasPopup5 = false
            end
        else
            curPopup = 1
        end
    end
end

function onStepHit() -- i cant believe i JUST found this function after lua coding for 2 months straight
    if curStep == 2336 then
        setProperty('endCover.visible', true)
        triggerEvent('Hide HUD', '1', '4')
        doTweenAlpha('endTween', 'endCover', 1, 4)

        --doTweenAlpha('endTween2', 'moddingMouse', 0, 4) -- removed because only NASA pc can handle this
        removeLuaSprite('moddingMouse')

        doTweenAlpha('endTween3', 'popup1', 0, 4)
        doTweenAlpha('endTween4', 'popup2', 0, 4)
        doTweenAlpha('endTween5', 'popup3', 0, 4)
        doTweenAlpha('endTween6', 'popup4', 0, 4)
        doTweenAlpha('endTween7', 'popup5', 0, 4)
    end
end

function onCreate()
    makeLuaSprite('moddingMouse', 'Mouse')
    setObjectCamera('moddingMouse', 'hud')
    scaleObject('moddingMouse', 0.5, 0.5, true)
    setObjectOrder('moddingMouse', 999)
    addLuaSprite('moddingMouse', true)

    makeLuaSprite('endCover', 'Black')
    setObjectCamera('endCover', 'game')
    scaleObject('endCover', 500, 500, true)
    setObjectOrder('endCover', 999)
    addLuaSprite('endCover', true)

    setProperty('endCover.visible', false)
    doTweenAlpha('endTween', 'endCover', 0, 0.0000000000000000000000000000000000000000001)
end

function onUpdate(elapsed)
    local mouseX = 0
    local mouseY = 0
    local IsmousePressed = false

    --debugPrint('time: ' .. time .. ' date: ' .. date)

    mouseX = getMouseX('hud')
    mouseY = getMouseY('hud')

    setProperty('moddingMouse.x', mouseX)
    setProperty('moddingMouse.y', mouseY)

    IsmousePressed = mousePressed()

    if IsmousePressed then
        if objectsOverlap('moddingMouse', 'popup1') then
            if currentlySelected == 0 or currentlySelected == 1 then
                setProperty('popup1.x', mouseX + mouseXOffset)
                setProperty('popup1.y', mouseY)

                currentlySelected = 1
            end
        elseif objectsOverlap('moddingMouse', 'popup2') then
            if currentlySelected == 0 or currentlySelected == 2 then
                setProperty('popup2.x', mouseX + mouseXOffset)
                setProperty('popup2.y', mouseY)

                currentlySelected = 2
            end
        elseif objectsOverlap('moddingMouse', 'popup3') then
            if currentlySelected == 0 or currentlySelected == 3 then
                setProperty('popup3.x', mouseX + mouseXOffset)
                setProperty('popup3.y', mouseY)

                currentlySelected = 3
            end
        elseif objectsOverlap('moddingMouse', 'popup4') then
            if currentlySelected == 0 or currentlySelected == 4 then
                setProperty('popup4.x', mouseX + mouseXOffset)
                setProperty('popup4.y', mouseY)
                
                currentlySelected = 4
            end
        elseif objectsOverlap('moddingMouse', 'popup5') then
            if currentlySelected == 0 or currentlySelected == 5 then
                setProperty('popup5.x', mouseX + mouseXOffset)
                setProperty('popup5.y', mouseY)

                currentlySelected = 5
            end
        else
            currentlySelected = 0
        end
        
        if curStep < 2335 then
            removeLuaSprite('moddingMouse') -- lets pray this doesn't cause lag

            makeLuaSprite('moddingMouse', 'Mouse') -- it caused so much lag that i had to remove it from the ending fade
            setObjectCamera('moddingMouse', 'hud')
            scaleObject('moddingMouse', 0.5, 0.5, true)
            setObjectOrder('moddingMouse', 999)
            addLuaSprite('moddingMouse', true)

            mouseX = getMouseX('hud')
            mouseY = getMouseY('hud')     

            setProperty('moddingMouse.x', mouseX)
            setProperty('moddingMouse.y', mouseY)
        end
    else
        currentlySelected = 0
    end

    if curStep > 2393 then -- used to remove all the bg popups, which helps with lag spikes at the end of the song.
        bgPopupsREMOVINGLoopa = bgPopupsREMOVINGLoopa + 1
        removeLuaSprite('popupBG' .. bgPopupsREMOVINGLoopa)
    end
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if not isSustain then
        if curStep > 1423 then
            bgPopupsLoopa = bgPopupsLoopa + 1
            curBGpopupName = 'popupBG' .. bgPopupsLoopa
            curBGpopupType = 'pops/' .. getRandomInt(1, 5)

            makeLuaSprite(curBGpopupName, curBGpopupType, getRandomInt(-300, 1500), getRandomInt(-100, 750))
            setObjectCamera(curBGpopupName, 'game')

            addLuaSprite(curBGpopupName, true)

            setObjectOrder(curBGpopupName, 4)

            if getRandomInt(1, 2) == 1 then
                triggerEvent('Delete Window')
            end
        end
    end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    if not isSustain then
        if curStep > 1423 then
            bgPopupsLoopa = bgPopupsLoopa + 1
            curBGpopupName = 'popupBG' .. bgPopupsLoopa
            curBGpopupType = 'pops/' .. getRandomInt(1, 5)

            makeLuaSprite(curBGpopupName, curBGpopupType, getRandomInt(-300, 1500), getRandomInt(-100, 750))
            setObjectCamera(curBGpopupName, 'game')

            addLuaSprite(curBGpopupName, true)

            setObjectOrder(curBGpopupName, 4)

            if getRandomInt(1, 2) == 1 then
                triggerEvent('Summon Window', getRandomInt(700, 950), getRandomInt(25, 100))
            end
        end
    end
end