local isDebugging = false
local canCheckKey = true
 
function onCreate()
    makeLuaText('curStepText', ' ', '1280')
    setTextAlignment('curStepText')
    setTextSize('curStepText', 50)

    addLuaText('curStepText')
end

function onStepHit()
    if isDebugging then
        setTextString('curStepText', curStep)
    else
        setTextString('curStepText', ' ')
    end
end

function onUpdate()
    if keyboardPressed('SIX') then
        if canCheckKey then
            if isDebugging then
                isDebugging = false
            else
                isDebugging = true
            end
        end

        cancelTimer('keyboardPressedCoolDown6')
        canCheckKey = false
        runTimer('keyboardPressedCoolDown6', 0.1)
    end
end


function onTimerCompleted(tag)
    if tag == 'keyboardPressedCoolDown6' then
        canCheckKey = true
    end
end