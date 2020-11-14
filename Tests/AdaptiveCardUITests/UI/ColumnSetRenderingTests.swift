#if SNAPSHOT_TESTS

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class ColumnSetRenderingTests: XCTestCase {
        func testBackgroundImage() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetBackgroundImage.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 400, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testBleed() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetBleed.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 400, height: 500)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testMinHeight() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetMinHeight.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testStyle() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetStyle.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 500, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testWidth() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetWidth.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 400, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalContentAlignment() {
            let view = AdaptiveCardView(url: fixtureURL("columnSetVerticalContentAlignment.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 500, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
