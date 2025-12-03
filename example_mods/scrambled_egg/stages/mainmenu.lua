-- wooo main menu lets go

-- i dare you to press "carpet" on the main menu
-- and also type "O" on the main menu

local keyboardTitleMovement = 0.5 -- sensitivity of bg movement (keyboard controls) 0.5 is default
local fixMouseBorders = true -- fixes moving the mouse out of the 16:9 borders.     true is default
local rpcIndicator = 'roaming the menus ' -- change the rpc status when in menus.   roaming the menus 
local BgFollowsMouseIntensity = 6 -- lower the number, more intense.                6 is default
local settingsBGscrollSpeed = 10 -- scroll speed for settingsBG in seconds          10 is default
local legacyVersionSize = 1.25 -- size of the version logo in the legacy songs menu 1.25 is default
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
local hasFixes = false
local carpetCheck = ''
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

    if not checkFileExists('windowmovements.txt') then
        saveFile('windowmovements.txt', 'F')
    end

    if not checkFileExists('fixes.txt') then
        saveFile('fixes.txt', 'T')
    end

    makeLuaSprite('playSongButtonOutline', 'white', 465, -360)
    setObjectCamera('playSongButtonOutline', 'hud')
    addLuaSprite('playSongButtonOutline', true)
    setObjectOrder('playSongButtonOutline', 6)

    makeLuaSprite('playSongButton', 'green', 470, -360)
    setObjectCamera('playSongButton', 'hud')
    addLuaSprite('playSongButton', true)
    setObjectOrder('playSongButton', 7)

    makeLuaSprite('playButtonOutline', 'green', -34, -360)
    setObjectCamera('playButtonOutline', 'hud')
    addLuaSprite('playButtonOutline', true)
    setObjectOrder('playButtonOutline', 0)

    makeLuaSprite('backButtonOutline', 'green', 894, 41)
    setObjectCamera('backButtonOutline', 'hud')
    addLuaSprite('backButtonOutline', true)
    setObjectOrder('backButtonOutline', 6)

    makeLuaSprite('backButton', 'white', 900, -200)
    setObjectCamera('backButton', 'hud')
    addLuaSprite('backButton', true)
    setObjectOrder('backButton', 10)

    makeLuaSprite('creditsButtonOutline', 'green', 894, 41)
    setObjectCamera('creditsButtonOutline', 'hud')
    addLuaSprite('creditsButtonOutline', true)
    setObjectOrder('creditsButtonOutline', 6)

    makeLuaSprite('creditsButton', 'white', 900, -200)
    setObjectCamera('creditsButton', 'hud')
    addLuaSprite('creditsButton', true)
    setObjectOrder('creditsButton', 10)

    makeLuaSprite('playButton', 'white', 0, 75)
    setObjectCamera('playButton', 'hud')
    addLuaSprite('playButton', true)
    setObjectOrder('playButton', 1)

    makeLuaSprite('playButton2', 'white', 0, 275)
    setObjectCamera('playButton2', 'hud')
    addLuaSprite('playButton2', true)
    setObjectOrder('playButton2', 1)

    makeLuaSprite('playButton3', 'white', 0, 475)
    setObjectCamera('playButton3', 'hud')
    addLuaSprite('playButton3', true)
    setObjectOrder('playButton3', 1)

    makeLuaSprite('titleBG', 'titlescreenHD', 0, 0)
    setObjectCamera('titleBG', 'hud')
    addLuaSprite('titleBG', true)
    setObjectOrder('titleBG', 0)
    
    makeLuaSprite('settingsBG', 'no-modding/bgbottomDOUBLESCREEN', -1790, -1152)
    setObjectCamera('settingsBG', 'hud')
    addLuaSprite('settingsBG', true)
    setObjectOrder('settingsBG', 6)
    setProperty('settingsBG.antialiasing', false)
    doTweenX('settingsBG-xscroll', 'settingsBG', 0, settingsBGscrollSpeed)

    makeLuaSprite('playBG', 'no-modding/bgbottomDOUBLESCREEN-BLUE', -1790, 720)--1152)
    setObjectCamera('playBG', 'hud')
    addLuaSprite('playBG', true)
    setObjectOrder('playBG', 6)
    setProperty('playBG.antialiasing', false)
    doTweenX('playBG-xscroll', 'playBG', 0, settingsBGscrollSpeed)

    makeLuaSprite('creditsBG-top', 'no-modding/bgbottomDOUBLESCREEN-RED', -1790, 720)--1152)
    setObjectCamera('creditsBG-top', 'hud')
    addLuaSprite('creditsBG-top', true)
    setObjectOrder('creditsBG-top', 6)
    setProperty('creditsBG-top-xscroll.antialiasing', false)
    doTweenX('creditsBG-top-xscroll', 'creditsBG-top', 0, settingsBGscrollSpeed)

    makeLuaSprite('creditsBG-bottom', 'no-modding/bgbottomDOUBLESCREEN-RED', -1790, -1152)--1152)
    setObjectCamera('creditsBG-bottom', 'hud')
    addLuaSprite('creditsBG-bottom', true)
    setObjectOrder('creditsBG-bottom', 6)
    setProperty('creditsBG-bottom-xscroll.antialiasing', false)
    doTweenX('creditsBG-bottom-xscroll', 'creditsBG-bottom', 0, settingsBGscrollSpeed)

    makeLuaText('creditsButtonText', 'CREDITS', 0, 895, -235)
    setTextColor('creditsButtonText', 'FFFFFF')
    setTextBorder('creditsButtonText', 5, '000000', 'outline')
    setProperty('creditsButtonText.antialiasing', false)
    addLuaText('creditsButtonText')
    setObjectOrder('creditsButtonText', 50)

    makeLuaText('backButtonText', 'BACK', 0, 900, -235)
    setTextColor('backButtonText', 'FFFFFF')
    setTextBorder('backButtonText', 5, '000000', 'outline')
    addLuaText('backButtonText')
    setProperty('backButtonText.antialiasing', false)
    setObjectOrder('backButtonText', 50)

    makeLuaSprite('legacyButtonOutline', 'green', 61, 41)
    setObjectCamera('legacyButtonOutline', 'hud')
    addLuaSprite('legacyButtonOutline', true)
    setObjectOrder('legacyButtonOutline', 9)

    makeLuaSprite('legacyButton', 'white', 65, -200)
    setObjectCamera('legacyButton', 'hud')
    addLuaSprite('legacyButton', true)
    setObjectOrder('legacyButton', 11)

    makeLuaText('legacyButtonText', 'LEGACY SONGS', 0, 65, -200)
    setTextColor('legacyButtonText', 'FFFFFF')
    setTextBorder('legacyButtonText', 5, '000000', 'outline')
    addLuaText('legacyButtonText')
    setProperty('legacyButtonText.antialiasing', false)
    setObjectOrder('legacyButtonText', 12)
    
    makeLuaSprite('psychButtonOutline', 'green', 61, 41)
    setObjectCamera('psychButtonOutline', 'hud')
    addLuaSprite('psychButtonOutline', true)
    setObjectOrder('psychButtonOutline', 11)

    makeLuaSprite('psychButton', 'white', 65, -200)
    setObjectCamera('psychButton', 'hud')
    addLuaSprite('psychButton', true)
    setObjectOrder('psychButton', 12)

    makeLuaText('psychButtonText', 'PSYCH SETTINGS', 0, 65, -200)
    setTextColor('psychButtonText', 'FFFFFF')
    setTextBorder('psychButtonText', 5, '000000', 'outline')
    addLuaText('psychButtonText')
    setProperty('psychButtonText.antialiasing', false)
    setObjectOrder('psychButtonText', 13)

    makeLuaSprite('legacyVersionIndicator', 'versionLogos/v1', 0, 0)
    setObjectCamera('legacyVersionIndicator', 'hud')
    addLuaSprite('legacyVersionIndicator', true)
    setObjectOrder('legacyVersionIndicator', 11)

    makeLuaText('playButton1Text', 'PLAY', 0, 0, 100)
    setTextColor('playButton1Text', 'FFFFFF')
    setTextBorder('playButton1Text', 5, '000000', 'outline')
    setProperty('playButton1Text.antialiasing', false)
    addLuaText('playButton1Text')
    setObjectOrder('playButton1Text', 5)

    makeLuaText('playButton2Text', 'SETTINGS', 0, 0, 300)
    setTextColor('playButton2Text', 'FFFFFF')
    setTextBorder('playButton2Text', 5, '000000', 'outline')
    setProperty('playButton2Text.antialiasing', false)
    addLuaText('playButton2Text')
    setObjectOrder('playButton2Text', 4)

    makeLuaText('playButton3Text', 'CREDITS', 0, 0, 500)
    setTextColor('playButton3Text', 'FFFFFF')
    setTextBorder('playButton3Text', 5, '000000', 'outline')
    setProperty('playButton3Text.antialiasing', false)
    addLuaText('playButton3Text')
    setObjectOrder('playButton3Text', 3)

    makeLuaText('playSongButtonText', 'START', 1280, 0, -360)
    setTextColor('playSongButtonText', 'FFFFFF')
    setTextAlignment('playSongButtonText', 'center')
    setTextBorder('playSongButtonText', 5, '000000', 'outline')
    setProperty('playSongButtonText.antialiasing', false)
    addLuaText('playSongButtonText')
    setObjectOrder('playSongButtonText', 51)

    
    if checkFileExists('titleMusic.txt') then
        if getTextFromFile('titleMusic.txt') == 'S' then
            makeLuaText('musicSettingText', '< Sonic Rewrite R2 >', 1280, 0, -500)
        end
        if getTextFromFile('titleMusic.txt') == 'B' then
            makeLuaText('musicSettingText', '< Blast Processing >', 1280, 0, -500)
        end
    else
        makeLuaText('musicSettingText', '< Blast Processing >', 1280, 0, -500)
        saveFile('scrambled_egg/titleMusic.txt', 'B')
    end
    setTextColor('musicSettingText', 'FFFFFF')
    setTextBorder('musicSettingText', 5, '000000', 'outline')
    setTextAlignment('musicSettingText', 'center')
    setTextSize('musicSettingText', 60)
    setProperty('musicSettingText.antialiasing', false)
    addLuaText('musicSettingText')
    setObjectOrder('musicSettingText', 49)

    makeLuaText('playSelectionText', '<                   >', 1280, 0, -360)
    setTextColor('playSelectionText', 'FFFFFF')
    setTextBorder('playSelectionText', 5, '000000', 'outline')
    setTextAlignment('playSelectionText', 'center')
    setTextSize('playSelectionText', 60)
    setProperty('playSelectionText.antialiasing', false)
    addLuaText('playSelectionText')
    setObjectOrder('playSelectionText', 50)

    makeLuaText('playSelectedText', 'takeover', 1280, 0, -360)
    setTextColor('playSelectedText', 'FFFFFF')
    setTextBorder('playSelectedText', 5, '000000', 'outline')
    setTextAlignment('playSelectedText', 'center')
    setTextSize('playSelectedText', 60)
    setProperty('playSelectedText.antialiasing', false)
    addLuaText('playSelectedText')
    setObjectOrder('playSelectedText', 50)

    makeLuaText('musicSettingInfoText', 'Main Menu Song:', 1280, 0, -300)
    setTextColor('musicSettingInfoText', 'FFFFFF')
    setTextBorder('musicSettingInfoText', 5, '000000', 'outline')
    setTextAlignment('musicSettingInfoText', 'center')
    setTextSize('musicSettingInfoText', 120)
    setProperty('musicSettingInfoText.antialiasing', false)
    addLuaText('musicSettingInfoText')
    setObjectOrder('musicSettingInfoText', 49)

    makeLuaText('versionText', getTextFromFile('VERSION-NUMBER.txt'), 0, 0, 25)
    setTextColor('versionText', 'FFFFFF')
    setTextBorder('versionText', 5, '000000', 'outline')
    setTextSize('versionText', 21)
    setProperty('versionText.antialiasing', false)
    addLuaText('versionText')
    setObjectOrder('versionText', 7)
    
    scaleObject('titleBG', 0.85, 0.85, true)
    setTextHeight('playButton1Text', 182)
        
    scaleObject('backButtonOutline', 1.55, 0.527, true)
    scaleObject('backButton', 1.5, 0.5, true)
    setTextWidth('backButtonText', 350)
    setTextSize('backButtonText', 115)

    scaleObject('creditsButtonOutline', 1.55, 0.527, true)
    scaleObject('creditsButton', 1.5, 0.5, true)
    setTextWidth('creditsButtonText', 350)
    setTextSize('creditsButtonText', 75)

    scaleObject('legacyButtonOutline', 1.55, 0.527, true)
    scaleObject('legacyButton', 1.5, 0.5, true)
    setTextWidth('legacyButtonText', 350)
    setTextSize('legacyButtonText', 75)

    scaleObject('psychButtonOutline', 1.55, 0.527, true)
    scaleObject('psychButton', 1.5, 0.5, true)
    setTextWidth('psychButtonText', 350)
    setTextSize('psychButtonText', 65)

    setTextSize('playSongButtonText', 100)

    scaleObject('playSongButtonOutline', 1.55, 0.527, true)
    scaleObject('playSongButton', 1.5, 0.5, true)

    makeAnimatedLuaSprite('lagCheck', 'check', 220, 800)
    setObjectCamera('lagCheck', 'hud')
    addAnimationByPrefix('lagCheck', 'checked', 'checkbox finish000', 24 / playbackRate, true) -- v4.2 thing; playback rate decides
    addAnimationByPrefix('lagCheck', 'unchecked', 'checkbox000', 24 / playbackRate, true)      -- animations and therefore made
    addAnimationByPrefix('lagCheck', 'check', 'checkbox anim000', 24 / playbackRate, false)    -- this one wayyy too quick
    addAnimationByPrefix('lagCheck', 'uncheck', 'checkbox anim reverse000', 24 / playbackRate, false)
    addOffset('lagCheck', 'uncheck', -10, 29)
    addOffset('lagCheck', 'unchecked', -38, 0)
    addOffset('lagCheck', 'checked', -35, 11)
    addOffset('lagCheck', 'check', 0, 25)
    playAnim('lagCheck', 'uncheck', true)
    addLuaSprite('lagCheck')

    makeLuaText('lagText', 'Disable Window Movements', 1420, 0, 800) -- this used to be a lag fix
    setTextColor('lagText', 'FFFFFF')
    setTextBorder('lagText', 5, '000000', 'outline')
    setTextAlignment('lagText', 'center')
    setTextSize('lagText', 45)
    setObjectCamera('lagText', 'hud')
    setProperty('lagText.antialiasing', false)
    addLuaText('lagText', true)

    makeAnimatedLuaSprite('fixCheck', 'check', 0, -150) -- normal pos is 175
    setObjectCamera('fixCheck', 'hud')
    addAnimationByPrefix('fixCheck', 'checked', 'checkbox finish000', 24 / playbackRate, true)
    addAnimationByPrefix('fixCheck', 'unchecked', 'checkbox000', 24 / playbackRate, true)
    addAnimationByPrefix('fixCheck', 'check', 'checkbox anim000', 24 / playbackRate, false)
    addAnimationByPrefix('fixCheck', 'uncheck', 'checkbox anim reverse000', 24 / playbackRate, false)
    addOffset('fixCheck', 'uncheck', -10, 29)
    addOffset('fixCheck', 'unchecked', -38, 0)
    addOffset('fixCheck', 'checked', -35, 11)
    addOffset('fixCheck', 'check', 0, 25)
    playAnim('fixCheck', 'uncheck', true)
    screenCenter('fixCheck', 'x')
    setProperty('fixCheck.x', getProperty('fixCheck.x') - 115) -- cool mismatch
    setProperty('fixCheck.x', getProperty('fixCheck.x') - 55) -- offset both
    addLuaSprite('fixCheck')

    makeLuaText('fixText', 'Updates', 1420, 0, getProperty('fixCheck.y') + 30)
    setTextColor('fixText', 'FFFFFF')
    setTextBorder('fixText', 5, '000000', 'outline')
    setTextAlignment('fixText', 'center')
    setTextSize('fixText', 55)
    setObjectCamera('fixText', 'hud')
    screenCenter('fixText', 'x')
    setProperty('fixText.x', getProperty('fixText.x') + 115) -- cool mismatch
    setProperty('fixText.x', getProperty('fixText.x') - 55) -- offset both
    addLuaText('fixText', true)

    makeLuaText('creditsText', 'CREDITS', 1300, 0, 800)  -- this is the indicator that tells you
    setTextColor('creditsText', 'FFFFFF')                -- you're in the credits menu
    setTextBorder('creditsText', 5, '000000', 'outline')
    setTextAlignment('creditsText', 'center')
    setTextSize('creditsText', 100)
    setObjectCamera('creditsText', 'hud')
    setProperty('creditsText.antialiasing', false)
    addLuaText('creditsText', true)

    precacheMusic('title-vs')
    precacheMusic('title-bp')

    setProperty('creditsButton.alpha', 0)
    setProperty('creditsButtonOutline.alpha', 0)
    setProperty('creditsButtonText.alpha', 0)

    setProperty('legacyVersionIndicator.visible', false)
    scaleObject('legacyVersionIndicator', legacyVersionSize, legacyVersionSize, true)

    makeLuaSprite('GCBar', 'black', 0, 680)
    scaleObject('GCBar', 100, 1)
    setObjectCamera('GCBar', 'hud')
    addLuaSprite('GCBar', true)

    makeLuaText('GCText', 'PRESS CTRL TO ENABLE GAMEPLAY MODIFIERS', 1280, -1000, 682)
    setTextColor('GCText', 'FFFFFF')
    setTextBorder('GCText', 5, '000000', 'shadow')
    setTextAlignment('GCText', 'center')
    setTextSize('GCText', 32)
    setObjectCamera('GCText', 'hud')
    setProperty('GCText.antialiasing', false)
    addLuaText('GCText', true)

    makeLuaSprite('loreBar', 'black', 0, 680)
    scaleObject('loreBar', 100, 1)
    setObjectCamera('loreBar', 'hud')
    addLuaSprite('loreBar', true)

    makeLuaText('loreText', 'test', 1280, 0, 682)
    setTextColor('loreText', 'FFFFFF')
    setTextBorder('loreText', 5, '000000', 'shadow')
    setTextAlignment('loreText', 'center')
    setTextSize('loreText', 32)
    setObjectCamera('loreText', 'hud')
    setProperty('loreText.antialiasing', false)
    addLuaText('loreText', true)

    doTweenAlpha('loreBarOpacityTween', 'loreBar', 0, 0.00001, 'linear')
    doTweenAlpha('loreTextOpacityTween', 'loreText', 0, 0.00001, 'linear')
    doTweenAlpha('GCBarOpacityTween', 'GCBar', 0.5, 0.00001, 'linear')
    doTweenAlpha('GCTextOpacityTween', 'GCText', 1, 0.00001, 'linear')
    doTweenX('loreTextXTweeninginginging', 'GCText', 1280, 10, 'linear')
    doTweenAlpha('creditsTextOpacityTween', 'creditsText', 0, 1, 'linear')

    syncMusic()
    updateCheckBox()
    updateCheckBox2()

    makeLuaSprite('moddingMouse', 'Mouse') -- this should always be last in onCreate, since the mouse
    setObjectCamera('moddingMouse', 'hud') -- has to be on top of everything
    addLuaSprite('moddingMouse', true)
    scaleObject('moddingMouse', 0.5, 0.5, true)
    setObjectOrder('moddingMouse', 999)

    --makeLuaSprite('filter', 'CRT1280') -- this should always be last in onCreate, since
    --setObjectCamera('filter', 'hud')   -- the filter has to be on top of everything
    --setProperty('filter.visible', false)
    --addLuaSprite('filter', true)
