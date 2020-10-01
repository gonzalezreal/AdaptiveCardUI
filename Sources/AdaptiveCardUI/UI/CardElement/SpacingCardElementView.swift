#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct SpacingCardElementView: View {
        @Environment(\.spacingConfiguration) private var spacingConfiguration

        private let cardElement: CardElement

        init(_ cardElement: CardElement) {
            self.cardElement = cardElement
        }

        var body: some View {
            VStack(spacing: 0) {
                if cardElement.separator {
                    Divider()
                        .padding(.vertical, spacingConfiguration[cardElement.spacing] * 0.5)
                    CardElementView(cardElement)
                } else {
                    CardElementView(cardElement)
                        .padding(.top, spacingConfiguration[cardElement.spacing])
                }
            }
        }
    }

#endif
