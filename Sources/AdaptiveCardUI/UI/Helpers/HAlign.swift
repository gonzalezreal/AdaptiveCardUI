#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A view that aligns its content horizontally.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct HAlign<Content: View>: View {
        private let horizontalAlignment: HAlignment?
        private let content: Content

        public init(
            _ horizontalAlignment: HAlignment?,
            @ViewBuilder content: () -> Content
        ) {
            self.horizontalAlignment = horizontalAlignment
            self.content = content()
        }

        public var body: some View {
            HStack(spacing: 0) {
                switch horizontalAlignment {
                case HAlignment.left:
                    content
                    Spacer()
                case HAlignment.center:
                    Spacer()
                    content
                    Spacer()
                case HAlignment.right:
                    Spacer()
                    content
                default:
                    content
                }
            }
        }
    }

#endif
