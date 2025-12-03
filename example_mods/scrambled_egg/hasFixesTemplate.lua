-- paste this into the script

local hasFixes = true

function onCreate()
    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end
end