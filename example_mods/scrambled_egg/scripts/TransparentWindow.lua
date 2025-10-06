--[[
    Version: 1.0.0
    Author: Ralsi (https://gamebanana.com/members/1939328)
    GB Page: https://gamebanana.com/tools/12925
    Crediting: If used in a mod, not necessary, but very much appreciated. Do not remove or edit all this info tho.
    Extra: To change the color that should be transparent, edit the line 27.
]]
local fs, mx = false, false
local ffi = require("ffi")

function onStepHit()
    if curStep == -100 then
        if buildTarget ~= 'windows' then
            onDestroy = function () end
            ffi, fs, mx = nil, nil, nil
            return
        end
        ffi.cdef([[
            typedef void* HWND;
            typedef int BOOL;
            typedef unsigned char BYTE;
            typedef unsigned long DWORD;
            HWND GetActiveWindow();
            long SetWindowLongA(HWND hWnd, int nIndex, long dwNewLong);
            BOOL SetLayeredWindowAttributes(HWND hwnd, DWORD crKey, BYTE bAlpha, DWORD dwFlags);
        ]])
        local hwnd = ffi.C.GetActiveWindow()
        ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
        ffi.C.SetLayeredWindowAttributes(hwnd, 0x000000, 0, 0x00000001)
        addHaxeLibrary('Lib', 'openfl')
        fs = getPropertyFromClass('openfl.Lib', 'application.window.fullscreen')
        mx = getPropertyFromClass('openfl.Lib', 'application.window.maximized')
        runHaxeCode([[
            Lib.application.window.borderless = true;
            Lib.application.window.maximized = false;
            Lib.application.window.fullscreen = false;
        ]])
    end
end
function onDestroy()
    ffi.C.SetWindowLongA(ffi.C.GetActiveWindow(), -20, 0x00000000)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', fs)
    setPropertyFromClass('openfl.Lib', 'application.window.maximized', mx)
end
