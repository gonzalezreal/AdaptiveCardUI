#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct TextBlockView: View {
        @Environment(\.locale) private var locale
        @Environment(\.fontTypeConfiguration) private var fontTypeConfiguration
        @Environment(\.containerStyleConfiguration) private var containerStyleConfiguration
        @Environment(\.containerStyle) private var containerStyle

        private let textBlock: TextBlock

        init(_ textBlock: TextBlock) {
            self.textBlock = textBlock
        }

        var body: some View {
            HAlign(textBlock.horizontalAlignment) {
                Text(parsing: textBlock.text, locale: locale)
                    .font(fontTypeConfiguration[textBlock.fontType][textBlock.size])
                    .fontWeight(Font.Weight(textBlock.weight))
                    .foregroundColor(
                        containerStyleConfiguration[containerStyle].textColors[textBlock.color, textBlock.isSubtle]
                    )
                    .multilineTextAlignment(TextAlignment(textBlock.horizontalAlignment))
                    .lineLimit(textBlock.wrap ? textBlock.maxLines : 1)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

#endif
