-- carpet | a scrapped v2 song

function onCreatePost()
    --startVideo('carpetSong', false, true, false, false) -- preload

    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('boyfriend.visible', false)
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)

    setProperty('comboGroup.x', 5000)

    noteTweenX('middlescroll', 4, 412, 0.00000015, 'linear')
    noteTweenX('middlescrolm', 5, 524, 0.00000015, 'linear')
    noteTweenX('middlescroln', 6, 636, 0.00000015, 'linear')
    noteTweenX('middlescrolo', 7, 748, 0.00000015, 'linear')

    noteTweenX('middlescrolp', 0, 5000, 0.00000015, 'linear')
    noteTweenX('middlescrolq', 1, 5000, 0.00000015, 'linear')
    noteTweenX('middlescrolr', 2, 5000, 0.00000015, 'linear')
    noteTweenX('middlescrols', 3, 5000, 0.00000015, 'linear')
end

function onPause()
    return Function_Stop;
end

function onStepHit()
    setHealth(2)
end

function onEndSong()
    loadSong('mainmenu')
end

function onSongStart()
    startVideo('carpetSong', false, true, false, true)

    setProperty('inCutscene', false) --       this code is not by scrambled_egg3
    setObjectCamera('videoCutscene', 'hud')-- see https://gamebanana.com/questions/73512
    setProperty('videoCutscene.antialiasing', false)
    setObjectOrder('videoCutscene', 1)
end