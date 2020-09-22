import AdaptiveCardUI
import XCTest

final class ImageSizesConfigTests: XCTestCase {
    func testInitDefaultValues() {
        // when
        let result = ImageSizesConfig()

        // then
        XCTAssertEqual(ImageSizesConfig.Defaults.small, result.small)
        XCTAssertEqual(ImageSizesConfig.Defaults.medium, result.medium)
        XCTAssertEqual(ImageSizesConfig.Defaults.large, result.large)
    }

    func testAnyConfigSubscriptEqualsProperty() {
        // given
        let anyConfig = ImageSizesConfig()

        // then
        XCTAssertEqual(anyConfig.small, anyConfig[.small])
        XCTAssertEqual(anyConfig.medium, anyConfig[.medium])
        XCTAssertEqual(anyConfig.large, anyConfig[.large])
        XCTAssertNil(anyConfig[.auto])
        XCTAssertNil(anyConfig[.stretch])
    }

    func testEmptyJSONObjectDecodeReturnsDefault() throws {
        // given
        let json = "{}".data(using: .utf8)!
        let expected = ImageSizesConfig()

        // when
        let result = try JSONDecoder().decode(ImageSizesConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testConfigJSONDecodeReturnsValidConfig() throws {
        // given
        let json = """
        {
          "small": 100,
          "medium": 200,
          "large": 300,
        }
        """.data(using: .utf8)!

        let expected = ImageSizesConfig(
            small: 100,
            medium: 200,
            large: 300
        )

        // when
        let result = try JSONDecoder().decode(ImageSizesConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
