#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension Color {
        var subtle: Color { opacity(0.8) }

        static var defaultBackground: Color {
            #if os(macOS)
                return Color(.controlBackgroundColor)
            #elseif os(iOS)
                return Color(.systemBackground)
            #elseif os(tvOS)
                // FIXME: Find an appropriate default background color for tvOS
                return Color.clear
            #elseif os(watchOS)
                // FIXME: Find an appropriate default background color for watchOS
                return Color.black
            #endif
        }

        static var emphasisBackground: Color {
            #if os(macOS)
                return Color(.windowBackgroundColor)
            #elseif os(iOS)
                return Color(.secondarySystemBackground)
            #elseif os(tvOS)
                // FIXME: Find an appropriate emphasis background color for tvOS
                return Color.clear
            #elseif os(watchOS)
                // FIXME: Find an appropriate emphasis background color for watchOS
                return Color(.darkGray)
            #endif
        }
    }

#endif
