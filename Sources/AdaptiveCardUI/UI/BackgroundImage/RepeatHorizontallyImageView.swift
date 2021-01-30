#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct RepeatHorizontallyImageView: View {
        private let image: SwiftUI.Image
        private let size: CGSize
        private let verticalAlignment: VAlignment

        init(
            image: SwiftUI.Image,
            size: CGSize,
            verticalAlignment: VAlignment
        ) {
            self.image = image
            self.size = size
            self.verticalAlignment = verticalAlignment
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .clipped()
        }

        func makeBody(for proposedSize: CGSize) -> some View {
            let count = Int(ceil(proposedSize.width / size.width))
            let offset = verticalAlignment.offset(for: proposedSize, contentSize: size)

            return HStack(spacing: 0) {
                ForEach(1 ... count, id: \.self) { _ in
                    image
                }
            }
            .offset(offset)
        }
    }

#endif
