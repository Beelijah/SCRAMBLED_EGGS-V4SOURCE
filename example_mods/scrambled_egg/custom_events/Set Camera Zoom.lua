local canNormallyZoomCamera = true

-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you credit me

function onEvent(name, value1, value2)
    if name == 'Set Camera Zoom' then

        if value2 == '-1' then
            doTweenZoom('camZoomEvent', 'game', value1, 1, 'quartOut')
            canNormallyZoomCamera = true
        else
            doTweenZoom('camZoomEvent', 'game', value1, value2, 'quartOut')
            canNormallyZoomCamera = false
        end
    end
end

function onUpdate(elapsed)
    if canNormallyZoomCamera then
        setProperty('camZooming', true)
    else
        setProperty('camZooming', false)
    end
end

function onCreate()
    setProperty('camZoomingMult', 0)
end