local bgStartY
local FlashingLightsEnabled
-- made by scrambled_egg3
-- if you steal i steal your organs

function onCreate()
    FlashingLightsEnabled = flashingLights -- using thing in psych menu as v4 doesn't have mod settings
end

function onEvent(name, value1, value2)
    if name == 'BG Flash' then
        if FlashingLightsEnabled then
            triggerEvent('Play Animation', 'bump', 'gf')
            bgStartY = getProperty('headBg.y')

            doTweenY('headBgMoveDownTween', 'headBg', bgStartY + 60, 0.3333333, 'quartOut')
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'headBgMoveDownTween' then
	setProperty('headBg.y', bgStartY)    
	end
end