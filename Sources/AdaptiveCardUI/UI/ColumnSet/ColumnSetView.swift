#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ColumnSetView: View {
        @Environment(\.spacingStyle) private var spacingStyle
        @Environment(\.containerColorStyle) private var containerColorStyle
        @Environment(\.containerStyle) private var parentContainerStyle
        @State private var stretchColumnWidths: [String: CGFloat] = [:]
        @State private var height: CGFloat?

        private let columnSet: ColumnSet

        init(_ columnSet: ColumnSet) {
            self.columnSet = columnSet
        }

        var body: some View {
            GeometryReader { proxy in
                makeBody(for: proxy.size)
            }
            .frame(height: height)
            .containerStyle(columnSet.style)
            .background(backgroundColor)
            .selectAction(columnSet.selectAction)
        }

        private func makeBody(for proposedSize: CGSize) -> some View {
            let items = paddedItems

            return HStack(spacing: 0) {
                if let first = items.first {
                    ColumnView(
                        column: first.item,
                        minWidth: stretchColumnWidths[first.item.id],
                        height: columnHeight(bleed: first.item.bleed)
                    )
                    .padding(first.edges, first.length)
                }

                ForEach(items.dropFirst()) { paddedItem in
                    SpacingColumnView(
                        column: paddedItem.item,
                        minWidth: stretchColumnWidths[paddedItem.item.id],
                        height: columnHeight(bleed: paddedItem.item.bleed)
                    )
                    .padding(paddedItem.edges, paddedItem.length)
                }
            }
            .onCollectedSizesChange {
                computeColumnLayout(width: proposedSize.width, collectedSizes: $0)
            }
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    private extension ColumnSetView {
        var padding: CGFloat {
            switch (columnSet.style, parentContainerStyle) {
            case (.none, _), (ContainerStyle.default, ContainerStyle.default):
                return 0
            case (.some, _):
                return spacingStyle.padding
            }
        }

        var paddedItems: [Padded<Column>] {
            let visibleColumns = columnSet.visibleColumns
            let padding = self.padding

            return visibleColumns
                .enumerated()
                .map { offset, column in
                    var edges: Edge.Set = [.vertical]

                    if offset == 0 {
                        edges.update(with: .leading)
                    }

                    if offset == visibleColumns.count - 1 {
                        edges.update(with: .trailing)
                    }

                    return Padded(
                        item: column,
                        edges: edges,
                        length: column.bleed ? 0 : padding
                    )
                }
        }

        var minHeight: CGFloat {
            guard let minHeight = columnSet.minHeight?.cgFloatValue else {
                return 0
            }
            return minHeight - (2 * padding)
        }

        var backgroundColor: Color? {
            columnSet.style.flatMap {
                containerColorStyle.backgroundColor(for: $0)
            }
        }

        func columnHeight(bleed: Bool) -> CGFloat? {
            guard let height = self.height else {
                return nil
            }
            return bleed ? height : height - (2 * padding)
        }

        func computeColumnLayout(width: CGFloat, collectedSizes sizes: [String: CGSize]) {
            guard !sizes.isEmpty else {
                return
            }
            computeStretchColumnWidths(width: width, collectedSizes: sizes)
            computeHeight(collectedSizes: sizes)
        }

        func computeHeight(collectedSizes sizes: [String: CGSize]) {
            let minHeight = self.minHeight
            var height: CGFloat = 0

            for column in columnSet.visibleColumns {
                let columnMinHeight = column.minHeight?.cgFloatValue ?? 0
                let collectedHeight = sizes[column.id]?.height ?? 0
                let columnHeight = max(max(minHeight, columnMinHeight), collectedHeight)

                height = max(height, columnHeight)
            }

            self.height = height + (2 * padding)
        }

        func computeStretchColumnWidths(width: CGFloat, collectedSizes sizes: [String: CGSize]) {
            let availableWidth = availableWidthForStretchColumns(width: width, collectedSizes: sizes)
            let sumOfWeights = columnSet.visibleColumns
                .compactMap(\.weight)
                .reduce(0, +)

            for column in columnSet.visibleColumns {
                if let weight = column.weight {
                    stretchColumnWidths[column.id] = weight * (availableWidth / sumOfWeights)
                }
            }
        }

        func availableWidthForStretchColumns(width: CGFloat, collectedSizes sizes: [String: CGSize]) -> CGFloat {
            var remainingWidth = width - (2 * padding)

            for (offset, column) in columnSet.visibleColumns.enumerated() {
                if offset > 0 {
                    remainingWidth -= spacingStyle[column.spacing]
                }

                switch column.width {
                case .auto:
                    remainingWidth -= sizes[column.id]?.width ?? 0
                case let .pixels(value):
                    remainingWidth -= CGFloat(value)
                default:
                    continue
                }
            }

            return max(remainingWidth, 0)
        }
    }

    private extension ColumnSet {
        var visibleColumns: [Column] {
            columns.compactMap(\.column).filter { $0.isVisible }
        }
    }

    private extension ColumnSetElement {
        var column: Column? {
            guard case let .column(column) = self else { return nil }
            return column
        }
    }

    private extension Column {
        var weight: CGFloat? {
            switch width {
            case .stretch:
                return 1
            case let .weight(value):
                return CGFloat(value)
            default:
                return nil
            }
        }
    }

#endif
