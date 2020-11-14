DESTINATION_MACOS = platform=macOS
DESTINATION_IOS = platform=iOS Simulator,name=iPhone 8
DESTINATION_IOS_SNAPSHOT = platform=iOS Simulator,OS=14.0,name=iPhone 8
DESTINATION_TVOS = platform=tvOS Simulator,name=Apple TV

default: test

test: test-macos test-ios test-tvos

test-macos:
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_MACOS)'

test-ios:
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_IOS)'

snapshot-test-ios:
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_IOS_SNAPSHOT)' \
			'OTHER_SWIFT_FLAGS=-D SNAPSHOT_TESTS'

test-tvos:
	xcodebuild test \
			-scheme AdaptiveCardUI \
			-destination '$(DESTINATION_TVOS)'

format:
	swiftformat .

.PHONY: format
