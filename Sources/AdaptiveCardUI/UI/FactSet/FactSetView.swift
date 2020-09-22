#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct FactSetView: View {
        @Environment(\.locale) private var locale
        @Environment(\.containerStyle) private var parentStyle
        @Environment(\.factStyle) private var factStyle
        @State private var titleWidth: CGFloat?

        private let factSet: FactSet

        init(_ factSet: FactSet) {
            self.factSet = factSet
        }

        var body: some View {
            VStack(alignment: .leading) {
                ForEach(factSet.facts.indices) { row in
                    HStack(alignment: .top, spacing: factStyle.titleValueSpacing) {
                        text(factSet.facts[row].title, attributes: factStyle.titleAttributes(for: parentStyle))
                            .collectSize(tag: FactRow(row))
                            .frame(width: titleWidth)
                            .fixedSize(horizontal: true, vertical: false)
                        text(factSet.facts[row].value, attributes: factStyle.valueAttributes(for: parentStyle))
                    }
                }
            }
            .onCollectedSizesChange(perform: computeTitleWidth)
        }

        private func text(_ value: String, attributes: TextAttributes) -> some View {
            Text(parsing: value, locale: locale)
                .font(attributes.font)
                .fontWeight(attributes.weight)
                .foregroundColor(attributes.textColor)
                .lineLimit(attributes.wrap ? nil : 1)
                .frame(maxWidth: attributes.maxWidth ?? .infinity, alignment: .topLeading)
        }

        private func computeTitleWidth(sizes: [FactRow: CGSize]) {
            var maxWidth: CGFloat = 0

            for key in factSet.facts.indices.map(FactRow.init) {
                let width = sizes[key]?.width ?? 0
                if width > maxWidth {
                    maxWidth = width
                }
            }

            titleWidth = maxWidth
        }
    }

    private struct FactRow: Hashable {
        let value: Int

        init(_ value: Int) {
            self.value = value
        }
    }

#endif
