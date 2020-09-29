#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        var containerColorStyle: ContainerColorStyle {
            get { self[ContainerColorStyleKey.self] }
            set { self[ContainerColorStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func containerColorStyle(_ containerColorStyle: ContainerColorStyle) -> some View {
            environment(\.containerColorStyle, containerColorStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ContainerColorStyleKey: EnvironmentKey {
        static let defaultValue: ContainerColorStyle = SystemColorStyle()
    }

#endif
