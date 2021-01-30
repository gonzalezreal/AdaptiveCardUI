import AdaptiveCard
import XCTest

final class ActionTests: XCTestCase {
    func testActionOpenUrlDecodeReturnsOpenURLAction() throws {
        // given
        let json = """
        {
          "type": "Action.OpenUrl",
          "url": "https://adaptivecards.io"
        }
        """.data(using: .utf8)!
        let expected = Action.openURL(OpenURLAction(url: URL(string: "https://adaptivecards.io")!))

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testOpenURLActionEncodeReturnsActionOpenUrlJSON() throws {
        // given
        let action = Action.openURL(OpenURLAction(url: URL(string: "https://adaptivecards.io")!))
        let expected = """
        {
          "type" : "Action.OpenUrl",
          "url" : "https:\\/\\/adaptivecards.io"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testActionShowCardDecodeReturnsShowCardAction() throws {
        // given
        let json = """
        {
          "type": "Action.ShowCard",
          "card": {
            "type": "AdaptiveCard",
            "body": [
              {
                "id": "anyId",
                "type": "TextBlock",
                "text": "What do you think?"
              }
            ],
            "actions": [
              {
                "type": "Action.Submit",
                "title": "Neat!"
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let card = AdaptiveCard(
            body: [
                .textBlock(TextBlock(id: "anyId", text: "What do you think?")),
            ],
            actions: [
                .submit(SubmitAction(title: "Neat!")),
            ]
        )
        let expected = Action.showCard(ShowCardAction(card: card))

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testShowCardActionEncodeReturnsActionShowCardJSON() throws {
        // given
        let card = AdaptiveCard(
            body: [
                .textBlock(TextBlock(id: "anyId", text: "What do you think?")),
            ],
            actions: [
                .submit(SubmitAction(title: "Neat!")),
            ]
        )
        let action = Action.showCard(ShowCardAction(card: card))
        let expected = """
        {
          "card" : {
            "actions" : [
              {
                "title" : "Neat!",
                "type" : "Action.Submit"
              }
            ],
            "body" : [
              {
                "id" : "anyId",
                "text" : "What do you think?",
                "type" : "TextBlock"
              }
            ],
            "type" : "AdaptiveCard"
          },
          "type" : "Action.ShowCard"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testActionSubmitDecodeReturnsSubmitAction() throws {
        // given
        let json = """
        {
          "type": "Action.Submit",
          "data": {
            "x": 13
          }
        }
        """.data(using: .utf8)!
        let expected = Action.submit(SubmitAction(data: ["x": .int(13)]))

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testActionSubmitWithoutDataDecodeReturnsSubmitAction() throws {
        // given
        let json = """
        {
          "type": "Action.Submit"
        }
        """.data(using: .utf8)!
        let expected = Action.submit(SubmitAction())

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testSubmitActionEncodeReturnsActionSubmitJSON() throws {
        // given
        let action = Action.submit(SubmitAction(data: ["x": .int(13)]))

        let expected = """
        {
          "data" : {
            "x" : 13
          },
          "type" : "Action.Submit"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testEmptySubmitActionEncodeReturnsActionSubmitJSON() throws {
        // given
        let action = Action.submit(SubmitAction())

        let expected = """
        {
          "type" : "Action.Submit"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testActionToggleVisibilityDecodeReturnsToggleVisibilityAction() throws {
        // given
        let json = """
        {
          "type": "Action.ToggleVisibility",
          "targetElements": [
            {
              "elementId": "textToToggle",
              "isVisible": true
            }
          ]
        }
        """.data(using: .utf8)!
        let expected = Action.toggleVisibility(
            ToggleVisibilityAction(targetElements: [TargetElement(elementId: "textToToggle", isVisible: true)])
        )

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    func testToggleVisibilityActionEncodeReturnsActionToggleVisibilityJSON() throws {
        // given
        let action = Action.toggleVisibility(
            ToggleVisibilityAction(targetElements: [TargetElement(elementId: "textToToggle", isVisible: true)])
        )
        let expected = """
        {
          "targetElements" : [
            {
              "elementId" : "textToToggle",
              "isVisible" : true
            }
          ],
          "type" : "Action.ToggleVisibility"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testUnknownActionDecodeReturnsUnknownAction() throws {
        // given
        let json = """
        {
          "type": "Superunknown"
        }
        """.data(using: .utf8)!
        let expected = Action.unknown(UnknownAction())

        // when
        let result = try JSONDecoder().decode(Action.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }
}
