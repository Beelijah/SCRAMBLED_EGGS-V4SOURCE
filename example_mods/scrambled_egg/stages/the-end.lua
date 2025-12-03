-- paste this into the script

local hasFixes = true
local fps = 0.000000001

function onUpdate(elapsed)
    fps = elapsed

    if hasFixes then
        if curStep < 10 then
            noteTweenAlpha('hideHUDevent0', 0, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent1', 1, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent2', 2, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent3', 3, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent4', 4, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent5', 5, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent6', 6, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent7', 7, 0, elapsed / 1.01, 'linear')

            setProperty('healthBar.alpha', 0)
            setProperty('iconP1.alpha', 0)
            setProperty('iconP2.alpha', 0)
            setProperty('scoreTxt.alpha', 0)
            setProperty('timeTxt.alpha', 0)
            setProperty('timeBar.alpha', 0)
        end
    end
end

function onCreate()
    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end
end