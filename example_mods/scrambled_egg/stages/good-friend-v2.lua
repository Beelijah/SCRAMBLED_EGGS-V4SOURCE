local targetStep = 912 -- this is the step where it becomes visible

-- originally by AI (idk scripting im sorry)
-- template made by scrambled_egg3

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
    print("onUpdate running. Elapsed:", elapsed, "Current Step:", currentStep)
    if currentStep >= targetStep then
        setProperty('yt.visible', true)
        setProperty('ytbg.visible', true)
    end
end