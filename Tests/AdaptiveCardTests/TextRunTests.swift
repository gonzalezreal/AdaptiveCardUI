import AdaptiveCard
import XCTest

final class TextRunTests: XCTestCase {
    func testStringDecodeReturnsTextRun() throws {
        struct Element: Codable, Equatable {
            var inline: TextRun
        }

        // given
        let json = """
        {
          "inline": "Hello world!"
        }
        """.data(using: .utf8)!
        let expected = Element(inline: TextRun(text: "Hello world!"))

        // when
        let result = try JSONDecoder().decode(Element.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testMinimalTextRunDecodeReturnsTextRun() throws {
        // given
        let json = """
        {
          "type": "TextRun",
          "text": "Hello world!"
        }
        """.data(using: .utf8)!
        let expected = TextRun(text: "Hello world!")

        // when
        let result = try JSONDecoder().decode(TextRun.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testTextRunDecodeReturnsTextRun() throws {
        // given
        let json = """
        {
          "type": "TextRun",
          "text": "Hello world!",
          "color": "good",
          "fontType": "monospace",
          "highlight": true,
          "isSubtle": true,
          "italic": true,
          "selectAction": {
            "type": "Action.OpenUrl",
            "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
          },
          "size": "small",
          "strikethrough": true,
          "weight": "bolder"
        }
        """.data(using: .utf8)!
        let expected = TextRun(
            text: "Hello world!",
            color: .good,
            fontType: .monospace,
            highlight: true,
            isSubtle: true,
            italic: true,
            selectAction: .openURL(OpenURLAction(url: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!)),
            size: .small,
            strikethrough: true,
            weight: .bold
        )

        // when
        let result = try JSONDecoder().decode(TextRun.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testMinimalTextRunEncodeReturnsTextRunJSON() throws {
        // given
        let textRun = TextRun(text: "Hello world!")
        let expected = """
        {
          "text" : "Hello world!",
          "type" : "TextRun"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(textRun)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testTextRunEncodeReturnsTextRunJSON() throws {
        // given
        let textRun = TextRun(
            text: "Hello world!",
            color: .good,
            fontType: .monospace,
            highlight: true,
            isSubtle: true,
            italic: true,
            selectAction: .openURL(OpenURLAction(url: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!)),
            size: .small,
            strikethrough: true,
            weight: .bold
        )
        let expected = #"""
        {
          "color" : "good",
          "fontType" : "monospace",
          "highlight" : true,
          "isSubtle" : true,
          "italic" : true,
          "selectAction" : {
            "type" : "Action.OpenUrl",
            "url" : "https:\/\/www.youtube.com\/watch?v=dQw4w9WgXcQ"
          },
          "size" : "small",
          "strikethrough" : true,
          "text" : "Hello world!",
          "type" : "TextRun",
          "weight" : "bolder"
        }
        """#.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(textRun)

        // then
        XCTAssertEqual(expected, result)
    }
}
