#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct FixedSizeImageView: View {
        private let image: SwiftUI.Image
        private let aspectRatio: CGFloat
        private let width: CGFloat?
        private let height: CGFloat?
        private let horizontalAlignment: HorizontalAlignment
        private let backgroundColor: Color?
        private let style: ImageStyle

        @State private var contentWidth: CGFloat?
        @State private var contentHeight: CGFloat?

        init(
            image: SwiftUI.Image,
            aspectRatio: CGFloat,
            width: CGFloat?,
            height: CGFloat?,
            horizontalAlignment: HorizontalAlignment,
            backgroundColor: Color?,
            style: ImageStyle
        ) {
            self.image = image
            self.aspectRatio = aspectRatio
            self.width = width
            self.height = height
            self.horizontalAlignment = horizontalAlignment
            self.backgroundColor = backgroundColor
            self.style = style

            _contentWidth = State(initialValue: width)
            _contentHeight = State(initialValue: height)
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .frame(idealWidth: contentWidth)
            .frame(height: contentHeight)
            .onPreferenceChange(ContentSizeKey.self) { contentSize in
                contentWidth = contentSize?.width
                contentHeight = contentSize?.height
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
            switch (width, height) {
            case let (.some(w), .some(h)):
                return CGSize(width: min(w, proposedSize.width), height: h)
            case let (.some(w), .none):
                return CGSize(
                    width: min(w, proposedSize.width),
                    height: min(w, proposedSize.width) / aspectRatio
                )
            case let (.none, .some(h)):
                return CGSize(
                    width: min(h * aspectRatio, proposedSize.width),
                    height: h
                )
            case (.none, .none):
                // stretch
                return CGSize(
                    width: proposedSize.width,
                    height: proposedSize.width / aspectRatio
                )
            }
        }
    }

#endif
