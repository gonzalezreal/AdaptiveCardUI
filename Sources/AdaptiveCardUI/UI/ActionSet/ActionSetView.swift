#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ActionSetView: View {
        @Environment(\.actionSetStyle) private var actionSetStyle
        @State private var cardIndex: Int?

        private let actions: [Action]

        init(_ actionSet: ActionSet) {
            self.init(actions: actionSet.actions)
        }

        init(actions: [Action]) {
            self.actions = actions
        }

        var body: some View {
            let actionViews = self.actionViews

            return VStack(spacing: 0) {
                Group {
                    switch actionSetStyle.orientation {
                    case .horizontal:
                        HAlign(actionSetStyle.alignment) {
                            HStack(spacing: actionSetStyle.buttonSpacing) {
                                ForEach(actionViews.indices) { index in
                                    actionViews[index]
                                }
                            }
                        }
                    case .vertical:
                        VStack(spacing: actionSetStyle.buttonSpacing) {
                            ForEach(actionViews.indices) { index in
                                HAlign(actionSetStyle.alignment) {
                                    actionViews[index]
                                }
                            }
                        }
                    }
                }
                cardView
                    .padding(.top, actionSetStyle.cardTopMargin)
            }
        }

        private var actionViews: [ActionView] {
            actions.prefix(actionSetStyle.maxActions)
                .enumerated()
                .map { offset, action in
                    ActionView(action, tag: offset, selection: $cardIndex)
                }
        }

        private var cardView: some View {
            cardIndex.flatMap { index in
                actions[index].card.map { adaptiveCard in
                    PrimitiveCardView(adaptiveCard)
                        .containerStyle(actionSetStyle.cardStyle)
                }
            }
        }
    }

    private extension Action {
        var card: AdaptiveCard? {
            guard case let .showCard(showCardAction) = self else { return nil }
            return showCardAction.card
        }
    }

#endif
