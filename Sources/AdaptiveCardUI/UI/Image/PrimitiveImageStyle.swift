#if canImport(SwiftUI)

    import NetworkImage
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct PrimitiveImageStyle: NetworkImageStyle {
        private let width: CGFloat?
        private let height: CGFloat?
        private let size: ImageSize
        private let horizontalAlignment: HorizontalAlignment
        private let style: ImageStyle
        private let backgroundColor: Color?

        init(
            width: CGFloat?,
            height: CGFloat?,
            size: ImageSize,
            horizontalAlignment: HorizontalAlignment,
            style: ImageStyle,
            backgroundColor: Color?
        ) {
            self.width = width
            self.height = height
            self.size = size
            self.horizontalAlignment = horizontalAlignment
            self.style = style
            self.backgroundColor = backgroundColor
        }

        func makeBody(state: NetworkImageState) -> some View {
            switch state {
            case .loading, .failed:
                EmptyView()
            case let .image(image, size):
                if width != nil || height != nil {
                    FixedSizeImageView(
                        image: image,
                        aspectRatio: size.width / size.height,
                        width: width,
                        height: height,
                        horizontalAlignment: horizontalAlignment,
                        backgroundColor: backgroundColor,
                        style: style
                    )
                } else {
                    ImageSizeImageView(
                        image: image,
                        originalSize: size,
                        size: self.size,
                        horizontalAlignment: horizontalAlignment,
                        backgroundColor: backgroundColor,
                        style: style
                    )
                }
            }
        }
    }

#endif
