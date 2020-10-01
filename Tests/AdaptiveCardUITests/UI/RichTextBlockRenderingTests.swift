#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class RichTextBlockRenderingTests: XCTestCase {
        func testRichTextBlock() {
            let view = AdaptiveCardView(url: fixtureURL("richTextBlock.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 300)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
