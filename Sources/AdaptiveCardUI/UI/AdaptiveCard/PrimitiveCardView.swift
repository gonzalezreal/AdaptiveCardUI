#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct PrimitiveCardView: View {
        @Environment(\.locale) private var locale
        @Environment(\.spacingStyle) private var spacingStyle
        @Environment(\.actionSetStyle) private var actionSetStyle
        @Environment(\.containerStyle) private var containerStyle
        @Environment(\.containerColorStyle) private var containerColorStyle

        private var adaptiveCard: AdaptiveCard

        private var actionSet: CardElement? {
            adaptiveCard.actions.isEmpty
                ? nil
                : .actionSet(
                    ActionSet(
                        id: "AdaptiveCardActions",
                        spacing: actionSetStyle.spacing,
                        actions: adaptiveCard.actions
                    )
                )
        }

        private var cardElements: [CardElement] {
            adaptiveCard.body + [actionSet].compactMap { $0 }
        }

        init(_ adaptiveCard: AdaptiveCard) {
            self.adaptiveCard = adaptiveCard
        }

        var body: some View {
            VStack(spacing: 0) {
                CardElementList(cardElements, padding: spacingStyle.padding)
            }
            .frame(minHeight: adaptiveCard.minHeight?.cgFloatValue, alignment: .top)
            .backgroundImage(adaptiveCard.backgroundImage)
            .background(containerColorStyle.backgroundColor(for: containerStyle))
            .selectAction(adaptiveCard.selectAction)
            .environment(\.locale, locale.updatingLanguageCode(adaptiveCard.lang))
        }
    }

    private extension Locale {
        func updatingLanguageCode(_ languageCode: String?) -> Locale {
            guard let languageCode = languageCode, !languageCode.isEmpty else {
                return self
            }

            let regionCode = self.regionCode ?? ""

            return Locale(identifier: "\(languageCode)_\(regionCode)")
        }
    }

#endif
