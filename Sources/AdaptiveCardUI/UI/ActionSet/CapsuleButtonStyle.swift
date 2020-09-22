#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    public struct CapsuleButtonStyle: ButtonStyle {
        public init() {}

        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .modifier(CapsuleButtonModifier(isPressed: configuration.isPressed))
        }
    }

#endif
