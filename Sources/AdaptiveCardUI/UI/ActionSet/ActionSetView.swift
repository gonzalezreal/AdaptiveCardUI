#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ActionSetView: View {
        @Environment(\.actionSetConfiguration) private var actionSetConfiguration
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
                    switch actionSetConfiguration.actionsOrientation {
                    case .horizontal:
                        HAlign(HAlignment(actionAlignment: actionSetConfiguration.actionAlignment)) {
                            HStack(spacing: actionSetConfiguration.buttonSpacing) {
                                ForEach(actionViews.indices) { index in
                                    actionViews[index]
                                }
                            }
                        }
                    case .vertical:
                        VStack(spacing: actionSetConfiguration.buttonSpacing) {
                            ForEach(actionViews.indices) { index in
                                HAlign(HAlignment(actionAlignment: actionSetConfiguration.actionAlignment)) {
                                    actionViews[index]
                                }
                            }
                        }
                    }
                }
                cardView
                    .padding(.top, actionSetConfiguration.showCard.inlineTopMargin)
            }
        }

        private var actionViews: [ActionView] {
            actions.prefix(actionSetConfiguration.maxActions)
                .enumerated()
                .map { offset, action in
                    ActionView(action, tag: offset, selection: $cardIndex)
                }
        }

        private var cardView: some View {
            cardIndex.flatMap { index in
                actions[index].card.map { adaptiveCard in
                    PrimitiveCardView(adaptiveCard)
                        .containerStyle(actionSetConfiguration.showCard.style)
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

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension HAlignment {
        init?(actionAlignment: ActionSetConfiguration.Alignment) {
            switch actionAlignment {
            case .stretch:
                return nil
            case .left:
                self = .left
            case .center:
                self = .center
            case .right:
                self = .right
            }
        }
    }

#endif
