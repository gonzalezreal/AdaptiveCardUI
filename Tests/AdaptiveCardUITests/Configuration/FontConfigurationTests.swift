#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class FontConfigurationTests: XCTestCase {
        func testAnyConfigSubscriptEqualsProperty() {
            // given
            let anyConfig = FontConfiguration.default

            // then
            XCTAssertEqual(anyConfig.small, anyConfig[.small])
            XCTAssertEqual(anyConfig.default, anyConfig[.default])
            XCTAssertEqual(anyConfig.medium, anyConfig[.medium])
            XCTAssertEqual(anyConfig.large, anyConfig[.large])
            XCTAssertEqual(anyConfig.extraLarge, anyConfig[.extraLarge])
        }

        func testEmptyJSONObjectDecodeReturnsDefault() throws {
            // given
            let json = "{}".data(using: .utf8)!
            let expected = FontConfiguration(
                default: .system(size: 14),
                small: .system(size: 12),
                medium: .system(size: 17),
                large: .system(size: 21),
                extraLarge: .system(size: 26)
            )

            // when
            let result = try JSONDecoder().decode(FontConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }

        func testConfigJSONDecodeReturnsValidConfig() throws {
            // given
            let json = """
            {
              "fontFamily": "Fistro, 'Courier New', Courier, monospace",
              "fontSizes": {
                "small": 13,
                "default": 16,
                "medium": 18,
                "large": 22,
                "extraLarge": 28
              }
            }
            """.data(using: .utf8)!

            let expected = FontConfiguration(
                default: .custom("Courier New", size: 16),
                small: .custom("Courier New", size: 13),
                medium: .custom("Courier New", size: 18),
                large: .custom("Courier New", size: 22),
                extraLarge: .custom("Courier New", size: 28)
            )

            // when
            let result = try JSONDecoder().decode(FontConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }
    }

#endif
