#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class SpacingConfigurationTests: XCTestCase {
        func testAnyConfigSubscriptEqualsProperty() {
            // given
            let anyConfig = SpacingConfiguration.default

            // then
            XCTAssertEqual(anyConfig.small, anyConfig[.small])
            XCTAssertEqual(anyConfig.default, anyConfig[.default])
            XCTAssertEqual(anyConfig.medium, anyConfig[.medium])
            XCTAssertEqual(anyConfig.large, anyConfig[.large])
            XCTAssertEqual(anyConfig.extraLarge, anyConfig[.extraLarge])
            XCTAssertEqual(anyConfig.padding, anyConfig[.padding])
        }

        func testEmptyJSONObjectDecodeReturnsDefault() throws {
            // given
            let json = "{}".data(using: .utf8)!
            let expected = SpacingConfiguration.default

            // when
            let result = try JSONDecoder().decode(SpacingConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }

        func testConfigJSONDecodeReturnsValidConfig() throws {
            // given
            let json = """
            {
              "small": 4,
              "default": 9,
              "medium": 21,
              "large": 31,
              "extraLarge": 41,
              "padding": 11,
            }
            """.data(using: .utf8)!
            let expected = SpacingConfiguration(
                default: 9,
                small: 4,
                medium: 21,
                large: 31,
                extraLarge: 41,
                padding: 11
            )

            // when
            let result = try JSONDecoder().decode(SpacingConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }
    }

#endif
