#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct AutoImageView: View {
        private let image: SwiftUI.Image
        private let size: CGSize
        private let horizontalAlignment: HAlignment
        private let backgroundColor: Color?
        private let style: ImageStyle

        @State private var contentSize: CGSize?

        init(
            image: SwiftUI.Image,
            size: CGSize,
            horizontalAlignment: HAlignment,
            backgroundColor: Color?,
            style: ImageStyle
        ) {
            self.image = image
            self.size = size
            self.horizontalAlignment = horizontalAlignment
            self.backgroundColor = backgroundColor
            self.style = style

            _contentSize = State(initialValue: size)
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .frame(idealWidth: contentSize?.width)
            .frame(height: contentSize?.height)
            .onPreferenceChange(ContentSizeKey.self) {
                contentSize = $0
            }
        }

        func makeBody(for proposedSize: CGSize) -> some View {
            let size = imageSize(for: proposedSize)
            let offset = horizontalAlignment.offset(for: proposedSize, contentSize: size)

            return image
                .resizable()
                .frame(width: size.width, height: size.height)
                .background(backgroundColor)
                .imageStyle(style)
                .offset(offset)
                .preference(key: ContentSizeKey.self, value: size)
        }

        func imageSize(for proposedSize: CGSize) -> CGSize {
            if proposedSize.width < size.width {
                let aspectRatio = size.width / size.height

                return CGSize(
                    width: proposedSize.width,
                    height: proposedSize.width / aspectRatio
                )
            }

            return size
        }
    }

#endif
