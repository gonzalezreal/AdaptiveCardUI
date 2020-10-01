#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class ImageSizeConfigurationTests: XCTestCase {
        func testAnyConfigSubscriptEqualsProperty() {
            // given
            let anyConfig = ImageSizeConfiguration.default

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
            let expected = ImageSizeConfiguration.default

            // when
            let result = try JSONDecoder().decode(ImageSizeConfiguration.self, from: json)

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

            let expected = ImageSizeConfiguration(
                small: 100,
                medium: 200,
                large: 300
            )

            // when
            let result = try JSONDecoder().decode(ImageSizeConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }
    }

#endif
