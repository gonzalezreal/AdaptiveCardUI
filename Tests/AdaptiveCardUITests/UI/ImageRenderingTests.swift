#if os(iOS) && canImport(SwiftUI)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AdaptiveCardUI

    extension ImageStyle {
        static let rounded = ImageStyle(rawValue: "rounded")
    }

    @available(iOS 14.0, *)
    struct RoundedImageStyle: CustomImageStyle {
        func makeBody(content: Content) -> some View {
            content.clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }

    @available(iOS 14.0, *)
    final class ImageRenderingTests: XCTestCase {
        func testImage() {
            let view = AdaptiveCardView(url: fixtureURL("image.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testBackgroundColor() {
            let view = AdaptiveCardView(url: fixtureURL("imageBackgroundColor.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testHorizontalAlignment() {
            let view = AdaptiveCardView(url: fixtureURL("imageHorizontalAlignment.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testWidthHeight() {
            let view = AdaptiveCardView(url: fixtureURL("imageWidthHeight.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testSize() {
            let view = AdaptiveCardView(url: fixtureURL("imageSize.json"))
                .animation(nil)
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 240, height: 600)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testCustomStyle() {
            let view = AdaptiveCardView(url: fixtureURL("imageCustomStyle.json"))
                .animation(nil)
                .onImageStyle(.rounded, apply: RoundedImageStyle())
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }

        func testOverridingCustomStyle() {
            let view = AdaptiveCardView(url: fixtureURL("imageBackgroundColor.json"))
                .animation(nil)
                .onImageStyle(.default, apply: RoundedImageStyle())
                .adaptiveCardConfiguration(.test)

            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

            assertSnapshot(matching: vc, as: .wait(for: 0.25, on: .image))
        }
    }

#endif
