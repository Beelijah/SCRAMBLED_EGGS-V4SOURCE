function onEndSong()
    unlockAchievement('hasBeatDebate')
end

function onCreate()
    doTweenAlpha('showRedTalk', 'redTalk', 0, 0.00000001, 'linear')
    doTweenAlpha('showEggTalk', 'eggTalk', 0, 0.00000001, 'linear')

    doTweenY('moveTutorialStartOffScreen', 'tutorial', -1400, 0.0000000000001, 'quartOut')
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    cancelTween('hideEggTalk')

    doTweenAlpha('showEggTalk', 'eggTalk', 1, 0.00000001, 'linear')
    doTweenAlpha('hideEggTalk', 'eggTalk', 0, 0.35, 'linear')
end

function onUpdate(elapsed)
    if curStep == 0 then
        doTweenY('moveTutorialOnScreen', 'tutorial', -95, crochet / 1000, 'quartOut')
    end

    if curStep == 60 then
        doTweenY('moveTutorialOffScreen', 'tutorial', 1200, crochet / 1000, 'quartOut')
    end
end

function goodNoteHit(index, noteData, noteType, isSustain)
    cancelTween('hideRedTalk')

    doTweenAlpha('showRedTalk', 'redTalk', 1, 0.00000001, 'linear')
    doTweenAlpha('hideRedTalk', 'redTalk', 0, 0.35, 'linear')
end