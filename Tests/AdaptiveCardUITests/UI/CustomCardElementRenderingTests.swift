#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class CustomCardElementRenderingTests: XCTestCase {
        func testCustomCardElements() {
            let view = AdaptiveCardView(url: fixtureURL("customCardElements.json"))
                .animation(nil)
                .customCardElement(RepoLanguage.self) { RepoLanguageView($0) }
                .customCardElement(StarCount.self) { StarCountView($0) }
                .adaptiveCardConfiguration(HostConfig())
                .environment(\.locale, Locale(identifier: "en_US"))

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 150)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
