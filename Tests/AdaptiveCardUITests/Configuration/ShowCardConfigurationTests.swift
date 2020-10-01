#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class ShowCardConfigurationTests: XCTestCase {
        func testEmptyJSONObjectDecodeReturnsDefault() throws {
            // given
            let json = "{}".data(using: .utf8)!
            let expected = ShowCardConfiguration.default

            // when
            let result = try JSONDecoder().decode(ShowCardConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }

        func testConfigJSONDecodeReturnsValidConfig() throws {
            // given
            let json = """
            {
              "inlineTopMargin": 20,
              "style": "default"
            }
            """.data(using: .utf8)!

            let expected = ShowCardConfiguration(
                style: .default,
                inlineTopMargin: 20
            )

            // when
            let result = try JSONDecoder().decode(ShowCardConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }
    }

#endif
