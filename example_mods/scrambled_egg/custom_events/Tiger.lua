-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you credit me

function onEvent(name, value1, value2)
    if name == 'Tiger' then
        TigerMoveDuration = value1

        if value2 == '' then
            doTweenX('tigerMove', 'tiger', 2160, TigerMoveDuration) -- dont need 'linear' since it defaults to it
        elseif value2 == '1' then
            setProperty('tiger.x', 2160)
            doTweenX('tigerMove', 'tiger', -1100, TigerMoveDuration) -- dont need 'linear' since it defaults to it
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'tigerMove' then
        setProperty('tiger.x', -1100)
    end
end