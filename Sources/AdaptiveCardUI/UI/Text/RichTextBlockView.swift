#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct RichTextBlockView: View {
        @Environment(\.locale) private var locale
        @Environment(\.fontTypeConfiguration) private var fontTypeConfiguration
        @Environment(\.containerStyleConfiguration) private var containerStyleConfiguration
        @Environment(\.containerStyle) private var containerStyle

        private let richTextBlock: RichTextBlock

        init(_ richTextBlock: RichTextBlock) {
            self.richTextBlock = richTextBlock
        }

        var body: some View {
            HAlign(richTextBlock.horizontalAlignment) {
                richTextBlock.inlines.map {
                    text(for: $0)
                }
                .joined()
                .multilineTextAlignment(TextAlignment(richTextBlock.horizontalAlignment))
                .fixedSize(horizontal: false, vertical: true)
            }
        }

        private func text(for textRun: TextRun) -> Text {
            let result = Text(parsing: textRun.text, locale: locale)
                .font(fontTypeConfiguration[textRun.fontType][textRun.size])
                .fontWeight(Font.Weight(textRun.weight))
                .foregroundColor(
                    containerStyleConfiguration[containerStyle].textColors[textRun.color, textRun.isSubtle]
                )
                .strikethrough(textRun.strikethrough)

            return textRun.italic ? result.italic() : result
        }
    }

#endif
