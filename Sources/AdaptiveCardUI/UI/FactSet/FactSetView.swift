#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct FactSetView: View {
        @Environment(\.locale) private var locale
        @Environment(\.containerStyle) private var containerStyle
        @Environment(\.factSetConfiguration) private var factSetConfiguration
        @Environment(\.fontTypeConfiguration) private var fontTypeConfiguration
        @Environment(\.containerStyleConfiguration) private var containerStyleConfiguration

        @State private var titleWidth: CGFloat?

        private let factSet: FactSet

        init(_ factSet: FactSet) {
            self.factSet = factSet
        }

        var body: some View {
            VStack(alignment: .leading) {
                ForEach(factSet.facts.indices) { row in
                    HStack(alignment: .top, spacing: factSetConfiguration.spacing) {
                        text(factSet.facts[row].title, configuration: factSetConfiguration.title)
                            .collectSize(tag: FactRow(row))
                            .frame(width: titleWidth)
                            .fixedSize(horizontal: true, vertical: false)
                        text(factSet.facts[row].value, configuration: factSetConfiguration.value)
                    }
                }
            }
            .onCollectedSizesChange(perform: computeTitleWidth)
        }

        private func text(_ value: String, configuration: TextBlockConfiguration) -> some View {
            Text(parsing: value, locale: locale)
                .font(fontTypeConfiguration.default[configuration.size])
                .fontWeight(Font.Weight(configuration.weight))
                .foregroundColor(containerStyleConfiguration[containerStyle].textColors[configuration.color, configuration.isSubtle])
                .lineLimit(configuration.wrap ? nil : 1)
                .frame(maxWidth: configuration.maxWidth ?? .infinity, alignment: .topLeading)
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
