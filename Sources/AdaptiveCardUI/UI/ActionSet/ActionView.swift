#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ActionView: View {
        @Environment(\.openURL) private var openURL
        @EnvironmentObject private var store: AdaptiveCardStore

        @Binding private var selection: Int?

        private let action: Action
        private let tag: Int

        init(_ action: Action, tag: Int, selection: Binding<Int?>) {
            self.action = action
            self.tag = tag
            _selection = selection
        }

        var body: some View {
            Button(action.title) {
                switch action {
                case let .openURL(openURLAction):
                    openURL(openURLAction.url)
                case .showCard:
                    withAnimation {
                        if selection != tag {
                            selection = tag
                        } else {
                            selection = nil
                        }
                    }
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
    }

#endif
