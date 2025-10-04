-- VERSION 1.0

function onCreate()
    print('/mods/scripts/eggsEssentials.lua: Initialized Eggs Essentials')
    print('/mods/scripts/eggsEssentials.lua: Script by @scrambled_egg3 on YouTube')
end

function onDestroy()
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    setPropertyFromClass('openfl.Lib', 'application.window.resizable', true)
end

function HideHUD(duration, easing)
    print('/mods/scripts/eggsEssentials.lua: Hide HUD function called!')
    
    noteTweenAlpha('HideHUD-essentials-0', 0, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-1', 1, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-2', 2, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-3', 3, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-4', 4, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-5', 5, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-6', 6, 0, duration, easing)
    noteTweenAlpha('HideHUD-essentials-7', 7, 0, duration, easing)

    doTweenAlpha('HideHUD-essentials-8', 'healthBar', 0, duration, easing)
    doTweenAlpha('HideHUD-essentials-9', 'iconP1', 0, duration, easing)
    doTweenAlpha('HideHUD-essentials-10', 'iconP2', 0, duration, easing)
    doTweenAlpha('HideHUD-essentials-11', 'scoreTxt', 0, duration, easing)
    doTweenAlpha('HideHUD-essentials-12', 'timeTxt', 0, duration, easing)
    doTweenAlpha('HideHUD-essentials-13', 'timeBar', 0, duration, easing)
end

function ShowHUD(duration, easing)
    print('/mods/scripts/eggsEssentials.lua: Show HUD function called!')

    noteTweenAlpha('ShowHUD-essentials-0', 0, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-1', 1, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-2', 2, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-3', 3, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-4', 4, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-5', 5, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-6', 6, 1, duration, easing)
    noteTweenAlpha('ShowHUD-essentials-7', 7, 1, duration, easing)

    doTweenAlpha('ShowHUD-essentials-8', 'healthBar', 1, duration, easing)
    doTweenAlpha('ShowHUD-essentials-9', 'iconP1', 1, duration, easing)
    doTweenAlpha('ShowHUD-essentials-10', 'iconP2', 1, duration, easing)
    doTweenAlpha('ShowHUD-essentials-11', 'scoreTxt', 1, duration, easing)
    doTweenAlpha('ShowHUD-essentials-12', 'timeTxt', 1, duration, easing)
    doTweenAlpha('ShowHUD-essentials-13', 'timeBar', 1, duration, easing)
end

function ChangeHUDAlpha(alpha, duration, easing)
    print('/mods/scripts/eggsEssentials.lua: Change HUD Alpha function called!')

    noteTweenAlpha('Change-HUD-Alpha-essentials-0', 0, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-1', 1, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-2', 2, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-3', 3, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-4', 4, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-5', 5, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-6', 6, alpha, duration, easing)
    noteTweenAlpha('Change-HUD-Alpha-essentials-7', 7, alpha, duration, easing)

    doTweenAlpha('Change-HUD-Alpha-essentials-8', 'healthBar', alpha, duration, easing)
    doTweenAlpha('Change-HUD-Alpha-essentials-9', 'iconP1', alpha, duration, easing)
    doTweenAlpha('Change-HUD-Alpha-essentials-10', 'iconP2', alpha, duration, easing)
    doTweenAlpha('Change-HUD-Alpha-essentials-11', 'scoreTxt', alpha, duration, easing)
    doTweenAlpha('Change-HUD-Alpha-essentials-12', 'timeTxt', alpha, duration, easing)
    doTweenAlpha('Change-HUD-Alpha-essentials-13', 'timeBar', alpha, duration, easing)
end

function SetWindowBorderless(toggle) -- https://api.haxeflixel.com/lime/ui/Window.html
    print('/mods/scripts/eggsEssentials.lua: Set Window Borderless function called!')

    if toggle then
        setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    elseif not toggle then
        setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    end
end

function SetWindowResizable(toggle)
    print('/mods/scripts/eggsEssentials.lua: Set Window Resizable function called!')

    if toggle then
        setPropertyFromClass('openfl.Lib', 'application.window.resizable', true)
    elseif not toggle then
        setPropertyFromClass('openfl.Lib', 'application.window.resizable', false)
    end
end