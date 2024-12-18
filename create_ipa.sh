#!/bin/bash

# Define variables
WORKSPACE="Aidoku.xcodeproj"    # Replace with your workspace name
SCHEME="Aidoku (iOS)"           # Replace with your scheme name
EXPORT_OPTIONS_PLIST="./iOS/info.plist"  # Path to ExportOptions.plist
BUILD_DIR="./build"
ARCHIVE_PATH="$BUILD_DIR/Aidoku.xcarchive"  # Correct the archive path to use .xcarchive
IPA_OUTPUT_PATH="$BUILD_DIR"

# Step 1: Clean the build folder
echo "Cleaning the build folder..."
xcodebuild clean -project "$WORKSPACE" -scheme "$SCHEME" -configuration Release

# Step 2: Archive the project
echo "Archiving the project..."
xcodebuild archive -project "$WORKSPACE" -scheme "$SCHEME" -configuration Release -archivePath "$ARCHIVE_PATH"

# Step 3: Export the archive to IPA
echo "Exporting the archive to IPA..."
xcodebuild -exportArchive -archivePath "$ARCHIVE_PATH" -exportPath "$IPA_OUTPUT_PATH" -exportOptionsPlist "$EXPORT_OPTIONS_PLIST"

# Step 4: Verify the IPA file
if [ -f "$IPA_OUTPUT_PATH/Aidoku.ipa" ]; then
    echo "IPA file successfully created at $IPA_OUTPUT_PATH/Aidoku.ipa"
else
    echo "Error: IPA file not found."
    exit 1
fi
