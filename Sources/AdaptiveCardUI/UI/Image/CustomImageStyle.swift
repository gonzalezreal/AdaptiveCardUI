#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public protocol CustomImageStyle {
        associatedtype Body: View

        func makeBody(content: Content) -> Body

        typealias Content = AnyView
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct AnyCustomImageStyle: CustomImageStyle {
        private let _makeBody: (Content) -> AnyView

        init<T>(_ customImageStyle: T) where T: CustomImageStyle {
            _makeBody = {
                AnyView(customImageStyle.makeBody(content: $0))
            }
        }

        func makeBody(content: Content) -> AnyView {
            _makeBody(content)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func onImageStyle<T>(_ imageStyle: ImageStyle, apply customImageStyle: T) -> some View where T: CustomImageStyle {
            environment(
                \.customImageStyles,
                [imageStyle: AnyCustomImageStyle(customImageStyle)]
            )
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension EnvironmentValues {
        var customImageStyles: [ImageStyle: AnyCustomImageStyle] {
            get { self[CustomImageStylesKey.self] }
            set {
                self[CustomImageStylesKey.self]
                    .merge(newValue) { _, b in b }
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct CustomImageStylesKey: EnvironmentKey {
        static let defaultValue: [ImageStyle: AnyCustomImageStyle] = [:]
    }

#endif
