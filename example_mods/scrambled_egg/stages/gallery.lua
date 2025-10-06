-- wooo main menu lets go

-- i dare you to press "O" on the main menu

local fixMouseBorders = true -- fixes moving the mouse out of the 16:9 borders.     true is default
local rpcIndicator = 'roaming the menus ' -- change the rpc status when in menus.   roaming the menus
local settingsBGscrollSpeed = 10 -- scroll speed for settingsBG in seconds          10 is default
local loreBarOpacity = 0.5 -- changes the opacity of the lore bar opacity.          0.5 is default
-- ^ change these variables for fun stuff to happen

--   changing these variables do not have any effect,
-- v as they are overwritten without being read.
local currentlyUsedControl = 'mouse'
local usedKeyboardLastFrame = false
local currentlySelectedButton = 0
local allowIOCameraZooms = true
local frameLoopsGenerated = 0
local lastSelectedButton = 0
local currentScreen = 'title'
local framesGenerated = 0
local lastFrameMouse = 1
local alwaysTrue = true
local songID = 1

function onCreate()
    setProperty('boyfriend.visible', false)
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)

    setProperty('healthBar.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('boyfriend.visible', false)

    triggerEvent('updateRPC', 'looking at the gallery', false)
    syncMusic()

    makeLuaSprite('bg', 'titlebg', -125, 0)
    setObjectCamera('bg', 'hud')
    scaleObject('bg', 0.85, 0.85, true)
    setObjectOrder('bg', 49)
    addLuaSprite('bg', true)

    makeLuaSprite('trash', 'gallery/assets/oldwin-trash', 900, 125)
    setObjectCamera('trash', 'hud')
    setProperty('trash.antialiasing', false)
    scaleObject('trash', 5, 5, true)
    setObjectOrder('trash', 50)
    addLuaSprite('trash', true)

    makeLuaSprite('oldImages', 'gallery/assets/win-abstractart', 120, 125)
    setObjectCamera('oldImages', 'hud')
    scaleObject('oldImages', 1, 1, true)
    setObjectOrder('oldImages', 50)
    addLuaSprite('oldImages', true)

    makeLuaSprite('refImages', 'gallery/assets/win-art', 500, 125)
    setObjectCamera('refImages', 'hud')
    scaleObject('refImages', 1, 1, true)
    setObjectOrder('refImages', 50)
    addLuaSprite('refImages', true)

    makeLuaText('currentlySelectedText', '', 1280, 0, 375)
    setTextSize('currentlySelectedText', 64)
    setTextBorder('currentlySelectedText', 5, 'BLACK')
    addLuaText('currentlySelectedText')
    
    makeLuaSprite('playBG', 'no-modding/bgbottomDOUBLESCREEN-BLUE', -1790, -1280)--1152)
    setObjectCamera('playBG', 'hud')
    addLuaSprite('playBG', true)
    setObjectOrder('playBG', 51)
    doTweenX('playBG-xscroll', 'playBG', 0, settingsBGscrollSpeed)

    makeAnimatedLuaSprite('backMM', 'gallery/assets/backButton', 0, 520)
    setObjectCamera('backMM', 'hud')
    addAnimationByPrefix('backMM', 'back', 'back', 24, false)
    playAnim('backMM', 'back', true)
    setObjectOrder('backMM', 51)
    scaleObject('backMM', 0.75, 0.75)
    addLuaSprite('backMM')

    makeLuaText('playSelectionText', '<                   >', 1280, 0, -360)
    setTextColor('playSelectionText', 'FFFFFF')
    setTextBorder('playSelectionText', 5, '000000', 'outline')
    setTextAlignment('playSelectionText', 'center')
    setTextSize('playSelectionText', 60)
    addLuaText('playSelectionText')
    setObjectOrder('playSelectionText', 50)

    makeLuaText('playSelectedText', 'scrambled screen', 1280, 0, -360)
    setTextColor('playSelectedText', 'FFFFFF')
    setTextBorder('playSelectedText', 5, '000000', 'outline')
    setTextAlignment('playSelectedText', 'center')
    setTextSize('playSelectedText', 60)
    addLuaText('playSelectedText')
    setObjectOrder('playSelectedText', 50)

    makeLuaSprite('playSongButtonOutline', 'white', 465, -375)
    setObjectCamera('playSongButtonOutline', 'hud')
    addLuaSprite('playSongButtonOutline', true)
    setObjectOrder('playSongButtonOutline', 51)

    makeLuaSprite('playSongButton', 'green', 470, -375)
    setObjectCamera('playSongButton', 'hud')
    addLuaSprite('playSongButton', true)
    setObjectOrder('playSongButton', 51)

    makeLuaText('playSongButtonText', 'START', 1280, 0, -360)
    setTextColor('playSongButtonText', 'FFFFFF')
    setTextAlignment('playSongButtonText', 'center')
    setTextBorder('playSongButtonText', 5, '000000', 'outline')
    addLuaText('playSongButtonText')
    setObjectOrder('playSongButtonText', 51)

    setTextSize('playSongButtonText', 100)
    scaleObject('playSongButtonOutline', 1.55, 0.527, true)
    scaleObject('playSongButton', 1.5, 0.5, true)

    makeLuaSprite('moddingMouse', 'Mouse') -- this should always be last in onCreate, since the mouse
    setObjectCamera('moddingMouse', 'hud') -- has to be on top of everything
    addLuaSprite('moddingMouse', true)
    scaleObject('moddingMouse', 0.5, 0.5, true)
    setObjectOrder('moddingMouse', 999)
