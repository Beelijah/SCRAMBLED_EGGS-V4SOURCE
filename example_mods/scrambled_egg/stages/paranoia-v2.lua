function onCreate()
    setProperty('black.visible', false)
    local function callOnUpdate(elapsed)
        onUpdate(elapsed)
        return callOnUpdate
    end
    setOnUpdate(callOnUpdate)
end
-- for any weirdos looking through here and wondering which lua scripts were first, it was the millie bros one, then the template, then this.
-- i guess future me is a weirdo as im looking through here to port old songs to v4
function onUpdate(elapsed)
    local cameraYPosition = getCameraFollowY()
    local cameraXPosition = getCameraFollowX()
    local currentStep = getProperty('curStep')
    print("Camera X Pos:", cameraXPosition, "Camera Y Pos:", cameraYPosition) -- remove this if you dont want it to spam your console
    if currentStep >= 1024 and currentStep <= 1039 then
        setProperty('black.visible', true)
    else
        setProperty('black.visible', false)
    end
end