end

function updateCheckBox()
    cancelTimer('checked')
    cancelTimer('unchecked')

    if getTextFromFile('windowmovements.txt') == 'T' then
        playAnim('lagCheck', 'check')
        runTimer('checked', 0.375)
    end
    if getTextFromFile('windowmovements.txt') == 'F' then
        playAnim('lagCheck', 'uncheck')
        runTimer('unchecked', 0.3)
    end

    playSound('scrollMenu')
end

function updateCheckBox2()
    cancelTimer('checked2')
    cancelTimer('unchecked2')

    if getTextFromFile('fixes.txt') == 'T' then
        playAnim('fixCheck', 'check')
        runTimer('checked2', 0.375)
    end
    if getTextFromFile('fixes.txt') == 'F' then
        playAnim('fixCheck', 'uncheck')
        runTimer('unchecked2', 0.3)
    end

    playSound('scrollMenu')
end

function onTweenCompleted(tag, vars)
    if tag == 'loreTextXTweeninginginging' then
        setProperty('GCText.x', -1000)
        doTweenX('loreTextXTweeninginginging', 'GCText', 1280, 10, 'linear')
    end

    if tag == 'settingsBG-xscroll' then
        setProperty('settingsBG.x', -1790)
        doTweenX('settingsBG-xscroll', 'settingsBG', 0, settingsBGscrollSpeed)
    end

    if tag == 'playBG-xscroll' then
        setProperty('playBG.x', -1790)
        doTweenX('playBG-xscroll', 'playBG', 0, settingsBGscrollSpeed)
    end

    if tag == 'creditsBG-top-xscroll' then
        setProperty('creditsBG-top.x', -1790)
        doTweenX('creditsBG-top-xscroll', 'creditsBG-top', 0, settingsBGscrollSpeed)
    end

    if tag == 'creditsBG-bottom-xscroll' then
        setProperty('creditsBG-bottom.x', -1790)
        doTweenX('creditsBG-bottom-xscroll', 'creditsBG-bottom', 0, settingsBGscrollSpeed)
    end

    if tag == 'creditsTextOpacityTween' then
        doTweenAlpha('creditsTextOpacityTween2', 'creditsText', 1, 1, 'linear')
    end

    if tag == 'creditsTextOpacityTween2' then
        doTweenAlpha('creditsTextOpacityTween', 'creditsText', 0, 1, 'linear')
    end
