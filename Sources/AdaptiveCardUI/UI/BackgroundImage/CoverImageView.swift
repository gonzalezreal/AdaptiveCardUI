#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct CoverImageView: View {
        private let image: SwiftUI.Image
        private let aspectRatio: CGFloat
        private let horizontalAlignment: HAlignment
        private let verticalAlignment: VAlignment

        init(
            image: SwiftUI.Image,
            aspectRatio: CGFloat,
            horizontalAlignment: HAlignment,
            verticalAlignment: VAlignment
        ) {
            self.image = image
            self.aspectRatio = aspectRatio
            self.horizontalAlignment = horizontalAlignment
            self.verticalAlignment = verticalAlignment
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .clipped()
        }

        func makeBody(for proposedSize: CGSize) -> some View {
            let size = imageSize(for: proposedSize)
            let offset = imageOffset(for: proposedSize, imageSize: size)

            return image
                .resizable()
                .frame(width: size.width, height: size.height)
                .offset(offset)
        }

        func imageSize(for proposedSize: CGSize) -> CGSize {
            let proposedAspect = proposedSize.width / proposedSize.height

            if proposedAspect > aspectRatio {
                return CGSize(
                    width: proposedSize.width,
                    height: proposedSize.width / aspectRatio
                )
            } else {
                return CGSize(
                    width: proposedSize.height * aspectRatio,
                    height: proposedSize.height
                )
            }
        }

        func imageOffset(for proposedSize: CGSize, imageSize: CGSize) -> CGSize {
            if imageSize.width > proposedSize.width {
                return horizontalAlignment.offset(for: proposedSize, contentSize: imageSize)
            } else if imageSize.height > proposedSize.height {
                return verticalAlignment.offset(for: proposedSize, contentSize: imageSize)
            } else {
                return .zero
            }
        }
    }

#endif
