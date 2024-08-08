#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to clean up Flutter and iOS specific files
clean_flutter_and_ios() {
    echo "Cleaning Flutter project..."
    flutter clean

    echo "Removing iOS and Dart package locks..."
    rm -f ios/Podfile.lock pubspec.lock

    echo "Removing Flutter framework from iOS..."
    rm -rf ios/Flutter/Flutter.framework
}

# Function to get Flutter dependencies
get_flutter_dependencies() {
    echo "Getting Flutter dependencies..."
    flutter pub get
}

# Function to manage CocoaPods installation
install_pods() {
    cd ios

    if [ "$1" == "--all" ]; then
        echo "Cleaning CocoaPods cache and updating repositories..."
        pod cache clean --all
        pod install --repo-update
    else
        echo "Installing CocoaPods dependencies..."
        pod install
    fi

    cd ..
}

# Main script execution
clean_flutter_and_ios
get_flutter_dependencies
install_pods "$1"

echo "Script execution completed successfully."