end

function syncMusic()
    if checkFileExists('titleMusic.txt') then
        if getTextFromFile('titleMusic.txt') == 'S' then
            playMusic('title-vs', 1, true)
        end

        if getTextFromFile('titleMusic.txt') == 'B' then
            playMusic('title-bp', 1, true)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'checked' then
        playAnim('lagCheck', 'checked')
    end
    if tag == 'unchecked' then
        playAnim('lagCheck', 'unchecked')
    end
    if tag == 'checked2' then
        playAnim('fixCheck', 'checked')
    end
    if tag == 'unchecked2' then
        playAnim('fixCheck', 'unchecked')
    end
    if tag == 'EQTimer' then
        allowIOCameraZooms = true
    end
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

    --local cameraX = getCameraFollowX()
    --local cameraY = getCameraFollowY()

    -- ^ commented out as they are not used anywhere in the code

    if keyboardJustPressed('CONTROL') then
        if isCompiledFromEGG then
            loadSong('gc')
        else
            debugPrint('This feature is unavailable. Try switching to EGGs compiled exe?', 'FF0000')
            playSound('denied')
        end
    end

    if keyboardJustPressed('C') then
        carpetCheck = carpetCheck .. 'C'
    elseif keyboardJustPressed('A') then
        carpetCheck = carpetCheck .. 'A'
    elseif keyboardJustPressed('R') then
        carpetCheck = carpetCheck .. 'R'
    elseif keyboardJustPressed('P') then
        carpetCheck = carpetCheck .. 'P'
    elseif keyboardJustPressed('E') then
        carpetCheck = carpetCheck .. 'E'
    elseif keyboardJustPressed('T') then
        carpetCheck = carpetCheck .. 'T'
    end

    --debugPrint(carpetCheck)

    if carpetCheck ~= 'C' then
        if carpetCheck ~= 'CA' then
            if carpetCheck ~= 'CAR' then
                if carpetCheck ~= 'CARP' then
                    if carpetCheck ~= 'CARPE' then
                        if carpetCheck ~= 'CARPET' then
                            carpetCheck = ''
                        end
                    end
                end
            end
        end
    end
    
    if carpetCheck == 'CARPET' then
        loadSong('carpet')
    end


    if keyboardPressed('R') then -- having this before anything else helps when null vars are ref
        if carpetCheck ~= 'CAR' then
            restartSong()
        end
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

    setProperty('moddingMouse.x', truemouseX)
    setProperty('moddingMouse.y', truemouseY)

    setProperty('backButtonOutline.visible', false)
    setProperty('backButtonOutline.y', getProperty('backButton.y') - 5)

    setProperty('creditsButtonOutline.visible', false)
    setProperty('creditsButtonOutline.y', getProperty('creditsButton.y') - 5)

    setProperty('legacyButtonOutline.visible', false)
    setProperty('legacyButtonOutline.y', getProperty('legacyButton.y') - 5)

    setProperty('psychButtonOutline.visible', false)
    setProperty('psychButtonOutline.y', getProperty('psychButton.y') - 5)

    setProperty('playSongButtonOutline.visible', false)
    setProperty('playSongButtonOutline.y', getProperty('playSongButton.y') - 5)

    if lastSelectedButton ~= currentlySelectedButton then
        if currentlySelectedButton ~= 0 then
            playSound('scrollMenuSonic', 0.55)
        end

        lastSelectedButton = currentlySelectedButton
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
    
    setProperty('titleBG.x', truemouseX / BgFollowsMouseIntensity - 185) -- main menu math (MMM)

    if currentlyUsedControl == 'mouse' then
        setProperty('titleBG.y', truemouseY / BgFollowsMouseIntensity - 125)
    end

    scaleObject('playButtonOutline', 0.2 + 1.5 + (1.0 / 1363) * (truemouseX + 42), 0.55, true)
    scaleObject('playButton', 1.5 + (1.0 / 1363) * (truemouseX + 42), 0.5, true)
    scaleObject('playButton2', 1.5 + (1.0 / 1363) * (truemouseX + 42), 0.5, true)
    scaleObject('playButton3', 1.5 + (1.0 / 1363) * (truemouseX + 42), 0.5, true)

    setTextWidth('playButton1Text', 345 + (220 / 1363) * (truemouseX + 42))
    setTextSize('playButton1Text', 60 + (40 / 1363) * (truemouseX + 42))

    setTextWidth('playButton2Text', 345 + (220 / 1363) * (truemouseX + 42))
    setTextSize('playButton2Text', 60 + (40 / 1363) * (truemouseX + 42))

    setTextWidth('playButton3Text', 345 + (220 / 1363) * (truemouseX + 42))
    setTextSize('playButton3Text', 60 + (40 / 1363) * (truemouseX + 42))

    setProperty('playButton1Text.y', 125)
    setProperty('playButton2Text.y', 275 + 50)
    setProperty('playButton3Text.y', 475 + 50)

    if currentScreen == 'legacy' or currentScreen == 'play' then
        setProperty('fixText.y', getProperty('fixCheck.y') + 30) -- this is not how the other check
        -- works but im just gonna use this because im too lazy to set up two different tweens
    end

    if currentScreen == 'play' or currentScreen == 'legacy' or currentScreen == 'settings' then
        if keyboardJustPressed('LEFT') then
            playSound('scrollMenu')
        end

        if keyboardJustPressed('RIGHT') then
            playSound('scrollMenu')
        end
    end

    if currentScreen == 'play' then
        if keyboardJustPressed('BACKSPACE') then
            transitionToTitle()
        end

        if keyboardJustPressed('ENTER') then
            transitionToSong()
        end

        if keyboardJustPressed('L') then
            transitionToLegacy()
        end

        if truemouseX < 1228 and truemouseX > 885 then -- make sure nested or one of them wont work
            if truemouseY > 47 and truemouseY < 229 then
                currentlySelectedButton = 4
            else
                currentlySelectedButton = 0
            end
        else
            if truemouseX < 807 and truemouseX > 465 then
                if truemouseY > 472 and truemouseY < 654 then
                    currentlySelectedButton = 5
                else
                    currentlySelectedButton = 0
                end
            else
                if truemouseX < 393 and truemouseX > 50 then
                    if truemouseY > 45 and truemouseY < 227 then
                        currentlySelectedButton = 6
                   else
                        currentlySelectedButton = 0
                    end
                else
                    currentlySelectedButton = 0
                end
            end
        end

        if currentlySelectedButton == 4 then
            if mouseClicked() then
                transitionToTitle()
            end

            setProperty('backButtonOutline.visible', true)
        else
            setProperty('backButtonOutline.visible', false)
        end

        if currentlySelectedButton == 5 then
            if mouseClicked() then
                transitionToSong()
            end

            setProperty('playSongButtonOutline.visible', true)
        else
            setProperty('playSongButtonOutline.visible', false)
        end

        if currentlySelectedButton == 6 then
            if mouseClicked() then
                transitionToLegacy()
            end

            setProperty('legacyButtonOutline.visible', true)
        else
            setProperty('legacyButtonOutline.visible', false)
        end

        if alwaysTrue then
            if mouseClicked() then
                if truemouseY < 423 and truemouseY > 350 then
                    if truemouseX < 303 and truemouseX > 250 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if songID == 1 then
                            songID = 5
                        else
                            songID = songID - 1
                        end
                        updatePlayText()
                    elseif truemouseX > 950 and truemouseX < 1000 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if songID == 5 then
                            songID = 1
                        else
                            songID = songID + 1
                        end
                        updatePlayText()
                    end
                end
            end

            if keyboardJustPressed('RIGHT') then
                alwaysTrue = true
                runTimer('changeButtonCooldown', 0.2)
                if songID == 5 then
                    songID = 1
                else
                    songID = songID + 1
                end
                updatePlayText()
            end

            if keyboardJustPressed('LEFT') then
                runTimer('changeButtonCooldown', 0.2)
                alwaysTrue = true
                if songID == 1 then
                    songID = 5
                else
                    songID = songID - 1
                end
                updatePlayText()
            end
        end
    end

    if currentScreen == 'credits' then
        if keyboardJustPressed('BACKSPACE') then
            if creditsShowingLegacy then
                doTweenY('pullDownLegacyButton1', 'legacyButton', 48, 1, 'quartOut')
                doTweenY('pullDownLegacyButton2', 'legacyButtonText', 67, 1, 'quartOut')
                doTweenColor('doTheThing1', 'creditsBG-bottom', 'ffffff', 1)
                doTweenColor('doTheThing2', 'creditsBG-top', 'ffffff', 1)
                playSound('backMenu')
                songID = 1
                creditsShowingLegacy = false
                updatePlayText()
            else
                currentScreen = 'play'
                transitionToTitle()
            end
        end

        if mouseClicked() then
            if truemouseX > 434 and truemouseX < 840 and truemouseY > 505 and truemouseY < 585 then
                if songID > 3 then
                    if creditsShowingLegacy then
                        os.execute('start https://www.roblox.com/users/713974665/profile') -- he asked me to be in game
                    end
                end
            end
        end

        if keyboardJustPressed('L') then
            if not creditsShowingLegacy then
                doTweenColor('doTheThing1', 'creditsBG-bottom', '1500ff', 1)
                doTweenColor('doTheThing2', 'creditsBG-top', '1500ff', 1)
                doTweenY('pullDownLegacyButton1', 'legacyButton', -200, 1, 'quartOut')
                doTweenY('pullDownLegacyButton2', 'legacyButtonText', -200, 1, 'quartOut')

                songID = 1
                creditsShowingLegacy = true
                updatePlayText()
            end
        end

        if truemouseX < 1228 and truemouseX > 885 then
            if truemouseY > 47 and truemouseY < 229 then
                currentlySelectedButton = 4
            else
                currentlySelectedButton = 0
            end
        else
            if truemouseX < 393 and truemouseX > 50 then
                if truemouseY > 45 and truemouseY < 227 then
                    currentlySelectedButton = 6
               else
                    currentlySelectedButton = 0
                end
            else
                currentlySelectedButton = 0
            end
        end

        if currentlySelectedButton == 4 then
            if mouseClicked() then
                if creditsShowingLegacy then
                    doTweenY('pullDownLegacyButton1', 'legacyButton', 48, 1, 'quartOut')
                    doTweenY('pullDownLegacyButton2', 'legacyButtonText', 67, 1, 'quartOut')
                    doTweenColor('doTheThing1', 'creditsBG-bottom', 'ffffff', 1)
                    doTweenColor('doTheThing2', 'creditsBG-top', 'ffffff', 1)
                    playSound('backMenu')
                    songID = 1
                    creditsShowingLegacy = false
                    updatePlayText()
                else
                    currentScreen = 'play'
                    transitionToTitle()
                end
            end

            setProperty('backButtonOutline.visible', true)
        else
            setProperty('backButtonOutline.visible', false)
        end

        if currentlySelectedButton == 6 then
            if mouseClicked() then
                doTweenColor('doTheThing1', 'creditsBG-bottom', '1500ff', 1)
                doTweenColor('doTheThing2', 'creditsBG-top', '1500ff', 1)
                doTweenY('pullDownLegacyButton1', 'legacyButton', -200, 1, 'quartOut')
                doTweenY('pullDownLegacyButton2', 'legacyButtonText', -200, 1, 'quartOut')

                songID = 1
                creditsShowingLegacy = true
                updatePlayText()
            end

            setProperty('legacyButtonOutline.visible', true)
        else
            setProperty('legacyButtonOutline.visible', false)
        end

        if alwaysTrue then
            if mouseClicked() then
                if truemouseY < 423 and truemouseY > 350 then
                    if truemouseX < 303 and truemouseX > 250 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if not creditsShowingLegacy then
                            if songID == 1 then
                                songID = 5
                            else
                                songID = songID - 1
                            end
                        elseif creditsShowingLegacy then
                            if songID == 1 then
                                songID = 17
                            else
                                songID = songID - 1
                            end
                        end
                        updatePlayText()
                    elseif truemouseX > 950 and truemouseX < 1000 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if not creditsShowingLegacy then
                            if songID == 5 then
                                songID = 1
                            else
                                songID = songID + 1
                            end
                        elseif creditsShowingLegacy then
                            if songID == 17 then
                                songID = 1
                            else
                                songID = songID + 1
                            end
                        end
                        updatePlayText()
                    end
                end
            end

            if keyboardJustPressed('RIGHT') then
                alwaysTrue = true
                runTimer('changeButtonCooldown', 0.2)
                if not creditsShowingLegacy then
                    if songID == 5 then
                        songID = 1
                    else
                        songID = songID + 1
                    end
                elseif creditsShowingLegacy then
                    if songID == 17 then
                        songID = 1
                    else
                        songID = songID + 1
                    end
                end
                updatePlayText()
            end

            if keyboardJustPressed('LEFT') then
                alwaysTrue = true
                runTimer('changeButtonCooldown', 0.2)
                if not creditsShowingLegacy then
                    if songID == 1 then
                        songID = 5
                    else
                        songID = songID - 1
                    end
                elseif creditsShowingLegacy then
                    if songID == 1 then
                        songID = 17
                    else
                        songID = songID - 1
                    end
                end
                updatePlayText()
            end
        end
    end

    if currentScreen == 'legacy' then
        if keyboardJustPressed('BACKSPACE') then
            currentScreen = 'play'
            playSound('backmenu')
            transitionToPlay()
        end

        if keyboardJustPressed('ENTER') then
            transitionToSong()
        end

        if truemouseX < 1228 and truemouseX > 885 then
            if truemouseY > 47 and truemouseY < 229 then
                currentlySelectedButton = 4
            else
                currentlySelectedButton = 0
            end
        else
            if truemouseX < 807 and truemouseX > 465 then
                if truemouseY > 472 and truemouseY < 654 then
                    currentlySelectedButton = 5
                else
                    currentlySelectedButton = 0
                end
            else
                currentlySelectedButton = 0
            end
        end

        if currentlySelectedButton == 0 then
            if truemouseX > 393 and truemouseX < 503 then
                if truemouseY > 173 - 85 and truemouseY < 280 - 85 then
                    if hasFixes then
                        currentlySelectedButton = 9
                    end
                end
            end
        end

        if currentlySelectedButton == 4 then
            if mouseClicked() then
                currentScreen = 'play'
                playSound('backmenu')
                transitionToPlay()
            end

            setProperty('backButtonOutline.visible', true)
        else
            setProperty('backButtonOutline.visible', false)
        end

        if currentlySelectedButton == 5 then
            if mouseClicked() then
                transitionToSong()
            end
            setProperty('playSongButtonOutline.visible', true)
        else
            setProperty('playSongButtonOutline.visible', false)
        end

        if currentlySelectedButton == 9 then
            if mouseClicked() then
                if checkFileExists('fixes.txt') then
                    if getTextFromFile('fixes.txt') == 'T' then
                        saveFile('fixes.txt', 'F')
                    elseif getTextFromFile('fixes.txt') == 'F' then
                        saveFile('fixes.txt', 'T')
                    else
                        saveFile('fixes.txt', 'T')
                    end

                    updateCheckBox2()
                end
            end
        end

        if keyboardJustPressed('B') then
            if checkFileExists('fixes.txt') then
                if getTextFromFile('fixes.txt') == 'T' then
                    saveFile('fixes.txt', 'F')
                elseif getTextFromFile('fixes.txt') == 'F' then
                    saveFile('fixes.txt', 'T')
                else
                    saveFile('fixes.txt', 'T')
                end
                
                updateCheckBox2()
            end
        end

        if alwaysTrue then
            if mouseClicked() then
                if truemouseY < 423 and truemouseY > 350 then
                    if truemouseX < 303 and truemouseX > 250 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if songID == 1 then
                            songID = 17
                        else
                            songID = songID - 1
                        end
                        updatePlayText()
                    elseif truemouseX > 950 and truemouseX < 1000 then
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                        if songID == 17 then
                            songID = 1
                        else
                            songID = songID + 1
                        end
                        updatePlayText()
                    end
                end
            end
        end

        if keyboardJustPressed('RIGHT') then
            alwaysTrue = true
            runTimer('changeButtonCooldown', 0.2)
            if songID == 17 then
                songID = 1
            else
                songID = songID + 1
            end
            updatePlayText()
        end
        if keyboardJustPressed('LEFT') then
            runTimer('changeButtonCooldown', 0.2)
            alwaysTrue = true
            if songID == 1 then
                songID = 17
            else
                songID = songID - 1
            end
            updatePlayText()
        end
    end

    if currentScreen == 'settings' then
        if keyboardJustPressed('BACKSPACE') then
            transitionToTitle()
        end

        if truemouseX < 1228 and truemouseX > 885 then
            if truemouseY > 47 and truemouseY < 229 then
                currentlySelectedButton = 4
            else
                currentlySelectedButton = 0
            end
        else
            if truemouseY > 45 and truemouseY < 227 then
                if truemouseX < 393 and truemouseX > 50 then
                    currentlySelectedButton = 7
                else
                    currentlySelectedButton = 0
                end
            else
                if truemouseX < 354 and truemouseX > 243 then
                    if truemouseY > 583 and truemouseY < 689 then
                        currentlySelectedButton = 8
                    else
                        currentlySelectedButton = 0
                    end
                else
                    currentlySelectedButton = 0
                end
            end
        end

        if mouseClicked() then
            if truemouseY > 450 and truemouseY < 560 then
                if truemouseX < 320 and truemouseX > 265 then
                    -- left arrow logic
                    setTextString('musicSettingText', '< Sonic Rewrite R2 >')

                    if checkFileExists('titleMusic.txt') then
                        if getTextFromFile('titleMusic.txt') == 'B' then
                            saveFile('scrambled_egg/titleMusic.txt', 'S')
                            playSound('scrollMenu')
                            syncMusic()
                        end
                    else
                        saveFile('scrambled_egg/titleMusic.txt', 'S')
                        playSound('scrollMenu')
                        syncMusic()
                    end
                end

                if truemouseX < 985 and truemouseX > 935 then
                    -- right arrow logic
                    setTextString('musicSettingText', '< Blast Processing >')

                    if checkFileExists('titleMusic.txt') then
                        if getTextFromFile('titleMusic.txt') == 'S' then
                            saveFile('scrambled_egg/titleMusic.txt', 'B')
                            playSound('scrollMenu')
                            syncMusic()
                        end
                    else
                        saveFile('scrambled_egg/titleMusic.txt', 'B')
                        playSound('scrollMenu')
                        syncMusic()
                    end
                end
            end
        end

        if keyboardJustPressed('RIGHT') then
            setTextString('musicSettingText', '< Blast Processing >')
            if checkFileExists('titleMusic.txt') then
                if getTextFromFile('titleMusic.txt') == 'S' then
                    saveFile('scrambled_egg/titleMusic.txt', 'B')
                    playSound('scrollMenu')
                    syncMusic()
                end
            else
                saveFile('scrambled_egg/titleMusic.txt', 'B')
                playSound('scrollMenu')
                syncMusic()
            end
        end

        if keyboardJustPressed('LEFT') then
            setTextString('musicSettingText', '< Sonic Rewrite R2 >')
            if checkFileExists('titleMusic.txt') then
                if getTextFromFile('titleMusic.txt') == 'B' then
                    saveFile('scrambled_egg/titleMusic.txt', 'S')
                    playSound('scrollMenu')
                    syncMusic()
                end
            else
                saveFile('scrambled_egg/titleMusic.txt', 'S')
                playSound('scrollMenu')
                syncMusic()
            end
        end

        if keyboardJustPressed('P') then
            transitionToPsychSettings()
        end

        if keyboardJustPressed('ENTER') then
            if checkFileExists('windowmovements.txt') then
                if getTextFromFile('windowmovements.txt') == 'T' then
                    saveFile('windowmovements.txt', 'F')
                    updateCheckBox()
                elseif getTextFromFile('windowmovements.txt') == 'F' then
                    saveFile('windowmovements.txt', 'T')
                    updateCheckBox()
                else
                    saveFile('windowmovements.txt', 'F')
                    updateCheckBox()
                end
            end
        end

        if currentlySelectedButton == 4 then
            if mouseClicked() then
                transitionToTitle()
            end

            setProperty('backButtonOutline.visible', true)
        else
            setProperty('backButtonOutline.visible', false)
        end

        if currentlySelectedButton == 7 then
            if mouseClicked() then
                transitionToPsychSettings()
            end

            setProperty('psychButtonOutline.visible', true)
        else
            setProperty('psychButtonOutline.visible', false)
        end

        if currentlySelectedButton == 8 then
            if mouseClicked() then
                if checkFileExists('windowmovements.txt') then
                    if getTextFromFile('windowmovements.txt') == 'T' then
                        saveFile('windowmovements.txt', 'F')
                        updateCheckBox()
                    elseif getTextFromFile('windowmovements.txt') == 'F' then
                        saveFile('windowmovements.txt', 'T')
                        updateCheckBox()
                    else
                        saveFile('windowmovements.txt', 'F')
                        updateCheckBox()
                    end
                end
            end
        end
    end

    if currentScreen == 'title' then
        if truemouseX < 402 and truemouseX > -15 then

            if truemouseY > 72 and truemouseY < 254 then
                currentlySelectedButton = 1
            elseif truemouseY > 272 and truemouseY < 454 then
                currentlySelectedButton = 2
            elseif truemouseY > 472 and truemouseY < 654 then
                currentlySelectedButton = 3
            else
                currentlySelectedButton = 0
            end

            if currentlySelectedButton == 1 then
                if mouseClicked() then
                    currentScreen = 'play'
                    setProperty('legacyVersionIndicator.alpha', 0)
                    transitionToPlay()
                end
            end

            if currentlySelectedButton == 2 then
                if mouseClicked() then
                    currentScreen = 'settings'
                    transitionToSettings()
                end
            end

            if currentlySelectedButton == 3 then
                if mouseClicked() then
                    currentScreen = 'credits'
                    transitionToCredits()
                end
            end
            
            updateButtonOutline()
        else
            if alwaysTrue then
                if keyboardJustPressed('DOWN') then
                    if currentlySelectedButton == 0 then
                        currentlySelectedButton = 1
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -99, keyboardTitleMovement, 'quartOut')
                        end

                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    end
                    if currentlySelectedButton == 1 then
                        currentlySelectedButton = 2
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -66, keyboardTitleMovement, 'quartOut')
                        end
                        
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    elseif currentlySelectedButton == 2 then
                        currentlySelectedButton = 3
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -33, keyboardTitleMovement, 'quartOut')
                        end

                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    end
                end

                if keyboardJustPressed('UP') then
                    if currentlySelectedButton == 0 then
                        currentlySelectedButton = 1
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -99, keyboardTitleMovement, 'quartOut')
                        end

                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    end
                    if currentlySelectedButton == 2 then
                        currentlySelectedButton = 1
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -99, keyboardTitleMovement, 'quartOut')
                        end
                        
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    end
                    if currentlySelectedButton == 3 then
                        currentlySelectedButton = 2
                        if currentlyUsedControl == 'keyboard' then
                            doTweenY('titleBG-keyboardmovement', 'titleBG', -66, keyboardTitleMovement, 'quartOut')
                        end
                        
                        alwaysTrue = true
                        runTimer('changeButtonCooldown', 0.2)
                    end
                end

                if keyboardJustPressed('ENTER') then
                    if currentlySelectedButton == 1 then
                        currentScreen = 'play'
                        setProperty('legacyVersionIndicator.alpha', 0)
                        transitionToPlay()
                    end
                
                    if currentlySelectedButton == 2 then
                        currentScreen = 'settings'
                        transitionToSettings()
                    end
                
                    if currentlySelectedButton == 3 then
                        currentScreen = 'credits'
                        transitionToCredits()
                    end
                end

                if keyboardJustPressed('ANY') then
                    updateButtonOutline()
                end
            end
        end
    end

    lastFrameMouse = truemouseX .. truemouseY
    usedKeyboardLastFrame = false

    if keyboardPressed('ANY') then
        usedKeyboardLastFrame = true
    else
        usedKeyboardLastFrame = false
    end        
