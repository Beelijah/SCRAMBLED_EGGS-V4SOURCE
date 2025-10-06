local targetStep = 912 -- this is the step where it becomes visible

-- template made by scrambled_egg3

function onEndSong()        
    unlockAchievement('hasBeatGoodFriends')
end

function onCreate()
    setProperty('yt.visible', false)
    setProperty('ytbg.visible', false) 

    local function callOnUpdate(elapsed)
        onUpdate(elapsed)
        return callOnUpdate
    end
    setOnUpdate(callOnUpdate)
end

function onUpdate(elapsed)
    local currentStep = getProperty('curStep')
    --print("onUpdate running. Elapsed:", elapsed, "Current Step:", currentStep)
    if currentStep >= targetStep then
        setProperty('yt.visible', true)
        setProperty('ytbg.visible', true)
    end

    if currentStep > 714 then
        setHealth(1) -- yeah i know its kinda dumb to have this but i want people to appreciate the mod, not to get angry at the difficulty.
    end
end