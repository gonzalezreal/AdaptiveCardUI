#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct RepeatVerticallyImageView: View {
        private let image: SwiftUI.Image
        private let size: CGSize
        private let horizontalAlignment: HAlignment

        init(
            image: SwiftUI.Image,
            size: CGSize,
            horizontalAlignment: HAlignment
        ) {
            self.image = image
            self.size = size
            self.horizontalAlignment = horizontalAlignment
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .clipped()
        }

        func makeBody(for proposedSize: CGSize) -> some View {
            let count = Int(ceil(proposedSize.height / size.height))
            let offset = horizontalAlignment.offset(for: proposedSize, contentSize: size)

            return VStack(spacing: 0) {
                ForEach(1 ... count, id: \.self) { _ in
                    image
                }
            }
            .offset(offset)
        }
    }

#endif
