local targetStep = 2176 -- this is the step where it becomes visible

-- originally by AI (idk scripting im sorry)
-- template made by scrambled_egg3

function onCreate()
    setProperty('grass_anim.visible', false) -- REPLACE "object" WITH YOUR OBJECT NAME!!!
    setProperty('blythe-fly.visible', false)
    setProperty('appa-fly.visible', false)
    -- add any other events you want to occur at the start

    -- Force the onUpdate function to run every frame
    local function callOnUpdate(elapsed)
        onUpdate(elapsed)
        return callOnUpdate
    end
    setOnUpdate(callOnUpdate)
end

function onUpdate(elapsed)
    local currentStep = getProperty('curStep')
    print("onUpdate running. Elapsed:", elapsed, "Current Step:", currentStep) -- remove this if you dont want it to spam your console
    if currentStep >= targetStep then
        setProperty('grass_anim.visible', true) -- REPLACE "object" WITH YOUR OBJECT NAME!!!
        setProperty('appa.visible', false)         
        setProperty('blythe.visible', false)
        -- setProperty('appa-fly.visible', true)         
        -- setProperty('blythe-fly.visible', true)
        -- add any other events you want to occur at this point
    end
end