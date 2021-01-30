#if canImport(SwiftUI)

    import AdaptiveCard
    import struct AdaptiveCard.Image
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ImageSetView: View {
        @Environment(\.spacingConfiguration) private var spacingConfiguration

        @State private var imageSizes: [String: CGSize] = [:]
        @State private var height: CGFloat?

        private let images: [Image]

        init(_ imageSet: ImageSet) {
            images = imageSet.images.map {
                var result = $0
                result.size = imageSet.supportedImageSize
                return result
            }
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .frame(height: height)
            .onCollectedSizesChange { collectedSizes in
                imageSizes = collectedSizes
            }
            .onPreferenceChange(ContentSizeKey.self) { contentSize in
                height = contentSize?.height
            }
        }

        private func makeBody(for proposedSize: CGSize) -> some View {
            var offsets: [String: CGSize] = [:]
            var layout = FlowLayout(
                proposedSize: proposedSize,
                horizontalSpacing: spacingConfiguration.default,
                verticalSpacing: spacingConfiguration.default
            )

            for image in images {
                guard let size = imageSizes[image.id] else {
                    continue
                }
                let frame = layout.addElementWithSize(size)
                offsets[image.id] = CGSize(width: frame.origin.x, height: frame.origin.y)
            }

            return ZStack(alignment: .topLeading) {
                ForEach(images, id: \.id) { image in
                    ImageView(image)
                        .fixedSize()
                        .collectSize(tag: image.id)
                        .offset(offsets[image.id] ?? .zero)
                }
            }
            .preference(key: ContentSizeKey.self, value: layout.size)
        }
    }

    private extension ImageSet {
        var supportedImageSize: ImageSize {
            switch imageSize {
            case .auto, .stretch:
                return .medium
            default:
                return imageSize
            }
        }
    }

#endif
