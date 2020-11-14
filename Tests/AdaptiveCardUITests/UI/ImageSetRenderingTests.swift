#if SNAPSHOT_TESTS

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class ImageSetRenderingTests: XCTestCase {
        func testImageSet() {
            let view = AdaptiveCardView(url: fixtureURL("imageSet.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 260)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
