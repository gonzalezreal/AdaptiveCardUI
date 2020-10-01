#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class ContainerRenderingTests: XCTestCase {
        func testStyle() {
            let view = AdaptiveCardView(url: fixtureURL("containerStyle.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 340, height: 840)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testBleed() {
            let view = AdaptiveCardView(url: fixtureURL("containerBleed.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 350)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalContentAlignment() {
            let view = AdaptiveCardView(url: fixtureURL("containerVerticalContentAlignment.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 340, height: 415)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testBackgroundImage() {
            let view = AdaptiveCardView(url: fixtureURL("containerBackgroundImage.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 600)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testMinHeight() {
            let view = AdaptiveCardView(url: fixtureURL("containerMinHeight.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