end

function onTweenCompleted(tag, vars)
    if tag == 'playBG-xscroll' then
        setProperty('playBG.x', -1790)
        doTweenX('playBG-xscroll', 'playBG', 0, settingsBGscrollSpeed)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'checked' then
        playAnim('lagCheck', 'checked')
    end
    if tag == 'unchecked' then
        playAnim('lagCheck', 'unchecked')
    end
    if tag == 'EQTimer' then
        allowIOCameraZooms = true
    end
end

function syncMusic()
    playMusic('gallery', 1, true)
end

function onUpdate(elapsed)
    local truemouseX = getMouseX('hud')
    local truemouseY = getMouseY('hud')
    local mouseTEMPVAR = 0
    
    framesGenerated = framesGenerated + 1
    frameLoopsGenerated = frameLoopsGenerated + 1

    if frameLoopsGenerated == framerate + 1 then
        frameLoopsGenerated = 0
    end

    if keyboardPressed('R') then -- having this before anything else helps when null vars are ref
        restartSong()
    end

    if fixMouseBorders then
        if truemouseX < -15 then -- make sure that you dont move the mouse out of the borders
            truemouseX = -15
        end

        if truemouseX > 1266 then
            truemouseX = 1266
        end

        if truemouseY < 0 then
            truemouseY = 0
        end

        if truemouseY > 720 then
            truemouseY = 720
        end
    end    
    
    setProperty('playSongButtonOutline.visible', false)
    setProperty('playSongButtonOutline.y', getProperty('playSongButton.y') - 5)

    if allowIOCameraZooms then
        if keyboardJustPressed('I') then -- zoom in
            allowIOCameraZooms = false
            runTimer('EQTimer', 1)
            doTweenZoom('camZoomIn', 'hud', 1, 1)
        end
        
        if keyboardJustPressed('O') then -- zoom out
            allowIOCameraZooms = false
            runTimer('EQTimer', 1)
            doTweenZoom('camZoomIn', 'hud', 0.35, 1)
        end
    end

    if currentScreen == 'title' then
        if objectsOverlap('moddingMouse', 'refImages') then
            setTextString('currentlySelectedText', 'Behind the Scenes Images')
            currentlySelectedButton = 'ref'
        elseif objectsOverlap('moddingMouse', 'oldImages') then
            setTextString('currentlySelectedText', 'Old Gameplay Images + Videos')
            currentlySelectedButton = 'old'
        elseif objectsOverlap('moddingMouse', 'trash') then
            setTextString('currentlySelectedText', 'Scrapped Songs')
            currentlySelectedButton = 'scrapped'
        elseif objectsOverlap('moddingMouse', 'backMM') then
            currentlySelectedButton = 'backMM'
        else
            currentlySelectedButton = 'none'
        end
    elseif currentScreen == 'play' then
        if objectsOverlap('moddingMouse', 'backMM') then
            currentlySelectedButton = 'backMM'
        elseif objectsOverlap('moddingMouse', 'playSongButton') then
            setProperty('playSongButtonOutline.visible', true)

            if mouseClicked() then
                transitionToSong()
            end
        end

        if mouseClicked() then
            if truemouseY < 423 and truemouseY > 350 then
                if truemouseX < 303 and truemouseX > 250 then
                    if songID == 1 then
                        songID = 3
                    else
                        songID = songID - 1
                    end
                    updatePlayText()
                elseif truemouseX > 950 and truemouseX < 1000 then
                    if songID == 3 then
                        songID = 1
                    else
                        songID = songID + 1
                    end
                    updatePlayText()
                end
            end
        end

        if keyboardJustPressed('RIGHT') then
            if songID == 3 then
                songID = 1
            else
                songID = songID + 1
            end
            updatePlayText()
        elseif keyboardJustPressed('LEFT') then
            if songID == 1 then
                songID = 3
            else
                songID = songID - 1
            end
            updatePlayText()
        end
    elseif currentScreen == 'bts' then
        if objectsOverlap('moddingMouse', 'backMM') then
            currentlySelectedButton = 'backMM'
        end

        if mouseClicked() then
            if truemouseY < 423 and truemouseY > 350 then
                if truemouseX < 303 and truemouseX > 250 then
                    if songID == 1 then
                        songID = 3
                    else
                        songID = songID - 1
                    end
                    updateImage()
                elseif truemouseX > 950 and truemouseX < 1000 then
                    if songID == 3 then
                        songID = 1
                    else
                        songID = songID + 1
                    end
                    updateImage()
                end
            end
        end

        if keyboardJustPressed('RIGHT') then
            if songID == 3 then
                songID = 1
            else
                songID = songID + 1
            end
            updateImage()
        elseif keyboardJustPressed('LEFT') then
            if songID == 1 then
                songID = 3
            else
                songID = songID - 1
            end
            updateImage()
        end
    else
        currentlySelectedButton = 'none'
    end

    if currentScreen == 'title' then -- make sure this is before play or
        if keyboardJustPressed('BACKSPACE') then--else it will make you
            playSound('backMenu')--     go back to the main menu if you
            loadSong('mainmenu') --     press bksp one time in play menu
        end
    end

    if keyboardJustPressed('BACKSPACE') then
        if canPlayBackAnim then
            canPlayBackAnim = false
            playAnim('backMM', 'back', true)
        end
    end

    if currentScreen == 'play' or currentScreen == 'bts' then
        if keyboardJustPressed('BACKSPACE') then
            currentScreen = 'title'
            transitionToTitle()
            playSound('backMenu')
        end
    end
    
    if objectsOverlap('moddingMouse', 'backMM') then
        if canPlayBackAnim then
            canPlayBackAnim = false
            playAnim('backMM', 'back', true)
        end

        if mouseClicked() then
            playSound('backMenu')
            if currentScreen == 'title' then
                loadSong('mainmenu')
            elseif currentScreen == 'play' or currentScreen == 'bts' then
                currentScreen = 'title'
                transitionToTitle()
            end
        end
    else
        canPlayBackAnim = true
    end

    setProperty('moddingMouse.x', truemouseX)
    setProperty('moddingMouse.y', truemouseY)

    if lastSelectedButton ~= currentlySelectedButton then
        if currentlySelectedButton ~= 'none' then
            if currentlySelectedButton == 'backMM' then
                playSound('scrollMenu', 0.55)
            else
                playSound('scrollMenuSonic', 0.55)
            end
        end
    end

    if mouseClicked() then
        if currentlySelectedButton == 'scrapped' then
            currentScreen = 'play'
            transitionToPlay()
        end
    end

    if mouseClicked() then
        if currentlySelectedButton == 'ref' then
            currentScreen = 'bts'
            transitionToBTS() -- i hate kpop demon hunters and im not referring to them.
        end --                   bts is an abbreviation for "Behind The Scenes"
    end

    if framesGenerated > 1 then -- check whether the player is using mouse or keyboard controls
        mouseTEMPVAR = truemouseX .. truemouseY

        if usedKeyboardLastFrame then
            if mouseTEMPVAR == lastFrameMouse then
                currentlyUsedControl = 'keyboard'
            else
            end
        end

        if not usedKeyboardLastFrame then
            if mouseTEMPVAR ~= lastFrameMouse then
                currentlyUsedControl = 'mouse'
            else
            end
        end
    end

    --debugPrint('x: ' .. truemouseX .. ' y: ' .. truemouseY .. ' equ: ')
    --debugPrint(truemouseY / BgFollowsMouseIntensity - 125)
    --debugPrint(currentlySelectedButton)
    --debugPrint(usedKeyboardLastFrame)
    --debugPrint(currentlyUsedControl)
    --debugPrint(frameLoopsGenerated)
    --debugPrint(lastSelectedButton)
    --debugPrint(framesGenerated)
    --debugPrint(lastFrameMouse)
    --debugPrint(songID)
    
    lastFrameMouse = truemouseX .. truemouseY
    usedKeyboardLastFrame = false

    if keyboardPressed('ANY') then
        usedKeyboardLastFrame = true
    else
        usedKeyboardLastFrame = false
    end

    lastSelectedButton = currentlySelectedButton
