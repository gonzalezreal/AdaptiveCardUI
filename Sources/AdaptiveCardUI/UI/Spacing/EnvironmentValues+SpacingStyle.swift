#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        var spacingStyle: SpacingStyle {
            get { self[SpacingStyleKey.self] }
            set { self[SpacingStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func spacingStyle(_ spacingStyle: SpacingStyle) -> some View {
            environment(\.spacingStyle, spacingStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct SpacingStyleKey: EnvironmentKey {
        static let defaultValue = SpacingStyle()
    }

#endif
