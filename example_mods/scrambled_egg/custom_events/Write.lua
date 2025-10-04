local text = test

-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you credit me

function onEvent(name, value1, value2)
    if name == 'Write' then
        text = value2
        if value1 == '1' then
            doTweenY('paperComeUp', 'paper', 780, 1, 'quartOut')
        elseif value1 == '0' then
            removeLuaText('moddingText')
            doTweenY('paperGoDown', 'paper', 1417, 1, 'quartOut')
        elseif value1 == '2' then
            setProperty('redModdingText.visible', true)
        elseif value1 == '3' then
            setProperty('redModdingText.visible', false)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'paperComeUp' then
        makeLuaText('moddingText', text, 0, 395)
        setTextFont('moddingText', 'arial-rounded-mt-bold.ttf')
        setTextSize('moddingText', 115)
        setTextWidth('moddingText', 458)
        setTextHeight('moddingText', 185)
        setTextAutoSize('moddingText', false)
        setTextColor('moddingText', 'gray') -- set 'gray' to 'red' for red (duh)
        setTextAlignment('moddingText', 'center')
        setTextBorder('moddingText', 0, 'black')
        setProperty('moddingText.y', 435)
        addLuaText('moddingText')
        
        makeLuaText('redModdingText', text, 0, 395)
        setTextFont('redModdingText', 'arial-rounded-mt-bold.ttf')
        setTextSize('redModdingText', 115)
        setTextWidth('redModdingText', 458)
        setTextHeight('redModdingText', 185)
        setTextAutoSize('redModdingText', false)
        setTextColor('redModdingText', 'red') -- set 'red' to 'gray' for gray (duh)
        setTextAlignment('redModdingText', 'center')
        setTextBorder('redModdingText', 0, 'black')
        setProperty('redModdingText.y', 435)
        addLuaText('redModdingText')
        setProperty('redModdingText.visible', false)
        doTweenY('paperComeUpMouseRefresh', 'paper', 780.001, 0.00001, 'linear')
    end
end