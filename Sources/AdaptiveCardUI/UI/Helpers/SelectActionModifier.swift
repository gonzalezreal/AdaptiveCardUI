#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    private struct SelectActionModifier: ViewModifier {
        @Environment(\.openURL) private var openURL
        @EnvironmentObject private var store: AdaptiveCardStore

        private let action: Action?

        init(_ action: Action?) {
            self.action = action
        }

        @ViewBuilder func body(content: Content) -> some View {
            if let action = self.action {
                Button(
                    action: {
                        perform(action)
                    },
                    label: {
                        content
                    }
                )
                .buttonStyle(PlainButtonStyle())
            } else {
                content
            }
        }

        private func perform(_ action: Action) {
            switch action {
            case let .openURL(openURLAction):
                openURL(openURLAction.url)
            case .showCard:
                // Not supported in select actions
                break
            case .submit:
                // TODO: implement
                break
            case let .toggleVisibility(toggleVisibilityAction):
                store.send(.toggleVisibility(toggleVisibilityAction.targetElements))
            case .unknown:
                // Do nothing
                break
            }
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    extension View {
        func selectAction(_ action: Action?) -> some View {
            modifier(SelectActionModifier(action))
        }
    }

#endif
