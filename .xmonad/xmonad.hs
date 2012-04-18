import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.InsertPosition
import XMonad.Util.Dmenu
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myManageHook = composeAll
    [ className =? "net-minecraft-LauncherFrame" --> doShift "4:media"
    , className =? "net-minecraft-LauncherFrame" --> doFloat
    , manageDocks]

myWorkspaces = ["1:main", "2:social", "3:dev", "4:media", "5:monitor", "6", "7", "8"]
defaultLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 3/5
    delta = 5/100

mediaLayout = noBorders $ Full
myLayout = onWorkspace "4:media" mediaLayout $ defaultLayout
  
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ defaultConfig
    { 
      manageHook = insertPosition Below Newer <+> myManageHook
    , layoutHook = avoidStruts $ myLayout
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 150
      }
    , terminal           = "urxvt" 
    , modMask            = mod4Mask
    , workspaces = myWorkspaces
      -- keeps Minecraft in line
    , startupHook = setWMName "LG3D"
    , borderWidth        = 1
      -- border colors set to match 256 color terminal PS1
    , normalBorderColor  = "#0087ff"
    , focusedBorderColor = "#5fd700"
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    , ((mod4Mask,               xK_v), spawn "gvim")
    , ((mod4Mask,               xK_p), spawn "dmenu_run")
    ]

