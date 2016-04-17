import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , modMask = mod4Mask     -- rebind mod to the windows key
        , normalBorderColor = "#000000" --change border of normal windows
	, focusedBorderColor = "#0000b2" --change border of the focused window
        } `additionalKeys` --additional key mappings
        [
        ]
