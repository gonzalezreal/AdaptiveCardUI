@testable import AdaptiveCardUI
import XCTest

final class AdaptiveCardDuplicateIdentifiersTests: XCTestCase {
    func testDuplicateNestedIdentifiers() {
        // given
        let adaptiveCard = AdaptiveCard(
            body: [
                .richTextBlock(
                    RichTextBlock(
                        id: "1",
                        inlines: [TextRun(text: "Test")]
                    )
                ),
                .textBlock(
                    TextBlock(id: "2", text: "Test")
                ),
                .textBlock(
                    TextBlock(id: "3", text: "Test")
                ),
                .textBlock(
                    TextBlock(id: "4", text: "Test")
                ),
                .textBlock(
                    TextBlock(id: "5", text: "Test")
                ),
                .textBlock(
                    TextBlock(id: "7", text: "Test")
                ),
                .textBlock(
                    TextBlock(id: "8", text: "Test")
                ),
                .container(
                    Container(
                        id: "3",
                        items: [
                            .textBlock(
                                TextBlock(id: "2", text: "Test")
                            ),
                            .textBlock(
                                TextBlock(id: "6", text: "Test")
                            ),
                            .textBlock(
                                TextBlock(id: "9", text: "Test")
                            ),
                        ]
                    )
                ),
                .columnSet(
                    ColumnSet(
                        id: "4",
                        columns: [
                            Column(
                                id: "8",
                                items: [
                                    .textBlock(
                                        TextBlock(id: "9", text: "Test")
                                    ),
                                ]
                            ),
                        ]
                    )
                ),
            ],
            actions: [
                .showCard(
                    ShowCardAction(
                        card: AdaptiveCard(
                            body: [
                                .textBlock(
                                    TextBlock(id: "1", text: "Test")
                                ),
                            ]
                        )
                    )
                ),
            ]
        )
        let expected: Set = ["1", "2", "3", "4", "8", "9"]

        // when
        let result = adaptiveCard.duplicateIdentifiers

        // then
        XCTAssertEqual(expected, result)
    }

    func testDuplicateIdentifierInFallbackIsNotReported() {
        // given
        let adaptiveCard = AdaptiveCard(
            body: [
                .textBlock(
                    TextBlock(
                        id: "1",
                        fallback: .element(
                            .textBlock(
                                TextBlock(id: "2", text: "Test")
                            )
                        ),
                        requires: [
                            "diodeno": SemanticVersion(major: 1),
                        ],
                        text: "Test"
                    )
                ),
                .image(
                    Image(
                        id: "2",
                        url: URL(string: "https://example.com")!
                    )
                ),
            ]
        )

        // when
        let result = adaptiveCard.duplicateIdentifiers

        // then
        XCTAssertEqual([], result)
    }

    func testDuplicateIdentifierInFallbackIsReportedAfterFeatureAdaptation() {
        // given
        let adaptiveCard = AdaptiveCard(
            body: [
                .textBlock(
                    TextBlock(
                        id: "1",
                        fallback: .element(
                            .textBlock(
                                TextBlock(id: "2", text: "Test")
                            )
                        ),
                        requires: [
                            "diodeno": SemanticVersion(major: 1),
                        ],
                        text: "Test"
                    )
                ),
                .image(
                    Image(
                        id: "2",
                        url: URL(string: "https://example.com")!
                    )
                ),
            ]
        )

        // when
        let result = adaptiveCard
            .adaptingToFeatures([:])
            .duplicateIdentifiers

        // then
        XCTAssertEqual(["2"], result)
    }
}
