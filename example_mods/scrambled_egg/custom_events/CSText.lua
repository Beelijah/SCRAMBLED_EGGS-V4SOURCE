-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you credit me

-- ooo nice little text ooo wow

function onEvent(name, value1, value2)
    if name == 'CSText' then
        if value1 == '1' then
            playAnim('CS-TEXT', '1')
            updateOpacity()
        elseif value1 == '2' then
            playAnim('CS-TEXT', '2')
            updateOpacity()
        elseif value1 == '3' then
            playAnim('CS-TEXT', '3')
            updateOpacity()
        elseif value1 == '4' then
            playAnim('CS-TEXT', '4')
            updateOpacity()
        elseif value1 == '5' then
            playAnim('CS-TEXT', '5')
            updateOpacity()
        elseif value1 == '6' then
            playAnim('CS-TEXT', '6')
            updateOpacity()
        elseif value1 == '7' then
            playAnim('CS-TEXT', '7')
            updateOpacity()
        elseif value1 == '8' then
            playAnim('CS-TEXT', '8')
            updateOpacity()
        end
    end
end

function updateOpacity()
    cancelTween('CS-FADE')

    setProperty('CS-TEXT.alpha', 1)
    doTweenAlpha('CS-FADE', 'CS-TEXT', 0, 0.5, 'linear')
end

function onCreate()
    makeAnimatedLuaSprite('CS-TEXT', 'ooo-scary-cutscene', 350, 400)
    scaleObject('CS-TEXT', 0.75, 0.75, true)
    addAnimationByPrefix('CS-TEXT', '1', 'count0', 24, true)
    addAnimationByPrefix('CS-TEXT', '2', 'your', 24, true)
    addAnimationByPrefix('CS-TEXT', '3', 'sec0', 24, true)
    addAnimationByPrefix('CS-TEXT', '4', 'onds0', 24, true)
    addAnimationByPrefix('CS-TEXT', '5', 'i0', 24, true)
    addAnimationByPrefix('CS-TEXT', '6', 'will0', 24, true)
    addAnimationByPrefix('CS-TEXT', '7', 'end0', 24, true)
    addAnimationByPrefix('CS-TEXT', '8', 'you0', 24, true)

    addOffset('CS-TEXT', '1', 50, 0) -- adding offsets genuinely makes the text so much better
    addOffset('CS-TEXT', '2', -25, -35)
    addOffset('CS-TEXT', '3', -45, -50)
    addOffset('CS-TEXT', '4', -45, -35)
    addOffset('CS-TEXT', '5', -175, -65)
    addOffset('CS-TEXT', '6', -75, -65)
    addOffset('CS-TEXT', '7', -75, -65)
    addOffset('CS-TEXT', '8', -50, -65)

    setObjectCamera('CS-TEXT', 'hud')
    setObjectOrder('CS-TEXT', 500)
    addLuaSprite('CS-TEXT')

    setProperty('CS-TEXT.alpha', 0) -- HA I FIGURED OUT THE OBJECT VARIABLE
end