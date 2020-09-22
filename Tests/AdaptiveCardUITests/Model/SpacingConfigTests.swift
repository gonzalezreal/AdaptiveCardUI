import AdaptiveCardUI
import XCTest

final class SpacingConfigTests: XCTestCase {
    func testInitDefaultValues() {
        // when
        let result = SpacingConfig()

        // then
        XCTAssertEqual(Spacing.small.defaultValue, result.small)
        XCTAssertEqual(Spacing.default.defaultValue, result.default)
        XCTAssertEqual(Spacing.medium.defaultValue, result.medium)
        XCTAssertEqual(Spacing.large.defaultValue, result.large)
        XCTAssertEqual(Spacing.extraLarge.defaultValue, result.extraLarge)
        XCTAssertEqual(Spacing.padding.defaultValue, result.padding)
    }

    func testAnyConfigSubscriptEqualsProperty() {
        // given
        let anyConfig = SpacingConfig()

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
        let expected = SpacingConfig()

        // when
        let result = try JSONDecoder().decode(SpacingConfig.self, from: json)

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
        let expected = SpacingConfig(
            small: 4,
            default: 9,
            medium: 21,
            large: 31,
            extraLarge: 41,
            padding: 11
        )

        // when
        let result = try JSONDecoder().decode(SpacingConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
