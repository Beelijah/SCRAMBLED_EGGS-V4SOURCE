local canDoAnything = true
-- used in collaboration with the source code edits to stitch together a discord status

function onCreate()
    if not isCompiledFromEGG then
        canDoAnything = false
    end

    if canDoAnything then
        updateDiscordPresence(false, 'none', false)
    end
end

function onEvent(event, value1, value2, strumTime)
    if event == 'updateRPC' then
        if canDoAnything then
            updateDiscordPresence(true, value1, value2)
        end
    end
end

--[[ 
    event notes:

    string,  value1: discord presence
    boolean, value2: whether or not the song name should be appended with value1
]]

function updateDiscordPresence(isFromEvent, value1, value2) 
    changeDiscordClientID('1422682667341713489')

    if isFromEvent then
        if value2 == 'true' then
            changeDiscordPresence(value1 .. songName)
        else
            changeDiscordPresence(value1)
        end

    else

        if songName == 'title' then
            if checkFileExists('hasFanChanted.txt') then
                if getTextFromFile('hasFanChanted.txt') == formattedDate then     
                    changeDiscordPresence('watching an animation')
                end
            end
        elseif songName == 'mainmenu' then
            changeDiscordPresence('roaming the menus - title')
        else
            changeDiscordPresence('playing: ' .. songName)
        end
    end
end