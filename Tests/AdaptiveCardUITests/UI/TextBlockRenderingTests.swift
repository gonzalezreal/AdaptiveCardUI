#if SNAPSHOT_TESTS

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class TextBlockRenderingTests: XCTestCase {
        func testColor() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockColor.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testFontType() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockFontType.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalAlignment() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockHorizontalAlignment.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testIsSubtle() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockIsSubtle.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testMaxLines() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockMaxLines.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testSize() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockSize.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testWeight() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockWeight.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testWrap() {
            let view = AdaptiveCardView(url: fixtureURL("textBlockWrap.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
