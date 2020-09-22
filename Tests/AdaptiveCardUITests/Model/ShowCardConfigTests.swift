import AdaptiveCardUI
import XCTest

final class ShowCardConfigTests: XCTestCase {
    func testInitDefaultValues() {
        // when
        let result = ShowCardConfig()

        // then
        XCTAssertEqual(.inline, result.actionMode)
        XCTAssertEqual(.emphasis, result.style)
        XCTAssertEqual(ShowCardConfig.Defaults.inlineTopMargin, result.inlineTopMargin)
    }

    func testEmptyJSONObjectDecodeReturnsDefault() throws {
        // given
        let json = "{}".data(using: .utf8)!
        let expected = ShowCardConfig()

        // when
        let result = try JSONDecoder().decode(ShowCardConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testConfigJSONDecodeReturnsValidConfig() throws {
        // given
        let json = """
        {
          "actionMode": "popup",
          "inlineTopMargin": 8,
          "style": "default"
        }
        """.data(using: .utf8)!

        let expected = ShowCardConfig(
            actionMode: .popup,
            style: .default,
            inlineTopMargin: 8
        )

        // when
        let result = try JSONDecoder().decode(ShowCardConfig.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
