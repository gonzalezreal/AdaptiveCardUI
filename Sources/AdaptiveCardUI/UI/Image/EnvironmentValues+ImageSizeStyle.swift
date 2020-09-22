#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        var imageSizeStyle: ImageSizeStyle {
            get { self[ImageSizeStyleKey.self] }
            set { self[ImageSizeStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func imageSizeStyle(_ imageSizeStyle: ImageSizeStyle) -> some View {
            environment(\.imageSizeStyle, imageSizeStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ImageSizeStyleKey: EnvironmentKey {
        static let defaultValue = ImageSizeStyle()
    }

#endif
