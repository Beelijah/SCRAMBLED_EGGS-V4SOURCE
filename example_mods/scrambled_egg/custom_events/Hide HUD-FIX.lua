local value2 = 1 -- this helps if the user doesn't type anything for value2
local isDebuggingScript = 0 -- set to 1 for debugging this script, 0 to not.
-- made by scrambled_egg3
-- if you steal i steal your organs
-- this one you can steal if you credit me

function onEvent(name, value1, value2)
    if name == 'Hide HUD-FIX' then
        print('Hide HUD event called!')
        print('Hide HUD by scrambled_egg3')
        if value1 == "1" then
            if isDebuggingScript == 1 then
                debugPrint('Received Request to Hide HUD for ' .. value2 .. ' second(s).')
            end
            noteTweenAlpha('hideHUDevent0', 0, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent1', 1, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent2', 2, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent3', 3, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent4', 4, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent5', 5, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent6', 6, 0, value2, 'linear')
            noteTweenAlpha('hideHUDevent7', 7, 0, value2, 'linear')

            doTweenAlpha('hideHUDevent8', 'healthBar', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent9', 'iconP1', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent10', 'iconP2', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent11', 'scoreTxt', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent12', 'timeTxt', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent13', 'timeBar', 0, value2, 'linear')

        elseif value1 == "0" then -- wow im actually getting really good at lua scripting
            if isDebuggingScript == 1 then
                debugPrint('Received Request to Show HUD for ' .. value2 .. ' second(s).')
            end
            noteTweenAlpha('showHUDevent0', 0, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent1', 1, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent2', 2, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent3', 3, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent4', 4, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent5', 5, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent6', 6, 1, value2, 'linear')
            noteTweenAlpha('showHUDevent7', 7, 1, value2, 'linear')

            doTweenAlpha('showHUDevent8', 'healthBar', 1, value2, 'linear')

            doTweenAlpha('showHUDevent9', 'iconP1', 1, value2, 'linear')
            doTweenAlpha('showHUDevent10', 'iconP2', 1, value2, 'linear')

            doTweenAlpha('showHUDevent11', 'scoreTxt', 1, value2, 'linear')
            doTweenAlpha('showHUDevent12', 'timeTxt', 1, value2, 'linear')
            doTweenAlpha('showHUDevent13', 'timeBar', 1, value2, 'linear')
        end
    end
end

function onTweenComplete(tag)
    if tag == 'hideHUDevent' then
        print('custom_events/Hide HUD.lua: Finished hiding HUD.')
    elseif tag == 'showHUDevent' then 
        print('custom_events/Hide HUD.lua: Finished showing HUD.')
    end
end