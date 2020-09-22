#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        var colorStyle: ColorStyle {
            get { self[ColorStyleKey.self] }
            set { self[ColorStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func colorStyle(_ colorStyle: ColorStyle) -> some View {
            environment(\.colorStyle, colorStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ColorStyleKey: EnvironmentKey {
        static let defaultValue: ColorStyle = SystemColorStyle()
    }

#endif
