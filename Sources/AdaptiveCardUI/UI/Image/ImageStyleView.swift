#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ImageStyleView<Content: View>: View {
        @Environment(\.customImageStyles) private var customImageStyles

        private let content: Content
        private let imageStyle: ImageStyle

        init(content: Content, imageStyle: ImageStyle) {
            self.content = content
            self.imageStyle = imageStyle
        }

        var body: some View {
            if let customImageStyle = customImageStyles[imageStyle] {
                customImageStyle.makeBody(content: AnyView(content))
            } else {
                switch imageStyle {
                case .person:
                    content.clipShape(Circle())
                default:
                    content
                }
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension View {
        func imageStyle(_ imageStyle: ImageStyle) -> some View {
            ImageStyleView(content: self, imageStyle: imageStyle)
        }
    }

#endif