end

--[[
    V1:

    Chat
    Paranoia
    Cat-Overdose
    Light-Warmup

    V2:

    Debate
    Paranoia
    Cat-Overdue
    No-Modding
    Good-Friends

    V3:

    Debate
    Paranoia
    Cat-Overdone
    Cat-Overdue
    Modding-Land
    No-Modding
    Good-Friends
    Finale

    V4:

    Takeover
    Blast-Processing
    Rivalry
    Budget-Cuts
    Cross-Platform
]]

function updatePlayText()
    if currentScreen == 'play' then
        setTextSize('loreText', 32)
        if songID == 1 then
            setTextString('playSelectedText', 'takeover')
        end
        if songID == 2 then
            setTextString('playSelectedText', 'blast processing')
        end
        if songID == 3 then
            setTextString('playSelectedText', 'rivalry')
        end
        if songID == 4 then
            setTextString('playSelectedText', 'budget cuts')
        end
        if songID == 5 then
            setTextString('playSelectedText', 'cross platform')
        end
    elseif currentScreen == 'legacy' then
        setTextSize('loreText', 32)
        hasFixes = false

        if songID == 1 then
            setTextString('playSelectedText', 'debate')
            hasFixes = true
        end
        if songID == 2 then
            setTextString('playSelectedText', 'paranoia')
            hasFixes = true
        end
        if songID == 3 then
            setTextString('playSelectedText', 'cat overdone')
        end
        if songID == 4 then
            setTextString('playSelectedText', 'cat overdue')
            hasFixes = true
        end
        if songID == 5 then
            setTextString('playSelectedText', 'modding land')
            hasFixes = true
        end
        if songID == 6 then
            setTextString('playSelectedText', 'no modding')
        end
        if songID == 7 then
            setTextString('playSelectedText', 'good friends')
        end
        if songID == 8 then
            setTextString('playSelectedText', 'finale')
            hasFixes = true
        end
        if songID == 9 then
            setTextString('playSelectedText', 'debate')
        end
        if songID == 10 then
            setTextString('playSelectedText', 'paranoia')
        end
        if songID == 11 then
            setTextString('playSelectedText', 'cat overdue')
        end
        if songID == 12 then
            setTextString('playSelectedText', 'no modding')
        end
        if songID == 13 then
            setTextString('playSelectedText', 'good friends')
        end
        if songID == 14 then
            setTextString('playSelectedText', 'chat')
        end
        if songID == 15 then
            setTextString('playSelectedText', 'paranoia')
        end
        if songID == 16 then
            setTextString('playSelectedText', 'cat overdose')
            hasFixes = true
        end
        if songID == 17 then
            setTextString('playSelectedText', 'light warmup')
        end

        if hasFixes then
            doTweenY('pullDownFixCheck', 'fixCheck', 85, 1, 'quartOut')
        else
            doTweenY('pullDownFixCheck', 'fixCheck', -150, 1, 'quartOut')
        end
    end

    if currentScreen == 'credits' then
        setTextSize('loreText', 28)

        if not creditsShowingLegacy then
            if songID == 1 then
                setTextString('playSelectedText', 'takeover')
            end
            if songID == 2 then
                setTextString('playSelectedText', 'blast processing')
            end
            if songID == 3 then
                setTextString('playSelectedText', 'rivalry')
            end
            if songID == 4 then
                setTextString('playSelectedText', 'budget cuts')
            end
            if songID == 5 then
                setTextString('playSelectedText', 'cross platform')
            end
        elseif creditsShowingLegacy then
            if songID == 1 then
                setTextString('playSelectedText', 'debate')
            end
            if songID == 2 then
                setTextString('playSelectedText', 'paranoia')
            end
            if songID == 3 then
                setTextString('playSelectedText', 'cat overdone')
            end
            if songID == 4 then
                setTextString('playSelectedText', 'cat overdue')
            end
            if songID == 5 then
                setTextString('playSelectedText', 'modding land')
            end
            if songID == 6 then
                setTextString('playSelectedText', 'no modding')
            end
            if songID == 7 then
                setTextString('playSelectedText', 'good friends')
            end
            if songID == 8 then
                setTextString('playSelectedText', 'finale')
            end
            if songID == 9 then
                setTextString('playSelectedText', 'debate')
            end
            if songID == 10 then
                setTextString('playSelectedText', 'paranoia')
            end
            if songID == 11 then
                setTextString('playSelectedText', 'cat overdue')
            end
            if songID == 12 then
                setTextString('playSelectedText', 'no modding')
            end
            if songID == 13 then
                setTextString('playSelectedText', 'good friends')
            end
            if songID == 14 then
                setTextString('playSelectedText', 'chat')
            end
            if songID == 15 then
                setTextString('playSelectedText', 'paranoia')
            end
            if songID == 16 then
                setTextString('playSelectedText', 'cat overdose')
            end
            if songID == 17 then
                setTextString('playSelectedText', 'light warmup')
            end
        end
    end

    removeLuaSprite('legacyVersionIndicator')

    if songID < 9 then
        makeLuaSprite('legacyVersionIndicator', 'versionLogos/v3', 0, 0)
        legacyVersion = 3
    end
    if songID < 14 and songID > 8 then
        makeLuaSprite('legacyVersionIndicator', 'versionLogos/v2', 0, 0)
        legacyVersion = 2
    end
    if songID < 18 and songID > 13 then
        makeLuaSprite('legacyVersionIndicator', 'versionLogos/v1', 0, 0)
        legacyVersion = 1
    end

    setObjectCamera('legacyVersionIndicator', 'hud')
    addLuaSprite('legacyVersionIndicator', true)
    setObjectOrder('legacyVersionIndicator', 15)
    scaleObject('legacyVersionIndicator', legacyVersionSize, legacyVersionSize, true)

    updateLoreText()
