#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct ImageSizeImageView: View {
        @Environment(\.imageSizeStyle) private var imageSizeStyle

        private let image: SwiftUI.Image
        private let originalSize: CGSize
        private let size: ImageSize
        private let horizontalAlignment: HAlignment
        private let backgroundColor: Color?
        private let style: ImageStyle

        init(
            image: SwiftUI.Image,
            originalSize: CGSize,
            size: ImageSize,
            horizontalAlignment: HAlignment,
            backgroundColor: Color?,
            style: ImageStyle
        ) {
            self.image = image
            self.originalSize = originalSize
            self.size = size
            self.horizontalAlignment = horizontalAlignment
            self.backgroundColor = backgroundColor
            self.style = style
        }

        var body: some View {
            switch size {
            case .stretch, .small, .medium, .large:
                FixedSizeImageView(
                    image: image,
                    aspectRatio: originalSize.width / originalSize.height,
                    width: imageSizeStyle[size], // `nil` will stretch to the proposed width
                    height: nil,
                    horizontalAlignment: horizontalAlignment,
                    backgroundColor: backgroundColor,
                    style: style
                )
            default:
                AutoImageView(
                    image: image,
                    size: originalSize,
                    horizontalAlignment: horizontalAlignment,
                    backgroundColor: backgroundColor,
                    style: style
                )
            }
        }
    }

#endif
