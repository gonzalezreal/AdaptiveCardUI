DESTINATION_MACOS = platform=macOS
DESTINATION_IOS = platform=iOS Simulator,name=iPhone 8
DESTINATION_IOS_SNAPSHOT = platform=iOS Simulator,OS=14.0,name=iPhone 8
DESTINATION_TVOS = platform=tvOS Simulator,name=Apple TV
DESTINATION_WATCHOS = generic/platform=watchOS

default: test

test: test-macos test-ios test-tvos watchos

test-macos:
	xcodebuild test \
			-scheme AdaptiveCardUI-Package \
			-destination '$(DESTINATION_MACOS)'

test-ios:
	xcodebuild test \
			-scheme AdaptiveCardUI-Package \
			-destination '$(DESTINATION_IOS)'

snapshot-test-ios:
	xcodebuild test \
			-scheme AdaptiveCardUI-Package \
			-destination '$(DESTINATION_IOS_SNAPSHOT)' \
			'OTHER_SWIFT_FLAGS=-D SNAPSHOT_TESTS'

test-tvos:
	xcodebuild test \
			-scheme AdaptiveCardUI-Package \
			-destination '$(DESTINATION_TVOS)'

watchos:
	xcodebuild \
			-scheme AdaptiveCardUI-Package-watchOS \
			-destination '$(DESTINATION_WATCHOS)'

format:
	swiftformat .

.PHONY: format
