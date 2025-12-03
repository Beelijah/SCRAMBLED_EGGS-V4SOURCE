local hasFixes = true

function onEndSong()
    unlockAchievement('hasBeatDebate')
end

function onCreate()
    if getTextFromFile('fixes.txt') == 'F' then
        hasFixes = false
    end

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

        if hasFixes then
            noteTweenX('middlescroll', 4, 412, elapsed / 1.01, 'linear')
            noteTweenX('middlescrolm', 5, 524, elapsed / 1.01, 'linear')
            noteTweenX('middlescroln', 6, 636, elapsed / 1.01, 'linear')
            noteTweenX('middlescrolo', 7, 748, elapsed / 1.01, 'linear')
        end
    end

    if hasFixes then
        if curStep < 55 then
            noteTweenAlpha('hideHUDevent0', 0, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent1', 1, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent2', 2, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent3', 3, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent4', 4, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent5', 5, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent6', 6, 0, elapsed / 1.01, 'linear')
            noteTweenAlpha('hideHUDevent7', 7, 0, elapsed / 1.01, 'linear')

            doTweenAlpha('hideHUDevent8', 'healthBar', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent9', 'iconP1', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent10', 'iconP2', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent11', 'scoreTxt', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent12', 'timeTxt', 0, elapsed / 1.01, 'linear')
            doTweenAlpha('hideHUDevent13', 'timeBar', 0, elapsed / 1.01, 'linear')

            noteTweenX('hideHUDevent0-2', 0, -500, elapsed / 1.01, 'linear')
            noteTweenX('hideHUDevent1-2', 1, -500, elapsed / 1.01, 'linear')
            noteTweenX('hideHUDevent2-2', 2, -500, elapsed / 1.01, 'linear')
            noteTweenX('hideHUDevent3-2', 3, -500, elapsed / 1.01, 'linear')
        end
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