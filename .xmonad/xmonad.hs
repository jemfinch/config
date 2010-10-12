import XMonad
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.ThreeColumns
import System.IO
 
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
                          where fadeAmount = 0xcccccccc

myLayoutHook = (layoutHook defaultConfig) ||| ThreeCol 1 (3/100) (1/3)

main = xmonad $ defaultConfig
         { modMask     = mod4Mask
         , layoutHook  = myLayoutHook
         , logHook     = myLogHook
         , borderWidth = 0
         } `additionalKeys`
         [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
         ]
