local timeToFinish = 1

-- made by scrambled_egg3
-- if you steal i steal your organs

function onEvent(name, value1, value2)
    if name == 'Transition To Boss' then
        timeToFinish = value1

        doTweenX('abcdefghijklmnopqrstuvwxyz', 'whitefloor', -360, timeToFinish, 'linear')
        doTweenX('xyzdefghijklmnopqrstuvwabc', 'black', 300, timeToFinish, 'linear')
    end
end