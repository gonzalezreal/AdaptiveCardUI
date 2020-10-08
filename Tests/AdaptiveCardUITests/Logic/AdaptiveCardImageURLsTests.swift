@testable import AdaptiveCardUI
import XCTest

final class AdaptiveCardImageURLsTests: XCTestCase {
    func testImageURLs() {
        // given
        let adaptiveCard = AdaptiveCard(
            body: [
                .image(Image(url: URL(string: "https://example.com/image1.png")!)),
                .actionSet(
                    ActionSet(
                        actions: [
                            .submit(
                                SubmitAction(
                                    iconURL: URL(string: "https://example.com/actionIcon1.png")!
                                )
                            ),
                        ]
                    )
                ),
                .columnSet(
                    ColumnSet(
                        columns: [
                            Column(
                                items: [
                                    .image(Image(url: URL(string: "https://example.com/image2.png")!)),
                                ],
                                backgroundImage: BackgroundImage(
                                    url: URL(string: "https://example.com/columnBackground.png")!
                                )
                            ),
                        ]
                    )
                ),
                .imageSet(
                    ImageSet(images: [
                        Image(url: URL(string: "https://example.com/image4.png")!),
                    ])
                ),
            ],
            actions: [
                .openURL(
                    OpenURLAction(
                        url: URL(string: "https://example.com")!,
                        iconURL: URL(string: "https://example.com/actionIcon2.png")!
                    )
                ),
                .showCard(
                    ShowCardAction(
                        card: AdaptiveCard(
                            body: [
                                .container(
                                    Container(
                                        items: [
                                            .image(Image(url: URL(string: "https://example.com/image3.png")!)),
                                            .image(Image(url: URL(string: "https://example.com/image3.png")!)),
                                        ],
                                        backgroundImage: BackgroundImage(
                                            url: URL(string: "https://example.com/containerBackground.png")!
                                        )
                                    )
                                ),
                            ]
                        )
                    )
                ),
            ],
            backgroundImage: BackgroundImage(
                url: URL(string: "https://example.com/cardBackground.png")!
            )
        )
        let expected: Set = [
            URL(string: "https://example.com/image1.png")!,
            URL(string: "https://example.com/actionIcon1.png")!,
            URL(string: "https://example.com/image2.png")!,
            URL(string: "https://example.com/columnBackground.png")!,
            URL(string: "https://example.com/image4.png")!,
            URL(string: "https://example.com/actionIcon2.png")!,
            URL(string: "https://example.com/image3.png")!,
            URL(string: "https://example.com/containerBackground.png")!,
            URL(string: "https://example.com/cardBackground.png")!,
        ]

        // when
        let result = adaptiveCard.imageURLs

        // then
        XCTAssertEqual(expected, result)
    }
}
