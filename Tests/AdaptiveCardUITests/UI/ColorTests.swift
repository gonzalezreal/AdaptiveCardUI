#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    @testable import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class ColorTests: XCTestCase {
        func testARGBHexInitSuccess() {
            // given
            let hex = "#AABBCCDD"
            let expected = Color(red: 0xBB / 255, green: 0xCC / 255, blue: 0xDD / 255, opacity: 0xAA / 255)

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertEqual(expected, result)
        }

        func testRGBHexInitSuccess() {
            // given
            let hex = "#AABBCC"
            let expected = Color(red: 0xAA / 255, green: 0xBB / 255, blue: 0xCC / 255, opacity: 1)

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertEqual(expected, result)
        }

        func testValueWithoutHashInitFails() {
            // given
            let hex = "AABBCCDD"

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertNil(result)
        }

        func testTooShortValueInitFails() {
            // given
            let hex = "#AABBC"

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertNil(result)
        }

        func testTooLongValueInitFails() {
            // given
            let hex = "#AABBCCDDF"

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertNil(result)
        }

        func testNilValueInitFails() {
            // given
            let hex: String? = nil

            // when
            let result = Color(argbHex: hex)

            // then
            XCTAssertNil(result)
        }
    }

#endif
