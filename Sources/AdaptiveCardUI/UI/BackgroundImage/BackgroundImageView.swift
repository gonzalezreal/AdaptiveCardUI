#if canImport(SwiftUI)

    import NetworkImage
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct BackgroundImageView<Content: View>: View {
        private let backgroundImage: BackgroundImage?
        private let content: Content

        init(_ backgroundImage: BackgroundImage?, for content: Content) {
            self.backgroundImage = backgroundImage
            self.content = content
        }

        var body: some View {
            if let backgroundImage = self.backgroundImage {
                content
                    .background(NetworkImage(url: backgroundImage.url))
                    .networkImageStyle(
                        BackgroundImageStyle(
                            fillMode: backgroundImage.fillMode,
                            horizontalAlignment: backgroundImage.horizontalAlignment,
                            verticalAlignment: backgroundImage.verticalAlignment
                        )
                    )
            } else {
                content
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension View {
        func backgroundImage(_ backgroundImage: BackgroundImage?) -> some View {
            BackgroundImageView(backgroundImage, for: self)
        }
    }

#endif
