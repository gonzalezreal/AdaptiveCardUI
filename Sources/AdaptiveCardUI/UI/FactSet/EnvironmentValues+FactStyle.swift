#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension EnvironmentValues {
        var factStyle: FactStyle {
            get { self[FactStyleKey.self] }
            set { self[FactStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension View {
        func factStyle(_ factStyle: FactStyle) -> some View {
            environment(\.factStyle, factStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    private struct FactStyleKey: EnvironmentKey {
        static let defaultValue: FactStyle = SystemFactStyle()
    }

#endif
