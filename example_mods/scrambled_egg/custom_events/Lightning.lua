local thunderVolume = 300

-- made by scrambled_egg3
-- if you steal i steal your organs
-- if you credit me you can steal

function onCreate()
    setProperty('lightning.visible', false)

    makeLuaSprite('flashbang', 'white', getCameraFollowX() - 5000, getCameraFollowY() - 5000)
    scaleObject('flashbang', 100, 100)
    setObjectCamera('flashbang')
    addLuaSprite('flashbang')
    setProperty('flashbang.visible', false)
end

function onEvent(name, value1, value2)
    if name == 'Lightning' then
        setProperty('lightning.visible', true)
        playAnim('lightning', 'flash', true)
        runTimer('lightningfinish', 0.34)
        playSound('thunder', 1)

        if value2 == '1' then
            setObjectCamera('flashbang')
        elseif value2 == '2' then
            setObjectCamera('flashbang', 'hud')
        end

        if value1 == '1' then
            if value2 == '1' then
                doTweenAlpha('flash', 'flashbang', 0.75, 0.00000000001)
            else
                doTweenAlpha('flash', 'flashbang', 1, 0.00000000001)
            end
        end
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'flash' then
        setProperty('flashbang.visible', true)
        doTweenAlpha('flashEND', 'flashbang', 0, 0.35)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'lightningfinish' then
        setProperty('lightning.visible', false)
    end
end