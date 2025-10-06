function onUpdate(elapsed)
    if keyboardJustPressed('F11') then
        if getPropertyFromClass("openfl.Lib", "application.window.fullscreen") then
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
        elseif not getPropertyFromClass("openfl.Lib", "application.window.fullscreen") then
            setPropertyFromClass("openfl.Lib", "application.window.fullscreen", true)
        end
    end
end