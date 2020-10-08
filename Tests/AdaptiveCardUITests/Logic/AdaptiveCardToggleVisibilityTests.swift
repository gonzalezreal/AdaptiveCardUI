@testable import AdaptiveCardUI
import XCTest

final class AdaptiveCardToggleVisibilityTests: XCTestCase {
    func testBodyElementToggleVisibilityUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "textToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [
                .textBlock(TextBlock(id: "someId", text: "Some text")),
                .textBlock(TextBlock(id: targetElement.elementId, isVisible: false, text: "Hidden text")),
            ]
        )
        let expected = AdaptiveCard(
            body: [
                .textBlock(TextBlock(id: "someId", text: "Some text")),
                .textBlock(TextBlock(id: targetElement.elementId, isVisible: true, text: "Hidden text")),
            ]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testNotFoundBodyElementToggleVisibilityDoesNotUpdateVisibility() {
        // given
        let targetElement = TargetElement(elementId: "textToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [.textBlock(TextBlock(id: "someId", text: "Some text"))]
        )
        let expected = AdaptiveCard(
            body: [.textBlock(TextBlock(id: "someId", text: "Some text"))]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testBodyElementHideUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "textToToggle", isVisible: false)
        var adaptiveCard = AdaptiveCard(
            body: [.textBlock(TextBlock(id: targetElement.elementId, text: "Hidden text"))]
        )
        let expected = AdaptiveCard(
            body: [.textBlock(TextBlock(id: targetElement.elementId, isVisible: false, text: "Hidden text"))]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testContainerItemToggleVisibilityUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "textToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [
                .container(
                    Container(
                        id: "someContainer",
                        items: [
                            .textBlock(TextBlock(id: "someId", text: "Some text")),
                            .textBlock(TextBlock(id: targetElement.elementId, isVisible: false, text: "Hidden text")),
                        ]
                    )
                ),
            ]
        )
        let expected = AdaptiveCard(
            body: [
                .container(
                    Container(
                        id: "someContainer",
                        items: [
                            .textBlock(TextBlock(id: "someId", text: "Some text")),
                            .textBlock(TextBlock(id: targetElement.elementId, isVisible: true, text: "Hidden text")),
                        ]
                    )
                ),
            ]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testColumnSetColumnToggleVisibilityUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "columnToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [
                .columnSet(
                    ColumnSet(
                        id: "someColumnSet",
                        columns: [
                            Column(
                                id: "someColumn",
                                items: [
                                    .textBlock(TextBlock(id: "someTextBlockId", text: "Some text")),
                                ]
                            ),
                            Column(
                                id: targetElement.elementId,
                                isVisible: false,
                                items: [
                                    .textBlock(TextBlock(id: "someOtherTextBlockId", text: "Some other text")),
                                ]
                            ),
                        ]
                    )
                ),
            ]
        )
        let expected = AdaptiveCard(
            body: [
                .columnSet(
                    ColumnSet(
                        id: "someColumnSet",
                        columns: [
                            Column(
                                id: "someColumn",
                                items: [
                                    .textBlock(TextBlock(id: "someTextBlockId", text: "Some text")),
                                ]
                            ),
                            Column(
                                id: targetElement.elementId,
                                isVisible: true,
                                items: [
                                    .textBlock(TextBlock(id: "someOtherTextBlockId", text: "Some other text")),
                                ]
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testColumnSetItemToggleVisibilityUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "textToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [
                .columnSet(
                    ColumnSet(
                        id: "someColumnSet",
                        columns: [
                            Column(
                                id: "someColumn",
                                items: [
                                    .textBlock(TextBlock(id: "someTextBlockId", text: "Some text")),
                                    .textBlock(TextBlock(id: targetElement.elementId, isVisible: false, text: "Some text")),
                                ]
                            ),
                        ]
                    )
                ),
            ]
        )
        let expected = AdaptiveCard(
            body: [
                .columnSet(
                    ColumnSet(
                        id: "someColumnSet",
                        columns: [
                            Column(
                                id: "someColumn",
                                items: [
                                    .textBlock(TextBlock(id: "someTextBlockId", text: "Some text")),
                                    .textBlock(TextBlock(id: targetElement.elementId, isVisible: true, text: "Some text")),
                                ]
                            ),
                        ]
                    )
                ),
            ]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }

    func testImageSetItemToggleVisibilityUpdatesVisibility() {
        // given
        let targetElement = TargetElement(elementId: "imageToToggle")
        var adaptiveCard = AdaptiveCard(
            body: [
                .imageSet(
                    ImageSet(
                        id: "someImageSet",
                        images: [
                            Image(id: "someId", url: URL(string: "https://example.com/image1.png")!),
                            Image(id: targetElement.elementId, isVisible: false, url: URL(string: "https://example.com/image2.png")!),
                        ]
                    )
                ),
            ]
        )
        let expected = AdaptiveCard(
            body: [
                .imageSet(
                    ImageSet(
                        id: "someImageSet",
                        images: [
                            Image(id: "someId", url: URL(string: "https://example.com/image1.png")!),
                            Image(id: targetElement.elementId, isVisible: true, url: URL(string: "https://example.com/image2.png")!),
                        ]
                    )
                ),
            ]
        )

        // when
        adaptiveCard.toggleVisibility(of: [targetElement])

        // then
        XCTAssertEqual(expected, adaptiveCard)
    }
}
