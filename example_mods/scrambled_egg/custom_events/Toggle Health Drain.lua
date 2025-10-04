local isHealthDrainEnabled = 0

-- made by scrambled_egg3
-- if you steal i steal your organs
-- you can steal if you give credit

function onEvent(name, value1, value2)
    if name == 'Toggle Health Drain' then
        if value1 == '1' then
            isHealthDrainEnabled = 1
        elseif value1 == '0' then 
            isHealthDrainEnabled = 0
        end
    end
end

function opponentNoteHit(isSustain) -- i would make it so that "isSustainNote" would
    if isHealthDrainEnabled == 1 then--not do health drain but using it would give me
        health = getHealth()        -- random numbers from 25 to 0
        if health > 0.05 then
            health = health - 0.01
            setHealth(health)
        end
    end
end