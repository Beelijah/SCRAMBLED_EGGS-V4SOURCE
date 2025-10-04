local cinematicMode = getModSetting('cinematicMode')

function onUpdate(elapsed)
    if cinematicMode then
        triggerEvent('Hide HUD', 1, 0.0000001)

        addHealth(2)
    end
end