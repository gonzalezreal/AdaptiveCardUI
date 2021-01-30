#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct CardElementView: View {
        private let cardElement: CardElement

        init(_ cardElement: CardElement) {
            self.cardElement = cardElement
        }

        var body: some View {
            switch cardElement {
            case let .textBlock(textBlock):
                TextBlockView(textBlock)
            case let .image(imageModel):
                ImageView(imageModel)
            case let .richTextBlock(richTextBlock):
                RichTextBlockView(richTextBlock)
            case let .actionSet(actionSet):
                ActionSetView(actionSet)
            case let .container(container):
                ContainerView(container)
            case let .columnSet(columnSet):
                ColumnSetView(columnSet)
            case let .factSet(factSet):
                FactSetView(factSet)
            case let .imageSet(imageSet):
                ImageSetView(imageSet)
            case let .custom(customCardElement):
                CustomCardElementView(customCardElement)
            default:
                EmptyView()
            }
        }
    }

#endif
