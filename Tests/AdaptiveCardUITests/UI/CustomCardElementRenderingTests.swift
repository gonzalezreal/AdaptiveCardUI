#if SNAPSHOT_TESTS

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class CustomCardElementRenderingTests: XCTestCase {
        override class func setUp() {
            super.setUp()
            CardElement.register(RepoLanguage.self)
            CardElement.register(StarCount.self)
        }

        func testCustomCardElements() {
            let view = AdaptiveCardView(url: fixtureURL("customCardElements.json"))
                .animation(nil)
                .customCardElement { RepoLanguageView($0) }
                .customCardElement { StarCountView($0) }
                .adaptiveCardConfiguration(.test)
                .environment(\.locale, Locale(identifier: "en_US"))

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 150)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
