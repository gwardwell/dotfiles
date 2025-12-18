#!/bin/bash

# Close System Preferences to prevent override
osascript -e 'tell application "System Preferences" to quit'

# Dock settings
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 39
defaults write com.apple.dock largesize -int 54
defaults write com.apple.dock showhidden -bool true

# Finder settings
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false
defaults write com.apple.finder AppleShowAllFiles -bool true

# Desktop settings
defaults write com.apple.finder DesktopViewSettings:GroupBy -string "Kind"
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:arrangeBy -string "dateAdded"
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:gridSpacing -int 43
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:iconSize -int 48
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:labelOnBottom -bool true
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:showIconPreview -bool true
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:showItemInfo -bool false
defaults write com.apple.finder DesktopViewSettings:IconViewSettings:textSize -int 12
defaults write com.apple.WindowManager AppWindowGroupingBehavior -int 1
defaults write com.apple.WindowManager AutoHide -bool false
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
defaults write com.apple.WindowManager GloballyEnabled -bool false
defaults write com.apple.WindowManager GloballyEnabledEver -bool true
defaults write com.apple.WindowManager HideDesktop -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
defaults write com.apple.WindowManager StandardHideWidgets -bool false

# Theme settings
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Window settings
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Mouse/Trackpad settings
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonDivision -int 55
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "OneButton"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseHorizontalScroll -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseVerticalScroll -bool true
defaults write NSGlobalDomain com.apple.mouse.scaling -float 0.6875
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

# Disabled keyboard shortcuts
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 16 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 164 '{enabled = 0; value = {parameters = (65535, 65535, 0); type = standard;};}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 17 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 18 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 19 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 20 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 21 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 22 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 23 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 24 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 25 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 26 '{enabled = 0;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '{enabled = 0; value = {parameters = (32, 49, 262144); type = standard;};}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '{enabled = 0; value = {parameters = (32, 49, 786432); type = standard;};}'

# Enabled keyboard shortcuts
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 '{enabled = 1;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 80 '{enabled = 1;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 '{enabled = 1;}'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 82 '{enabled = 1;}'

# Visible control center items
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible BentoBox" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible StageManager" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true

# Hidden control center items
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool false
defaults write com.apple.TextInputMenu visible -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible Display" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible FocusModes" -bool false

# Screenshot location
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "~/Screenshots"

# Menubar clock settings
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock ShowDate -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true

# Hot corners
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 6
defaults write com.apple.dock wvous-tr-modifier -int 0

# Activity Monitor settings
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Archive Utility settings
defaults write com.apple.archiveutility "archive-info" -string "."
defaults write com.apple.archiveutility "archive-move-after" -string "."
defaults write com.apple.archiveutility "dearchive-into" -string "."
defaults write com.apple.archiveutility "dearchive-move-after" -string "~/.Trash"
defaults write com.apple.archiveutility "dearchive-move-intermediate-after" -string "/dev/null"

# Restart affected apps
killall cfprefsd
killall Dock Finder SystemUIServer
