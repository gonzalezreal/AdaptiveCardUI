#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        var containerStyle: ContainerStyle {
            get { self[ContainerStyleKey.self] }
            set { self[ContainerStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    internal extension View {
        @ViewBuilder func containerStyle(_ containerStyle: ContainerStyle?) -> some View {
            if let containerStyle = containerStyle {
                environment(\.containerStyle, containerStyle)
            } else {
                self
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ContainerStyleKey: EnvironmentKey {
        static let defaultValue: ContainerStyle = .default
    }

#endif
