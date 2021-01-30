import AdaptiveCard
import XCTest

final class TargetElementTests: XCTestCase {
    func testStringDecodeReturnsTargetElement() throws {
        // given
        let json = "[\"textToToggle\"]".data(using: .utf8)!
        let expected = [TargetElement(elementId: "textToToggle")]

        // when
        let result = try JSONDecoder().decode([TargetElement].self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testObjectDecodeReturnsTargetElement() throws {
        // given
        let json = """
        {
          "elementId": "textToToggle",
          "isVisible": true
        }
        """.data(using: .utf8)!
        let expected = TargetElement(elementId: "textToToggle", isVisible: true)

        // when
        let result = try JSONDecoder().decode(TargetElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
