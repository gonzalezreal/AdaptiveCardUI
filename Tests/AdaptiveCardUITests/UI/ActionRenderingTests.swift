#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    @available(iOS 14.0, *)
    final class ActionRenderingTests: XCTestCase {
        func testMaxActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(maxActions: 2))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testSpacing() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(spacing: .extraLarge))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalStretchActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(actionsOrientation: .horizontal))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalLeftActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(
                    ActionSetConfiguration(
                        actionsOrientation: .horizontal,
                        actionAlignment: .left
                    )
                )
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalCenterActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(
                    ActionSetConfiguration(
                        actionsOrientation: .horizontal,
                        actionAlignment: .center
                    )
                )
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalRightActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(
                    ActionSetConfiguration(
                        actionsOrientation: .horizontal,
                        actionAlignment: .right
                    )
                )
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalButtonSpacing() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(
                    ActionSetConfiguration(
                        actionsOrientation: .horizontal,
                        buttonSpacing: 24
                    )
                )
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalLeftActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(actionAlignment: .left))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalCenterActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(actionAlignment: .center))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalRightActions() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(actionAlignment: .right))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testVerticalButtonSpacing() {
            let view = AdaptiveCardView(url: fixtureURL("actions.json"))
                .actionSetConfiguration(ActionSetConfiguration(buttonSpacing: 24))
                .buttonStyle(CapsuleButtonStyle())
                .animation(nil)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 300)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
