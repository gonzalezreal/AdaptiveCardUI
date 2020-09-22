@testable import AdaptiveCardUI
import XCTest

final class AdaptiveCardFeatureAdaptableTests: XCTestCase {
    func testUnknownActionResolvesToFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [],
          "actions": [
            {
              "type": "Superunknown",
              "title": "Unknown action",
              "fallback": {
                "type": "Action.OpenUrl",
                "title": "Open URL",
                "url": "https://example.com"
              }
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [],
            actions: [
                .openURL(
                    OpenURLAction(
                        url: URL(string: "https://example.com")!,
                        title: "Open URL"
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownActionWithoutFallbackIsRemoved() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [],
          "actions": [
            {
              "type": "Superunknown",
              "title": "Unknown action"
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3)
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownActionWithoutFallbackResolvesToParentFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [
            {
              "type": "ActionSet",
              "fallback": {
                "id": "1",
                "type": "TextBlock",
                "text": "Fallback text"
              },
              "actions": [
                {
                  "type": "Superunknown",
                  "title": "Unknown action"
                },
                {
                  "type": "Action.OpenUrl",
                  "url": "https://example.com",
                  "title": "Open URL"
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .textBlock(TextBlock(id: "1", text: "Fallback text")),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownActionWithoutFallbackIsRemovedFromParentWithoutFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [
            {
              "type": "ActionSet",
              "id": "fistro",
              "actions": [
                {
                  "type": "Superunknown",
                  "title": "Unknown action"
                },
                {
                  "type": "Action.OpenUrl",
                  "url": "https://example.com",
                  "title": "Open URL"
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .actionSet(
                    ActionSet(
                        id: "fistro",
                        actions: [
                            .openURL(
                                OpenURLAction(
                                    url: URL(string: "https://example.com")!,
                                    title: "Open URL"
                                )
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnsupportedActionResolvesToFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [],
          "actions": [
            {
              "type": "Action.OpenUrl",
              "title": "Unsupported action",
              "url": "https://example.com",
              "requires": {
                "diodeno": "3.0"
              },
              "fallback": {
                "type": "Action.OpenUrl",
                "title": "Fallback action",
                "url": "https://example.com"
              }
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [],
            actions: [
                .openURL(
                    OpenURLAction(
                        url: URL(string: "https://example.com")!,
                        title: "Fallback action"
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnsupportedActionWithNestedFallbacksResolvesToFirstSupportedFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [],
          "actions": [
            {
              "type": "Action.OpenUrl",
              "title": "Unsupported action",
              "url": "https://example.com",
              "requires": {
                "diodeno": "3.0"
              },
              "fallback": {
                "type": "Action.OpenUrl",
                "title": "Fallback action",
                "url": "https://example.com",
                "requires": {
                  "diodeno": "1.5"
                },
                "fallback": {
                  "type": "Action.OpenUrl",
                  "title": "Another fallback action",
                  "url": "https://example.com"
                }
              }
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [],
            actions: [
                .openURL(
                    OpenURLAction(
                        url: URL(string: "https://example.com")!,
                        title: "Another fallback action"
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures(["diodeno": SemanticVersion(major: 1)])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownElementInContainerResolvesToFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "version": "1.3",
          "body": [
            {
              "type": "Container",
              "id": "1",
              "items": [
                {
                  "type": "Graph",
                  "foo": "bar",
                  "fallback": {
                    "id": "2",
                    "type": "TextBlock",
                    "text": "Fallback text"
                  }
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .container(
                    Container(
                        id: "1",
                        items: [
                            .textBlock(
                                TextBlock(id: "2", text: "Fallback text")
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownElementWithoutFallbackIsRemovedFromParentContainer() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "version": "1.3",
          "body": [
            {
              "type": "Container",
              "id": "1",
              "items": [
                {
                  "type": "Graph",
                  "foo": "bar"
                },
                {
                  "type": "TextBlock",
                  "id": "2",
                  "text": "Test"
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .container(
                    Container(
                        id: "1",
                        items: [
                            .textBlock(
                                TextBlock(id: "2", text: "Test")
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testUnknownElementWithoutFallbackIsResolvedToParentFallback() throws {
        // given
        let json = #"""
        {
          "type": "AdaptiveCard",
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "version": "1.3",
          "body": [
            {
              "type": "Container",
              "fallback": {
                "id": "1",
                "type": "TextBlock",
                "text": "Fallback text"
              },
              "items": [
                {
                  "type": "Graph",
                  "foo": "bar"
                },
                {
                  "type": "TextBlock",
                  "id": "2",
                  "text": "Test"
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .textBlock(
                    TextBlock(id: "1", text: "Fallback text")
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testDeeplyNestedUnsupportedElementIsResolvedByAncestorFallback() throws {
        // given
        let json = #"""
        {
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [
            {
              "type": "Container",
              "fallback": {
                "type": "TextBlock",
                "id": "1",
                "text": "Fallback text"
              },
              "items": [
                {
                  "type": "TextBlock",
                  "text": "Test"
                },
                {
                  "type": "ColumnSet",
                  "columns": [
                    {
                      "type": "Column",
                      "width": "stretch",
                      "items": [
                        {
                          "type": "TextBlock",
                          "text": "A",
                          "requires": {
                            "adaptiveCards": "5.0"
                          }
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .textBlock(
                    TextBlock(id: "1", text: "Fallback text")
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testDeeplyNestedUnsupportedElementWithoutFallbackIsRemovedFromParent() throws {
        // given
        let json = #"""
        {
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [
            {
              "type": "Container",
              "id": "1",
              "items": [
                {
                  "type": "TextBlock",
                  "id": "2",
                  "text": "Test"
                },
                {
                  "type": "ColumnSet",
                  "id": "3",
                  "columns": [
                    {
                      "type": "Column",
                      "id": "4",
                      "items": [
                        {
                          "type": "TextBlock",
                          "text": "A",
                          "requires": {
                            "adaptiveCards": "5.0"
                          }
                        },
                        {
                          "type": "TextBlock",
                          "id": "5",
                          "text": "B"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .container(
                    Container(
                        id: "1",
                        items: [
                            .textBlock(
                                TextBlock(id: "2", text: "Test")
                            ),
                            .columnSet(
                                ColumnSet(
                                    id: "3",
                                    columns: [
                                        Column(
                                            id: "4",
                                            items: [
                                                .textBlock(
                                                    TextBlock(id: "5", text: "B")
                                                ),
                                            ]
                                        ),
                                    ]
                                )
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }

    func testActionShowCardIsResolved() throws {
        // given
        let json = #"""
        {
          "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
          "type": "AdaptiveCard",
          "version": "1.3",
          "body": [
            {
              "id": "1",
              "type": "TextBlock",
              "text": "Test"
            }
          ],
          "actions": [
            {
              "type": "Action.ShowCard",
              "title": "Show",
              "card": {
                "type": "AdaptiveCard",
                "body": [
                  {
                    "id": "2",
                    "type": "Graph",
                    "foo": "bar",
                    "fallback": {
                      "id": "2",
                      "type": "TextBlock",
                      "text": "Test"
                    }
                  },
                  {
                    "id": "3",
                    "type": "TextBlock",
                    "text": "A",
                    "requires": {
                      "adaptiveCards": "5.0"
                    }
                  }
                ]
              }
            }
          ]
        }
        """# .data(using: .utf8)!
        let expected = AdaptiveCard(
            version: SemanticVersion(major: 1, minor: 3),
            body: [
                .textBlock(
                    TextBlock(id: "1", text: "Test")
                ),
            ],
            actions: [
                .showCard(
                    ShowCardAction(
                        card: AdaptiveCard(
                            body: [
                                .textBlock(
                                    TextBlock(id: "2", text: "Test")
                                ),
                            ]
                        ),
                        title: "Show"
                    )
                ),
            ]
        )

        // when
        let result = try JSONDecoder()
            .decode(AdaptiveCard.self, from: json)
            .adaptingToFeatures([:])

        // then
        XCTAssertEqual(result, expected)
    }
}
