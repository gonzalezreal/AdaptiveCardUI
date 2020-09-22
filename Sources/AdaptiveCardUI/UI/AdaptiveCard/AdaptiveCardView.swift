#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    public struct AdaptiveCardView: View {
        @Environment(\.adaptiveCardFeatures) private var features

        private let source: AdaptiveCardSource

        public init(url: URL) {
            source = .url(url)
        }

        public init(_ adaptiveCard: AdaptiveCard) {
            source = .value(adaptiveCard)
        }

        public var body: some View {
            NetworkCardView(source: source, features: features)
        }
    }

#endif
