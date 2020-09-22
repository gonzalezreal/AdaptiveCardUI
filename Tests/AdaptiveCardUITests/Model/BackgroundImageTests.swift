import AdaptiveCardUI
import XCTest

final class BackgroundImageTests: XCTestCase {
    func testDefaults() {
        // when
        let result = BackgroundImage(url: URL(string: "https://adaptivecards.io/content/uparrow.png")!)

        // then
        XCTAssertEqual(URL(string: "https://adaptivecards.io/content/uparrow.png")!, result.url)
        XCTAssertEqual(.cover, result.fillMode)
        XCTAssertEqual(.left, result.horizontalAlignment)
        XCTAssertEqual(.top, result.verticalAlignment)
    }

    func testURLDecodeReturnsBackgroundImage() throws {
        struct Element: Codable, Equatable {
            var backgroundImage: BackgroundImage
        }

        // given
        let json = """
        {
          "backgroundImage": "https://adaptivecards.io/content/AlkiBeach.jpg"
        }
        """.data(using: .utf8)!
        let expected = Element(backgroundImage: BackgroundImage(
            url: URL(string: "https://adaptivecards.io/content/AlkiBeach.jpg")!
        ))

        // when
        let result = try JSONDecoder().decode(Element.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testMinimalBackgroundImageDecodeReturnsBackgroundImage() throws {
        // given
        let json = """
        {
          "url": "https://adaptivecards.io/content/uparrow.png"
        }
        """.data(using: .utf8)!
        let expected = BackgroundImage(url: URL(string: "https://adaptivecards.io/content/uparrow.png")!)

        // when
        let result = try JSONDecoder().decode(BackgroundImage.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testBackgroundImageDecodeReturnsBackgroundImage() throws {
        // given
        let json = """
        {
          "url": "https://adaptivecards.io/content/uparrow.png",
          "fillMode": "repeat",
          "horizontalAlignment": "center",
          "verticalAlignment": "center"
        }
        """.data(using: .utf8)!
        let expected = BackgroundImage(
            url: URL(string: "https://adaptivecards.io/content/uparrow.png")!,
            fillMode: .repeat,
            horizontalAlignment: .center,
            verticalAlignment: .center
        )

        // when
        let result = try JSONDecoder().decode(BackgroundImage.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testMinimalBackgroundImageEncodeReturnsBackgroundImageJSON() throws {
        // given
        let backgroundImage = BackgroundImage(url: URL(string: "https://adaptivecards.io/content/uparrow.png")!)
        let expected = """
        {
          "url" : "https:\\/\\/adaptivecards.io\\/content\\/uparrow.png"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(backgroundImage)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testBackgroundImageEncodeReturnsBackgroundImageJSON() throws {
        // given
        let backgroundImage = BackgroundImage(
            url: URL(string: "https://adaptivecards.io/content/uparrow.png")!,
            fillMode: .repeat,
            horizontalAlignment: .center,
            verticalAlignment: .center
        )
        let expected = """
        {
          "fillMode" : "repeat",
          "horizontalAlignment" : "center",
          "url" : "https:\\/\\/adaptivecards.io\\/content\\/uparrow.png",
          "verticalAlignment" : "center"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(backgroundImage)

        // then
        XCTAssertEqual(expected, result)
    }
}
