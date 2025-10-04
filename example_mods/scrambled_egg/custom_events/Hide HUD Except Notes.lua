local value2 = 1 -- this helps if the user doesn't type anything for value2
-- made by scrambled_egg3
-- if you steal i steal your organs
-- this one you can steal if you credit me

function onEvent(name, value1, value2)
    if name == 'Hide HUD Except Notes' then
        if value1 == "1" then
            doTweenAlpha('hideHUDevent8', 'healthBar', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent9', 'iconP1', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent10', 'iconP2', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent11', 'scoreTxt', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent12', 'timeTxt', 0, value2, 'linear')
            doTweenAlpha('hideHUDevent13', 'timeBar', 0, value2, 'linear')
        elseif value1 == "0" then -- wow im actually getting really good at lua scripting
            doTweenAlpha('showHUDevent8', 'healthBar', 1, value2, 'linear')
            doTweenAlpha('showHUDevent9', 'iconP1', 1, value2, 'linear')
            doTweenAlpha('showHUDevent10', 'iconP2', 1, value2, 'linear')
            doTweenAlpha('showHUDevent11', 'scoreTxt', 1, value2, 'linear')
            doTweenAlpha('showHUDevent12', 'timeTxt', 1, value2, 'linear')
            doTweenAlpha('showHUDevent13', 'timeBar', 1, value2, 'linear')
        end
    end
end