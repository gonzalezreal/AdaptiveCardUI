DESTINATION_IOS = platform=iOS Simulator,OS=14.0,name=iPhone 8
DESTINATION_TVOS = platform=tvOS Simulator,OS=14.0,name=Apple TV
DESTINATION_WATCHOS = platform=watchOS Simulator,OS=7.0,name=Apple Watch Series 4 - 40mm

default: test

test:
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_IOS)'
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_TVOS)'
	xcodebuild \
			-scheme AdaptiveCardUI_watchOS \
			-destination '$(DESTINATION_WATCHOS)'
