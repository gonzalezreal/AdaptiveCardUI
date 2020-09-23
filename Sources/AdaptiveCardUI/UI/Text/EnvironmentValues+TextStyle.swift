#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension EnvironmentValues {
        var textStyle: TextStyle {
            get { self[TextStyleKey.self] }
            set { self[TextStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension View {
        func textStyle(_ textStyle: TextStyle) -> some View {
            environment(\.textStyle, textStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    private struct TextStyleKey: EnvironmentKey {
        static let defaultValue: TextStyle = SystemTextStyle()
    }

#endif
