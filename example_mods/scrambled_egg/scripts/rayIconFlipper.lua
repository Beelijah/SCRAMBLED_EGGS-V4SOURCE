local IconFlipX = false

function onBeatHit()
    if dadName == 'ray' or dadName == 'ray-evil' or dadName == 'ray-evil-run' or dadName == 'ray-sweating' then
        IconFlipX = getProperty('iconP2.flipX')

        if IconFlipX then
            setProperty('iconP2.flipX', false)
        else
            setProperty('iconP2.flipX', true)
        end
    end

    if boyfriendName == 'ray-playable' then
        IconFlipX = getProperty('iconP1.flipX')

        if IconFlipX then
            setProperty('iconP1.flipX', false)
        else
            setProperty('iconP1.flipX', true)
        end
    end
end
