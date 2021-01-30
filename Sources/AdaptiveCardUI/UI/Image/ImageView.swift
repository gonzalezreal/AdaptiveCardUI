#if canImport(SwiftUI)

    import struct AdaptiveCard.Image
    import NetworkImage
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ImageView: View {
        private let image: Image

        init(_ image: Image) {
            self.image = image
        }

        var body: some View {
            NetworkImage(url: image.url)
                .selectAction(image.selectAction)
                .networkImageStyle(
                    PrimitiveImageStyle(
                        width: image.width?.cgFloatValue,
                        height: image.height.cgFloatValue,
                        size: image.size,
                        horizontalAlignment: image.horizontalAlignment,
                        style: image.style,
                        backgroundColor: Color(argbHex: image.backgroundColor)
                    )
                )
        }
    }

#endif
