import AdaptiveCardUI
import XCTest

final class FontSizesConfigTests: XCTestCase {
    func testInitDefaultValues() {
        // when
        let result = FontSizesConfig()

        // then
        XCTAssertEqual(FontSize.small.defaultValue, result.small)
        XCTAssertEqual(FontSize.default.defaultValue, result.default)
        XCTAssertEqual(FontSize.medium.defaultValue, result.medium)
        XCTAssertEqual(FontSize.large.defaultValue, result.large)
        XCTAssertEqual(FontSize.extraLarge.defaultValue, result.extraLarge)
    }

    func testAnyConfigSubscriptEqualsProperty() {
        // given
        let anyConfig = FontSizesConfig()

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
        let expected = FontSizesConfig()

        // when
        let result = try JSONDecoder().decode(FontSizesConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testConfigJSONDecodeReturnsValidConfig() throws {
        // given
        let json = """
        {
          "small": 14,
          "default": 16,
          "medium": 19,
          "large": 23,
          "extraLarge": 28
        }
        """.data(using: .utf8)!

        let expected = FontSizesConfig(
            small: 14,
            default: 16,
            medium: 19,
            large: 23,
            extraLarge: 28
        )

        // when
        let result = try JSONDecoder().decode(FontSizesConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
