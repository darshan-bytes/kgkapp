#!/bin/bash

flutter clean
rm ios/Podfile.lock
rm pubspec.lock
rm -rf ios/Flutter/Flutter.framework
flutter pub get
cd ios; 
if [ "$1" == "--all" ]; then
    pod cache clean --all
    pod install --repo-update
else
    pod install 
fi
pod install 
cd ..