end

function updatePlayText()
    if songID == 1 then
        setTextString('playSelectedText', 'scrambled screen')
    elseif songID == 2 then
        setTextString('playSelectedText', "scramblin'")
    elseif songID == 3 then
        setTextString('playSelectedText', 'trinity')
    end
end

function transitionToSong()
    if songID == 1 then
        loadSong('scrambled-screen')
    elseif songID == 2 then
        loadSong('blazin')
    elseif songID == 3 then
        loadSong('trinity')
    end
end

function transitionToPlay()
    doTweenY('pullDownPlaySongText1', 'playSelectedText', 360, 1, 'quartOut')
    doTweenY('pullDownPlaySongText2', 'playSelectionText', 360, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton1', 'playSongButton', 475, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton2', 'playSongButtonText', 510, 1, 'quartOut')

    doTweenY('pullDownPlayBG', 'playBG', -400, 1, 'quartOut')
end

function transitionToBTS()
    doTweenY('pullDownPlaySongText1', 'playSelectionText', 360, 1, 'quartOut')
    doTweenY('pullDownPlayBG', 'playBG', -400, 1, 'quartOut')
end

function transitionToTitle()
    doTweenY('pullDownPlaySongText1', 'playSelectedText', -360, 1, 'quartOut')
    doTweenY('pullDownPlaySongText2', 'playSelectionText', -360, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton1', 'playSongButton', -375, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton2', 'playSongButtonText', -375, 1, 'quartOut')

    doTweenY('pullDownPlayBG', 'playBG', -1280, 1, 'quartOut')
end

function onStartCountdown()
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)

    setProperty('healthBar.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)

    setProperty('botplayTxt.visible', false) -- ruins the illusion of this actually being a song,
    setProperty('botplayTxt.y', -500)        -- not a main menu.

    return Function_Stop;
end

function onSongStart()
    noteTweenAlpha('hideHUDthingyaaa0', 0, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa1', 1, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa2', 2, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa3', 3, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa4', 4, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa5', 5, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa6', 6, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')
    noteTweenAlpha('hideHUDthingyaaa7', 7, 0, 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 'linear')

end

function onEndSong()
    return Function_Stop;
end