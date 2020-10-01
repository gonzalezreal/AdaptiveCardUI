#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class FactSetRenderingTests: XCTestCase {
        func testFactSet() {
            let view = AdaptiveCardView(url: fixtureURL("factSet.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 400, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
