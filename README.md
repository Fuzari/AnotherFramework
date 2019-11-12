# AnotherFramework

## How to use

1. In project folder create a Cartfile and add this: 
`git "URL OF THE REPO" ~> 1.0`
Save the file

2. In terminal opened in project's folder run: "carthage update"

3. Drag the framework from Carthage/Build/iOS/Name.framework to the Linked Frameworks and Libraries in the project's target in Xcode.

4. Now you have to create a New Run Script Phase for the application target’s Build Phases with:
`/usr/local/bin/carthage copy-frameworks`

5. In the Input Files you have to add this:
`$(SRCROOT)/Carthage/Build/iOS/Name.framework`

And this in the Output Files:
`$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Name.framework` 
