import AdaptiveCardUI
import XCTest

final class ActionsConfigTests: XCTestCase {
    func testInitDefaultValues() {
        // when
        let result = ActionsConfig()

        // then
        XCTAssertEqual(.horizontal, result.actionsOrientation)
        XCTAssertEqual(.stretch, result.actionAlignment)
        XCTAssertEqual(ActionsConfig.Defaults.buttonSpacing, result.buttonSpacing)
        XCTAssertEqual(ActionsConfig.Defaults.maxActions, result.maxActions)
        XCTAssertEqual(.default, result.spacing)
        XCTAssertEqual(.default, result.showCard)
        XCTAssertEqual(.leftOfTitle, result.iconPlacement)
        XCTAssertEqual(ActionsConfig.Defaults.iconSize, result.iconSize)
    }

    func testEmptyJSONObjectDecodeReturnsDefault() throws {
        // given
        let json = "{}".data(using: .utf8)!
        let expected = ActionsConfig()

        // when
        let result = try JSONDecoder().decode(ActionsConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testConfigJSONDecodeReturnsValidConfig() throws {
        // given
        let json = """
        {
          "actionsOrientation": "vertical",
          "actionAlignment": "center",
          "buttonSpacing": 8,
          "maxActions": 100,
          "spacing": "default",
          "showCard": {
            "actionMode": "inline",
            "inlineTopMargin": 8,
            "style": "emphasis"
          },
          "iconPlacement": "aboveTitle",
          "iconSize": 80
        }
        """.data(using: .utf8)!

        let expected = ActionsConfig(
            actionsOrientation: .vertical,
            actionAlignment: .center,
            buttonSpacing: 8,
            maxActions: 100,
            spacing: .default,
            showCard: ShowCardConfig(inlineTopMargin: 8),
            iconPlacement: .aboveTitle,
            iconSize: 80
        )

        // when
        let result = try JSONDecoder().decode(ActionsConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
