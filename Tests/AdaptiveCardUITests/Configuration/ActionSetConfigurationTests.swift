#if canImport(SwiftUI)

    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class ActionSetConfigurationTests: XCTestCase {
        func testEmptyJSONObjectDecodeReturnsDefault() throws {
            // given
            let json = "{}".data(using: .utf8)!
            let expected = ActionSetConfiguration.default

            // when
            let result = try JSONDecoder().decode(ActionSetConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }

        func testConfigJSONDecodeReturnsValidConfig() throws {
            // given
            let json = """
            {
              "actionsOrientation": "horizontal",
              "actionAlignment": "center",
              "buttonSpacing": 20,
              "maxActions": 100,
              "spacing": "extraLarge",
              "showCard": {
                "inlineTopMargin": 10,
                "style": "default"
              }
            }
            """.data(using: .utf8)!

            let expected = ActionSetConfiguration(
                actionsOrientation: .horizontal,
                actionAlignment: .center,
                buttonSpacing: 20,
                spacing: .extraLarge,
                maxActions: 100,
                showCard: ShowCardConfiguration(
                    style: .default,
                    inlineTopMargin: 10
                )
            )

            // when
            let result = try JSONDecoder().decode(ActionSetConfiguration.self, from: json)

            // then
            XCTAssertEqual(expected, result)
        }
    }

#endif
