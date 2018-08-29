
-- import Modules:  {{{1
import Control.Monad(liftM2)
import System.IO
import System.Exit
import qualified Data.Map as M
import Data.Monoid

import XMonad

import XMonad.Actions.WindowGo
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow

import XMonad.Config.Desktop(desktopLayoutModifiers)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout
import XMonad.Layout.DragPane
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.IM
-- this makes window bigger
import qualified XMonad.Layout.Magnifier as Mag
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.ToggleLayouts
import XMonad.Layout.TwoPane

import qualified XMonad.StackSet as W

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import XMonad.Layout.LayoutScreens

-- }}}


main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ def
             { borderWidth = 2
             , normalBorderColor = "#99ccff"
             , focusedBorderColor = "#dd2222"
             , focusFollowsMouse = False
             , layoutHook = myLayout
             , manageHook = myManageHookShift
                    <+> myManageHookFloat
                    <+> manageDocks
                    <+> manageHook def
             , logHook = myLogHook wsbar
             , startupHook = myStartupHook
             , workspaces = myWorkspaces
             , terminal = "terminator"
             , modMask = myModMask
             , keys = myKeys
             , clickJustFocuses = False
             }

myLogHook h = dynamicLogWithPP $ wsPP {ppOutput = hPutStrLn h }

myWsBar = "xmobar ~/.xmonad/xmobarrc"

wsPP = xmobarPP { ppWsSep = " "
                , ppTitle = xmobarColor "green" "" . shorten 50
                }


-- myModMask: {{{1
-- prefixKey = Alt
myModMask = mod1Mask

-- myWorkspaces: {{{1
-- warkspaces name 1-9
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- myLayout: {{{1
ver = spacing 3 $ Tall 1 (1/100) (4/5)
hor = spacing 3 $ Tall 1 (1/100) (3/10)
myLayout = mkToggle1 FULL $ avoidStruts (desktopLayoutModifiers (named "Vertical" ver ||| (named "Horizonal" $ Mirror hor)))

-- myLayout = (spacing 3 $ ResizableTall 1 (1/100) (4/7) [])
--             ||| (spacing 3 $ TwoPane (1/100) (5/8))
--             ||| (spacing 3 $ ThreeColMid 1 (1/100) (16/35))
--             ||| (spacing 3 $ ResizableTall 2 (1/100) (1/3) [])

-- myKeys: {{{1
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ 
    ((modm,                 xK_Return   ), spawn "terminator")
    , ((modm,               xK_o         ), spawn "dmenu_run")
    , ((modm,               xK_w         ), kill)

    , ((modm,               xK_space     ), sendMessage NextLayout)
    , ((modm,               xK_comma     ), sendMessage $ Toggle FULL)
    -- , ((modm .|. shiftMask, xK_space ), sendMessage setLayout $ XMonad.layoutHook )

    , ((modm,               xK_Tab       ), windows W.focusDown)
    , ((modm .|. shiftMask, xK_Tab       ), windows W.focusUp)
    , ((modm,               xK_j         ), windows W.focusDown)
    , ((modm,               xK_k         ), windows W.focusUp)
    , ((modm,               xK_m         ), windows W.focusMaster)

    , ((modm .|. shiftMask, xK_m         ), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j         ), windows W.swapDown)
    , ((modm .|. shiftMask, xK_k         ), windows W.swapUp)

    , ((modm,               xK_p         ), nextWS)
    , ((modm,               xK_n         ), prevWS)
    , ((modm .|. shiftMask, xK_p         ), shiftToNext)
    , ((modm .|. shiftMask, xK_n         ), shiftToPrev)

    , ((modm .|. shiftMask, xK_h         ), sendMessage Shrink)
    , ((modm .|. shiftMask, xK_l         ), sendMessage Expand)

    , ((modm,               xK_s         ), sendMessage ToggleStruts)

    , ((modm,               xK_equal     ), spawn "mpc toggle")
    , ((modm,               xK_backslash ), spawn "mpc prev")
    , ((modm,               xK_grave     ), spawn "mpc next")

    -- , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm,               xK_i         ), spawn "luakit")

    -- , ((modm,               xK_comma ), sendMessage Mag.MagnifyLess)
    -- , ((modm,               xK_period), sendMessage Mag.MagnifyMore)

    , ((modm .|. shiftMask, xK_q         ), io (exitWith ExitSuccess))
    , ((modm,               xK_q         ), spawn "killall dzen2; xmonad --recompile && xmonad --restart")

    , ((modm .|. controlMask, xK_Return), spawn "xscreensaver-command -lock")

    , ((modm,               xK_t         ), spawn "thunar")
    , ((modm .|. shiftMask, xK_space     ), layoutSplitScreen 1 (TwoPane (3/100) 0.7))
    , ((modm .|. shiftMask, xK_comma     ), rescreen)
    ]

    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_l, xK_h, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, controlMask)]]

-- myStartupHook: {{{1
myStartupHook = do

    -- background app
    spawn "thunar --daemon"
    spawn "xscreensaver -no-splash"
    spawn "~/.dropbox-dist/dropboxd"
    -- spawn "~/.xmonad/dmenu_history"
    spawn "albert"

    -- startup application
    spawn "terminator"
    spawn "cantata"
    -- spawn "google-chrome-stable"
    spawn "vivaldi-snapshot"
    spawn "conky"
    -- spawn "mendeleydesktop"

    -- Dual Display Settings
    screenWorkspace 0 >>= flip whenJust (windows . W.view)
    (windows . W.greedyView) "6"
    screenWorkspace 1 >>= flip whenJust (windows . W.view)
    (windows . W.greedyView) "1"

-- myManageHookShift: {{{1
-- specified default workspace, when making window
myManageHookShift = composeAll
    [ className =? "conky"          --> viewShift "6"
    , className =? "google-chrome"  --> viewShift "6"
    , className =? "vivaldi-snapshot"  --> viewShift "6"
    , className =? "Terminator"     --> viewShift "1"
    , className =? "cantata"           --> viewShift "5"
    , title =? "Mendeley Desktop"   --> viewShift "8"
    ]
    where viewShift = doF . liftM2 (.) W.view W.shift

--myManageHookFloat: {{{1
-- specified floating, when making window
myManageHookFloat = composeAll
    [ title =? "Display" --> doFloat
    , title =? "sensor-monitoring" --> doFloat
    , title =? "albert" --> doFloat
    , className =? "Shutter" --> doFloat
    , className =? "Xfce4-notifyd" --> doF W.focusDown <+> doF copyToAll
    -- , className =? "Vlc"     --> doFloat
    ]
