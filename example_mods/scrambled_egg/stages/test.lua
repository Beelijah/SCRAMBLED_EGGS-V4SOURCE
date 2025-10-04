local iconscale = 1 -- mess with these
local iconspeed = 1

local iconmaxmomentum = 3
local iconaccelspeed = 0.001

local iconmomentum = 1 -- messing with this does nothing

function onCreate()
    makeLuaSprite('iconman', 'icons/icon-pico_run')
    setObjectCamera('iconman', 'hud')
    scaleObject('iconman', iconscale, iconscale)
    addLuaSprite('iconman')
end

function onUpdate(elapsed)
    setHealth(2)

    print('' .. iconmomentum)
    if keyboardPressed('J') then
        setProperty('iconman.x', getProperty('iconman.x') - iconspeed * iconmomentum)
        if iconmomentum < iconmaxmomentum then
            iconmomentum = iconmomentum + iconaccelspeed
        end
    end
    if keyboardPressed('L') then
        setProperty('iconman.x', getProperty('iconman.x') + iconspeed * iconmomentum)
        if iconmomentum < iconmaxmomentum then
            iconmomentum = iconmomentum + iconaccelspeed
        end
    end
    if keyboardPressed('K') then
        setProperty('iconman.y', getProperty('iconman.y') + iconspeed * iconmomentum)
        if iconmomentum < iconmaxmomentum then
            iconmomentum = iconmomentum + iconaccelspeed
        end
    end
    if keyboardPressed('I') then
        setProperty('iconman.y', getProperty('iconman.y') - iconspeed * iconmomentum)
        if iconmomentum < iconmaxmomentum then
            iconmomentum = iconmomentum + iconaccelspeed
        end
    end

    if not keyboardPressed('I') then
        if not keyboardPressed('J') then
            if not keyboardPressed('K') then
                if not keyboardPressed('L') then
                    iconmomentum = 1
                end
            end
        end
    end
end