end

function updateLoreText()
    if currentScreen == 'play' then
        if songID == 1 then
            setTextString('loreText', 'even family is willing to fight, as tyler joins the battle.')
        end
        if songID == 2 then
            setTextString('loreText', 'huy comes again to fight, this time compressing the game files...')
        end
        if songID == 3 then
            setTextString('loreText', 'redguy fights once again, cheating in an attempt to win.')
        end
        if songID == 4 then
            setTextString('loreText', 'tung tung bf budget bye bye brainrot 100')
        end
        if songID == 5 then
            setTextString('loreText', 'an unexpected clone comes to fight egg...')
        end
    elseif currentScreen == 'legacy' then
        if songID == 1 then
            setTextString('loreText', 'egg and redguy have a debate about pancakes vs waffles.')
        end
        if songID == 2 then
            setTextString('loreText', 'redguy hacks into eggs computer and has a little fun.')
        end
        if songID == 3 then
            setTextString('loreText', 'huy attempts to poison ray but ends up making him grow.')
        end
        if songID == 4 then
            setTextString('loreText', 'after ray is transformed, he comes to attack pico.')
        end
        if songID == 5 then
            setTextString('loreText', 'redguy finds huy in modding land, and huy bans modding.')
        end
        if songID == 6 then
            setTextString('loreText', 'since modding is banned, egg is arrested for modding.')
        end
        if songID == 7 then
            setTextString('loreText', 'egg has a good time with his friends.')
        end
        if songID == 8 then
            setTextString('loreText', 'after all of his attempts fail, huy confronts egg himself...')
        end
        if songID > 8 and songID < 14 then
            if getRandomInt(0, 20) == 1 then -- 5% chance for secret message
                setTextString('loreText', 'lowkey i dont like v2 as its just v3 but worse')
            else
                setTextString('loreText', 'no lore is available for this song.')
            end
        end
        if songID == 14 then
            setTextString('loreText', "'yo wsg chat'")
        end
        if songID == 15 then
            setTextString('loreText', 'redguy makes huy evil')
        end
        if songID == 16 then
            setTextString('loreText', 'millie and friends have a fun battle')
        end
        if songID == 17 then
            setTextString('loreText', 'just a slightly difficult song')
        end
    end  

    if currentScreen == 'credits' then
        if not creditsShowingLegacy then
            if songID == 1 then
                setTextString('loreText', 'OG Song + BG: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 2 then
                setTextString('loreText', 'OG Song: Marios Madness, BG: Nintendo, Everything Else: scrambled_egg3')
            end
            if songID == 3 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, Everything Else + Chart: scrambled_egg3')
            end
            if songID == 4 then
                setTextString('loreText', 'OG Art: FNF, Everything Else: scrambled_egg3')
            end
            if songID == 5 then
                setTextString('loreText', 'OG Song + Chart: VS Impostor, Everything Else: scrambled_egg3')
            end
        elseif creditsShowingLegacy then
            if songID == 1 then
                setTextString('loreText', 'OG Song: VS. Hecker, Everything Else: scrambled_egg3')
            end
            if songID == 2 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, Cover: redguy, Everything Else: scrambled_egg3')
            end
            if songID == 3 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 4 then
                setTextString('loreText', 'OG Song + Pico: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 5 then
                setTextString('loreText', 'OG Song + BG: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 6 then
                setTextString('loreText', 'OG Song + BG: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 7 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, BG: FNF, Everything Else: scrambled_egg3')
            end
            if songID == 8 then
                setTextString('loreText', 'OG Song, BG + Chart: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 9 then
                setTextString('loreText', 'OG Song: VS. Hecker, Everything Else: scrambled_egg3')
            end
            if songID == 10 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 11 then
                setTextString('loreText', 'OG Song + Pico: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 12 then
                setTextString('loreText', 'OG Song + BG: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 13 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, BG: FNF, Everything Else: scrambled_egg3')
            end
            if songID == 14 then
                setTextString('loreText', 'OG Song + Chart: VS. Hecker, Everything Else: scrambled_egg3')
            end
            if songID == 15 then
                setTextString('loreText', 'OG Song + Chart: Marios Madness, Everything Else: scrambled_egg3')
            end
            if songID == 16 then
                setTextString('loreText', 'OG Song: KingSammelot, Everything Else: scrambled_egg3')
            end
            if songID == 17 then
                setTextString('loreText', 'OG Song, Sprites, BG: Marios Madness, Chart: scrambled_egg3')
            end
        end
    end
end

function transitionToPsychSettings() -- https://gamebanana.com/questions/53912
    runHaxeCode([[ // better as it transitions away from hardcoded
        import options.OptionsState;
        import backend.MusicBeatState;
        game.paused = true; // For lua
        game.vocals.volume = 0;
        MusicBeatState.switchState(new OptionsState());
        // if (ClientPrefs.data.pauseMusic != 'None') {
        //     FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), game.modchartSounds('pauseMusic').volume);
        //     FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.8);
        //     FlxG.sound.music.time = game.modchartSounds('pauseMusic').time;
        // }
        OptionsState.onPlayState = true;
    ]])

    --[[
    if isCompiledFromEGG then
        --triggerEvent('Open Options Menu') -- source code event; name explains what it does
    else
        debugPrint('This feature is unavailable. Try switching to EGGs compiled exe?', 'FF0000')
        playSound('denied')
    end
    ]]
end

function transitionToSong()
    if currentScreen == 'play' then
        if songID == 1 then
            loadSong('takeover')
        end
        if songID == 2 then
            loadSong('blast-processing')
        end
        if songID == 3 then
            loadSong('rivalry')
        end
        if songID == 4 then
            loadSong('budget-cuts')
        end
        if songID == 5 then
            loadSong('cross-platform')
        end
    elseif currentScreen == 'legacy' then
        if songID == 1 then
            loadSong('v3-debate')
        end
        if songID == 2 then
            loadSong('v3-paranoia')
        end
        if songID == 3 then
            loadSong('v3-cat-overdone')
        end
        if songID == 4 then
            loadSong('v3-cat-overdue')
        end
        if songID == 5 then
            loadSong('v3-modding-land')
        end
        if songID == 6 then
            loadSong('v3-no-modding')
        end
        if songID == 7 then
            loadSong('v3-good-friends')
        end
        if songID == 8 then
            loadSong('v3-finale')
        end
        if songID == 9 then
            loadSong('v2-debate')
        end
        if songID == 10 then
            loadSong('v2-paranoia')
        end
        if songID == 11 then
            loadSong('v2-cat-overdue')
        end
        if songID == 12 then
            loadSong('v2-no-modding')
        end
        if songID == 13 then
            loadSong('v2-good-friends')
        end
        if songID == 14 then
            loadSong('v1-chat')
        end
        if songID == 15 then
            loadSong('v1-paranoia')
        end
        if songID == 16 then
            if getTextFromFile('fixes.txt') == 'T' then
                loadSong('v1-cat-overdose-fixes')
            elseif getTextFromFile('fixes.txt') == 'F' then
                loadSong('v1-cat-overdose')
            end
        end
        if songID == 17 then
            loadSong('v1-light-warmup')
        end
    end
end

function updateButtonOutline()
    if currentlySelectedButton == 1 then
        setProperty('playButtonOutline.y', 65)
    end

    if currentlySelectedButton == 2 then
        setProperty('playButtonOutline.y', 265)
    end

    if currentlySelectedButton == 3 then
        setProperty('playButtonOutline.y', 465)
    end

    if currentlySelectedButton == 4 then
        setProperty('playButtonOutline.y', 10000)
    end
end

function transitionToSettings()
    triggerEvent('updateRPC', rpcIndicator .. '- settings', false)

    cancelTween('pullDownSettings')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownMusicSetting1')
    cancelTween('pullDownMusicSetting2')
    cancelTween('pullDownpsychButton2')
    cancelTween('pullDownpsychButton2')
    cancelTween('pushUppsychButton1')
    cancelTween('pushUppsychButton2')

    doTweenAlpha('GCTextOpacityTween', 'GCText', 0, 0.5, 'linear')
    doTweenAlpha('GCBarOpacityTween', 'GCBar', 0, 0.5, 'linear')
    doTweenY('pullDownpsychButton1', 'psychButton', 48, 1, 'quartOut')
    doTweenY('pullDownpsychButton2', 'psychButtonText', 75, 1, 'quartOut')
    doTweenY('pullDownSettings', 'settingsBG', -400, 1, 'quartOut')
    doTweenY('pullDownBackButton1', 'backButton', 50, 1, 'quartOut')
    doTweenY('pullDownBackButton2', 'backButtonText', 85, 1, 'quartOut')
    doTweenY('pullDownMusicSetting1', 'musicSettingText', 500, 1, 'quartOut')
    doTweenY('pullDownMusicSetting2', 'musicSettingInfoText', 300, 1, 'quartOut')
    doTweenY('pullCheck', 'lagCheck', 585, 1, 'quartOut')
    doTweenY('pullCheckText', 'lagText', 618, 1, 'quartOut')
end

function transitionToGallery()
    loadSong('gallery')
end

function transitionToPlay()
    triggerEvent('updateRPC', rpcIndicator .. '- play', false)

    cancelTween('pullDownSettings')
    cancelTween('pullDownMusicSetting1')
    cancelTween('pullDownMusicSetting2')
    cancelTween('pullDownFixCheck')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton2')
    cancelTween('pullDownCreditsButton1')
    cancelTween('pullDownCreditsButton2')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pullDownPlayBG')
    cancelTween('pushUpLegacyButton1')
    cancelTween('pushUpLegacyButton2')
    cancelTween('doTheThing')
    cancelTween('showLegacyVersionIndicator')
    cancelTween('hideLegacyVersionIndicator')
    cancelTween('loreBarOpacityTween')
    cancelTween('loreTextOpacityTween')


    songID = 1
    updatePlayText()

    doTweenColor('doTheThing', 'playBG', 'FFFFFF', 1)

    doTweenAlpha('showLegacyVersionIndicator', 'legacyVersionIndicator', 0, 0.5)
    doTweenAlpha('GCTextOpacityTween', 'GCText', 0, 0.5, 'linear')
    doTweenAlpha('GCBarOpacityTween', 'GCBar', 0, 0.5, 'linear')
    doTweenAlpha('loreTextOpacityTween', 'loreText', 1, 0.5, 'linear')
    doTweenAlpha('loreBarOpacityTween', 'loreBar', loreBarOpacity, 0.5, 'linear')
    doTweenY('pullDownPlayBG', 'playBG', -400, 1, 'quartOut')
    doTweenY('pullDownBackButton1', 'backButton', 50, 1, 'quartOut')
    doTweenY('pullDownBackButton2', 'backButtonText', 85, 1, 'quartOut')
    doTweenY('pullDownCreditsButton1', 'creditsButton', 475, 1, 'quartOut')
    doTweenY('pullDownCreditsButton2', 'creditsButtonText', 527, 1, 'quartOut')
    doTweenY('pullDownLegacyButton1', 'legacyButton', 48, 1, 'quartOut')
    doTweenY('pullDownLegacyButton2', 'legacyButtonText', 67, 1, 'quartOut')
    doTweenY('pullDownPlaySongText1', 'playSelectedText', 360, 1, 'quartOut')
    doTweenY('pullDownPlaySongText2', 'playSelectionText', 360, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton1', 'playSongButton', 475, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton2', 'playSongButtonText', 510, 1, 'quartOut')
    doTweenY('pullDownCreditsIndicator2', 'creditsText', 800, 1, 'quartOut')
    doTweenY('pullDownFixCheck', 'fixCheck', -150, 1, 'quartOut')
end

function transitionToLegacy()
    triggerEvent('updateRPC', rpcIndicator .. '- legacy songs', false)

    currentScreen = 'legacy'
    cancelTween('pullDownSettings')
    cancelTween('pullDownLegacyButton1')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pullDownMusicSetting1')
    cancelTween('pullDownMusicSetting2')
    cancelTween('pullDownFixCheck')
    cancelTween('pushUpSettings')
    cancelTween('pushUpLegacyButton1')
    cancelTween('pushUpLegacyButton2')
    cancelTween('pushUpMusicSetting1')
    cancelTween('pushUpMusicSetting2')
    cancelTween('doTheThing')
    cancelTween('showLegacyVersionIndicator')
    cancelTween('hideLegacyVersionIndicator')
    cancelTween('loreBarOpacityTween')
    cancelTween('loreTextOpacityTween')

    songID = 1
    updatePlayText()

    doTweenColor('doTheThing', 'playBG', '0aff0a', 1)

    doTweenAlpha('loreBarOpacityTween', 'loreBar', loreBarOpacity, 0.5, 'linear')
    doTweenAlpha('loreTextOpacityTween', 'loreText', 1, 0.5, 'linear')
    doTweenY('pushUpLegacyButton1', 'legacyButton', -200, 1, 'quartOut')
    doTweenY('pushUpLegacyButton2', 'legacyButtonText', -200, 1, 'quartOut')
    doTweenY('pullDownMusicSetting1', 'musicSettingText', -500, 1, 'quartOut')
    doTweenY('pullDownCreditsButton1', 'creditsButton', 750, 1, 'quartOut')
    doTweenY('pullDownCreditsButton2', 'creditsButtonText', 750, 1, 'quartOut')
    doTweenY('pullDownMusicSetting2', 'musicSettingInfoText', -500, 1, 'quartOut')
    doTweenY('pullDownFixCheck', 'fixCheck', 85, 1, 'quartOut')

    doTweenAlpha('showLegacyVersionIndicator', 'legacyVersionIndicator', 1, 1)
    setProperty('legacyVersionIndicator.visible', true)

    setProperty('legacyButtonOutline.visible', false)
end

function transitionToCredits()
    triggerEvent('updateRPC', rpcIndicator .. '- credits', false)

    cancelTween('pullDownCreditsBG1')
    cancelTween('pullDownCreditsBG2')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton2')
    cancelTween('pullDownSettings')
    cancelTween('pullDownMusicSetting1')
    cancelTween('pullDownMusicSetting2')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton2')
    cancelTween('pullDownCreditsButton1')
    cancelTween('pullDownCreditsButton2')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pushUpLegacyButton1')
    cancelTween('pushUpLegacyButton2')
    cancelTween('showLegacyVersionIndicator')
    cancelTween('hideLegacyVersionIndicator')
    cancelTween('loreBarOpacityTween')
    cancelTween('loreTextOpacityTween')

    updatePlayText()

    doTweenAlpha('GCTextOpacityTween', 'GCText', 0, 0.5, 'linear')
    doTweenAlpha('GCBarOpacityTween', 'GCBar', 0, 0.5, 'linear')
    doTweenAlpha('loreTextOpacityTween', 'loreText', 1, 0.5, 'linear')
    doTweenAlpha('loreBarOpacityTween', 'loreBar', loreBarOpacity, 0.5, 'linear')
    doTweenY('pullDownPlaySongText1', 'playSelectedText', 360, 1, 'quartOut')
    doTweenY('pullDownPlaySongText2', 'playSelectionText', 360, 1, 'quartOut')
    doTweenY('pullDownCreditsBG1', 'creditsBG-bottom', -720, 1, 'quartOut')
    doTweenY('pullDownCreditsBG2', 'creditsBG-top', 432, 1, 'quartOut')
    doTweenY('pullDownBackButton1', 'backButton', 50, 1, 'quartOut')
    doTweenY('pullDownBackButton2', 'backButtonText', 85, 1, 'quartOut')
    doTweenY('pullDownLegacyButton1', 'legacyButton', 48, 1, 'quartOut')
    doTweenY('pullDownLegacyButton2', 'legacyButtonText', 67, 1, 'quartOut')
    doTweenY('pullDownCreditsIndicator2', 'creditsText', 500, 1, 'quartOut')
end

function transitionToTitle()
    triggerEvent('updateRPC', rpcIndicator .. '- title', false)

    currentScreen = 'title'
    cancelTween('pullDownSettings')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton2')
    cancelTween('pullDownLegacyButton1')
    cancelTween('pullDownLegacyButton2')
    cancelTween('pullDownMusicSetting1')
    cancelTween('pullDownMusicSetting2')
    cancelTween('pushUpSettings')
    cancelTween('pushUpBackButton1')
    cancelTween('pushUpBackButton2')
    cancelTween('pushUpLegacyButton1')
    cancelTween('pushUpLegacyButton2')
    cancelTween('pushUpMusicSetting1')
    cancelTween('pushUpMusicSetting2')
    cancelTween('pullDownBackButton1')
    cancelTween('pullDownBackButton2')
    cancelTween('pullDownPlayBG')
    cancelTween('pushUpPlayBG')
    cancelTween('loreBarOpacityTween')
    cancelTween('loreTextOpacityTween')
    cancelTween('pullDownpsychButton2')
    cancelTween('pullDownpsychButton2')
    cancelTween('pushUppsychButton1')
    cancelTween('pushUppsychButton2')

    doTweenY('pushUpCreditsBG1', 'creditsBG-bottom', -1152, 1, 'quartOut')
    doTweenY('pushUpCreditsBG2', 'creditsBG-top', 720, 1, 'quartOut')
    doTweenY('pushUpPlayBG', 'playBG', 720, 1, 'quartOut')
    doTweenY('pushUpSettings', 'settingsBG', -1152, 1, 'quartOut')
    doTweenY('pushUpBackButton1', 'backButton', -200, 1, 'quartOut')
    doTweenY('pushUpBackButton2', 'backButtonText', -200, 1, 'quartOut')

    doTweenAlpha('GCTextOpacityTween', 'GCText', 1, 0.5, 'linear')
    doTweenAlpha('GCBarOpacityTween', 'GCBar', loreBarOpacity, 0.5, 'linear')

    doTweenY('pullDownpsychButton1', 'psychButton', -200, 1, 'quartOut')
    doTweenY('pullDownpsychButton2', 'psychButtonText', -200, 1, 'quartOut')
    doTweenY('pushUpLegacyButton1', 'legacyButton', -200, 1, 'quartOut')
    doTweenY('pushUpLegacyButton2', 'legacyButtonText', -200, 1, 'quartOut')
    doTweenY('pullDownMusicSetting1', 'musicSettingText', -500, 1, 'quartOut')
    doTweenY('pullDownMusicSetting2', 'musicSettingInfoText', -500, 1, 'quartOut')
    doTweenY('pullDownPlaySongText1', 'playSelectedText', -360, 1, 'quartOut')
    doTweenY('pullDownPlaySongText2', 'playSelectionText', -360, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton1', 'playSongButton', -360, 1, 'quartOut')
    doTweenY('pullDownPlaySongButton2', 'playSongButtonText', -360, 1, 'quartOut')
    doTweenY('pullDownCreditsButton1', 'creditsButton', -360, 1, 'quartOut')
    doTweenY('pullDownCreditsButton2', 'creditsButtonText', -360, 1, 'quartOut')
    doTweenY('pullCheck', 'lagCheck', 800, 1, 'quartOut')
    doTweenY('pullCheckText', 'lagText', 800, 1, 'quartOut')
    doTweenY('pullDownCreditsIndicator2', 'creditsText', 800, 1, 'quartOut')
    doTweenAlpha('loreBarOpacityTween', 'loreBar', 0, 0.5, 'linear')
    doTweenAlpha('loreTextOpacityTween', 'loreText', 0, 0.5, 'linear')

    setProperty('legacyVersionIndicator.visible', false)
    doTweenAlpha('hideInstantlyLegacyVersionIndicator', 'legacyVersionIndicator', 0, 0.000001)
    setProperty('fixText.y', -150)

    setProperty('backButtonOutline.visible', false)
    playSound('backmenu')
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