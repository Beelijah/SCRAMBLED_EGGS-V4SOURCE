local alwaysTrue = true
local variable = 1
-- idk why i made this but yes

function onUpdate(elapsed)
    if keyboardPressed('C') then
        if keyboardPressed('D') then
            repeat
                variable = variable + 1
            until alwaysTrue == false
        end
    end
end