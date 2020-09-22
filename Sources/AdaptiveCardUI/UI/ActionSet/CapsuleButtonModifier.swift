#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct CapsuleButtonModifier: ViewModifier {
        private enum Defaults {
            static let contentInsets = EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
            static let minHeight: CGFloat = 30
            static let pressedOpacity = 0.8
        }

        @Environment(\.actionSetStyle) private var actionSetStyle

        private let isPressed: Bool

        init(isPressed: Bool) {
            self.isPressed = isPressed
        }

        func body(content: Content) -> some View {
            content
                .textCase(.uppercase)
                .font(Font.caption.weight(.semibold))
                .foregroundColor(.white)
                .padding(Defaults.contentInsets)
                .frame(
                    maxWidth: actionSetStyle.maxButtonWidth,
                    minHeight: Defaults.minHeight
                )
                .background(
                    Capsule().foregroundColor(.accentColor)
                )
                .opacity(isPressed ? Defaults.pressedOpacity : 1)
        }
    }

#endif
