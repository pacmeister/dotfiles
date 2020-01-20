import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import System.IO

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar -d /home/pac/.xmobarrc"
    xmonad $ docks defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , modMask = mod4Mask
	, terminal = "st -e tmux new -A -s main"
        }
        `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "i3lock --color=000000")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask, xK_p), spawn "dmenu_run -fn 'Iosevka-10'")
        ]
