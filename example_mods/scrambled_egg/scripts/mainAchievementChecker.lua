local songsCompleted = 0
local curCheckAchievement = false

function onCreate()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
end

function onCreate()
    curCheckAchievement = isAchievementUnlocked('hasBeatDebate')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatParanoiaEGG')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatCatOverdone')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatCatOverdue')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatModdingLand')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatNoModding')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatGoodFriends')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatFinale')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('lovesScrambledEggs25')
    if not curCheckAchievement then
        if songsCompleted < 5 then
            setAchievementScore('lovesScrambledEggs25', songsCompleted, true)
        elseif songsCompleted == 5 then
            setAchievementScore('lovesScrambledEggs25', 5, true)
        end
    end

    if songsCompleted < 8 then
        setAchievementScore('hasBeatScrambledEggs25', songsCompleted, true)
    elseif songsCompleted == 8 then
        setAchievementScore('hasBeatScrambledEggs25', 8, true)
    end
end

function onCreate()
    curCheckAchievement = isAchievementUnlocked('hasBeatDebate')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatParanoiaEGG')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatCatOverdone')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatCatOverdue')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatModdingLand')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatNoModding')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatGoodFriends')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('hasBeatFinale')
    if curCheckAchievement then
        songsCompleted = songsCompleted + 1
    end

    curCheckAchievement = isAchievementUnlocked('lovesScrambledEggs25')
    if not curCheckAchievement then
        if songsCompleted < 5 then
            setAchievementScore('lovesScrambledEggs25', songsCompleted, true)
        elseif songsCompleted == 5 then
            setAchievementScore('lovesScrambledEggs25', 5, true)
        end
    end

    if songsCompleted < 8 then
        setAchievementScore('hasBeatScrambledEggs25', songsCompleted, true)
    elseif songsCompleted == 8 then
        setAchievementScore('hasBeatScrambledEggs25', 8, true)
    end
end