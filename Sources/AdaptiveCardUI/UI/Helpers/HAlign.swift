#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct HAlign<Content: View>: View {
        private let horizontalAlignment: AdaptiveCardUI.HorizontalAlignment?
        private let content: Content

        public init(
            _ horizontalAlignment: AdaptiveCardUI.HorizontalAlignment?,
            @ViewBuilder content: () -> Content
        ) {
            self.horizontalAlignment = horizontalAlignment
            self.content = content()
        }

        public var body: some View {
            HStack(spacing: 0) {
                switch horizontalAlignment {
                case HorizontalAlignment.left:
                    content
                    Spacer()
                case HorizontalAlignment.center:
                    Spacer()
                    content
                    Spacer()
                case HorizontalAlignment.right:
                    Spacer()
                    content
                default:
                    content
                }
            }
        }
    }

#endif
