import AdaptiveCardUI
import XCTest

final class ColumnSetElementTests: XCTestCase {
    func testColumnDecodeReturnsColumn() throws {
        // given
        let json = """
        {
          "id": "1",
          "items": [
            {
              "id": "2",
              "type": "TextBlock",
              "text": "test"
            }
          ],
          "type": "Column"
        }
        """.data(using: .utf8)!
        let expected = ColumnSetElement.column(
            Column(
                id: "1",
                items: [
                    .textBlock(TextBlock(id: "2", text: "test")),
                ]
            )
        )

        // when
        let result = try JSONDecoder().decode(ColumnSetElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testColumnEncodeReturnsColumnJSON() throws {
        // given
        let element = ColumnSetElement.column(
            Column(
                id: "1",
                items: [
                    .textBlock(TextBlock(id: "2", text: "test")),
                ]
            )
        )
        let expected = """
        {
          "id" : "1",
          "items" : [
            {
              "id" : "2",
              "text" : "test",
              "type" : "TextBlock"
            }
          ],
          "type" : "Column"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(element)

        // then
        XCTAssertEqual(expected, result)
    }

    func testUnknownTypeDecodeReturnsUnknownColumnSetElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "Superunknown"
        }
        """.data(using: .utf8)!
        let expected = ColumnSetElement.unknown(UnknownColumnSetElement(id: "xyz"))

        // when
        let result = try JSONDecoder().decode(ColumnSetElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
