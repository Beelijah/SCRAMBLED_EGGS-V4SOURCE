-- made by scrambled_egg3
-- specifically made for vs scrambled eggs
-- idk how this would work on other mods

function onEvent(name, value1, value2)
    if name == 'Hide Pico Up Arm' then
        setProperty('picoUpArm.visible', false)
        triggerEvent('Play Animation','idle', 'bf')
    end
end