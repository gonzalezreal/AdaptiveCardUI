import AdaptiveCardUI
import XCTest

final class CardElementTests: XCTestCase {
    func testTextBlockDecodeReturnsTextBlockCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "TextBlock",
          "text": "test"
        }
        """.data(using: .utf8)!
        let expected = CardElement.textBlock(TextBlock(id: "xyz", text: "test"))

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testTextBlockCardElementEncodeReturnsTextBlockJSON() throws {
        // given
        let cardElement = CardElement.textBlock(TextBlock(text: "test"))
        let expected = """
        {
          "text" : "test",
          "type" : "TextBlock"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testImageDecodeReturnsImageCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "Image",
          "url": "https://adaptivecards.io/content/cats/1.png"
        }
        """.data(using: .utf8)!
        let expected = CardElement.image(Image(id: "xyz", url: URL(string: "https://adaptivecards.io/content/cats/1.png")!))

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testImageCardElementEncodeReturnsImageJSON() throws {
        // given
        let cardElement = CardElement.image(Image(url: URL(string: "https://adaptivecards.io/content/cats/1.png")!))
        let expected = """
        {
          "type" : "Image",
          "url" : "https:\\/\\/adaptivecards.io\\/content\\/cats\\/1.png"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testContainerDecodeReturnsContainerCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "Container",
          "items": [
            {
              "type": "TextBlock",
              "id": "42",
              "text": "test"
            }
          ]
        }
        """.data(using: .utf8)!
        let expected = CardElement.container(
            Container(
                id: "xyz",
                items: [
                    .textBlock(TextBlock(id: "42", text: "test")),
                ]
            )
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testContainerCardElementEncodeReturnsContainerJSON() throws {
        // given
        let cardElement = CardElement.container(
            Container(
                items: [
                    .textBlock(TextBlock(text: "test")),
                ]
            )
        )
        let expected = """
        {
          "items" : [
            {
              "text" : "test",
              "type" : "TextBlock"
            }
          ],
          "type" : "Container"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testRichTextBlockDecodeReturnsRichTextBlockCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "RichTextBlock",
          "inlines": [
            "Test"
          ]
        }
        """.data(using: .utf8)!
        let expected = CardElement.richTextBlock(
            RichTextBlock(id: "xyz", inlines: [TextRun(text: "Test")])
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testRichTextBlockCardElementEncodeReturnsRichTextBlockJSON() throws {
        // given
        let cardElement = CardElement.richTextBlock(
            RichTextBlock(inlines: [TextRun(text: "Test")])
        )
        let expected = """
        {
          "inlines" : [
            {
              "text" : "Test",
              "type" : "TextRun"
            }
          ],
          "type" : "RichTextBlock"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testActionSetDecodeReturnsActionSetCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "ActionSet",
          "actions": [
            {
              "type": "Action.OpenUrl",
              "title": "Test",
              "url": "https://adaptivecards.io"
            }
          ]
        }
        """.data(using: .utf8)!
        let expected = CardElement.actionSet(
            ActionSet(
                id: "xyz",
                actions: [
                    .openURL(OpenURLAction(url: URL(string: "https://adaptivecards.io")!, title: "Test")),
                ]
            )
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testActionSetCardElementEncodeReturnsActionSetJSON() throws {
        // given
        let cardElement = CardElement.actionSet(
            ActionSet(
                actions: [
                    .openURL(OpenURLAction(url: URL(string: "https://adaptivecards.io")!, title: "Test")),
                ]
            )
        )
        let expected = #"""
        {
          "actions" : [
            {
              "title" : "Test",
              "type" : "Action.OpenUrl",
              "url" : "https:\/\/adaptivecards.io"
            }
          ],
          "type" : "ActionSet"
        }
        """#.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testColumnSetDecodeReturnsColumnSetCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "ColumnSet",
          "columns": [
            {
              "type": "Column",
              "id": "someColumn",
              "items": [
                {
                  "type": "TextBlock",
                  "id": "42",
                  "text": "test"
                }
              ]
            }
          ]
        }
        """.data(using: .utf8)!
        let expected = CardElement.columnSet(
            ColumnSet(
                id: "xyz",
                columns: [
                    Column(
                        id: "someColumn",
                        items: [
                            .textBlock(TextBlock(id: "42", text: "test")),
                        ]
                    ),
                ]
            )
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, *)
    func testColumnSetCardElementEncodeReturnsColumnSetJSON() throws {
        // given
        let cardElement = CardElement.columnSet(
            ColumnSet(
                columns: [
                    Column(
                        items: [
                            .textBlock(TextBlock(text: "test")),
                        ]
                    ),
                ]
            )
        )
        let expected = """
        {
          "columns" : [
            {
              "items" : [
                {
                  "text" : "test",
                  "type" : "TextBlock"
                }
              ],
              "type" : "Column"
            }
          ],
          "type" : "ColumnSet"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testFactSetDecodeReturnsFactSetCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "FactSet",
          "facts": [
            {
              "title": "Fact 1",
              "value": "Value 1"
            },
            {
              "title": "Fact 2",
              "value": "Value 2"
            }
          ]
        }
        """.data(using: .utf8)!
        let expected = CardElement.factSet(
            FactSet(
                id: "xyz",
                facts: [
                    Fact(title: "Fact 1", value: "Value 1"),
                    Fact(title: "Fact 2", value: "Value 2"),
                ]
            )
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, *)
    func testFactSetCardElementEncodeReturnsFactSetJSON() throws {
        // given
        let cardElement = CardElement.factSet(
            FactSet(
                facts: [
                    Fact(title: "Fact 1", value: "Value 1"),
                    Fact(title: "Fact 2", value: "Value 2"),
                ]
            )
        )
        let expected = """
        {
          "facts" : [
            {
              "title" : "Fact 1",
              "value" : "Value 1"
            },
            {
              "title" : "Fact 2",
              "value" : "Value 2"
            }
          ],
          "type" : "FactSet"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testCustomCardElementDecodeReturnsCustomCardElement() throws {
        // given
        CardElement.register(StarCount.self)
        let json = """
        {
          "id": "42",
          "type": "StarCount",
          "value": 2712
        }
        """.data(using: .utf8)!
        let expected = CardElement.custom(
            StarCount(id: "42", value: 2712)
        )

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, *)
    func testCustomCardElementEncodeReturnsExpectedJSON() throws {
        // given
        CardElement.register(StarCount.self)
        let cardElement = CardElement.custom(
            StarCount(id: "42", value: 2712)
        )
        let expected = """
        {
          "id" : "42",
          "type" : "StarCount",
          "value" : 2712
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(cardElement)

        // then
        XCTAssertEqual(expected, result)
    }

    func testUnknownTypeDecodeReturnsUnknownCardElement() throws {
        // given
        let json = """
        {
          "id": "xyz",
          "type": "Superunknown",
          "text": "test"
        }
        """.data(using: .utf8)!
        let expected = CardElement.unknown(UnknownCardElement(id: "xyz"))

        // when
        let result = try JSONDecoder().decode(CardElement.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
