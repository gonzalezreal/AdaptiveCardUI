#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct CardElementList: View {
        private let items: [CardElement]
        private let padding: CGFloat

        private var paddedItems: [Padded<CardElement>] {
            let visibleItems = items.filter { $0.isVisible }

            return visibleItems
                .enumerated()
                .map { offset, item in
                    var edges: Edge.Set = [.horizontal]

                    if offset == 0 {
                        edges.update(with: .top)
                    }

                    if offset == visibleItems.count - 1 {
                        edges.update(with: .bottom)
                    }

                    return Padded(
                        item: item,
                        edges: edges,
                        length: item.bleed ? 0 : padding
                    )
                }
        }

        init(_ items: [CardElement], padding: CGFloat) {
            self.items = items
            self.padding = padding
        }

        var body: some View {
            let items = self.paddedItems

            return VStack(spacing: 0) {
                if items.count > 0 {
                    if let first = items.first {
                        CardElementView(first.item)
                            .padding(first.edges, first.length)
                            .transition(.scale)
                    }

                    ForEach(items.dropFirst()) {
                        SpacingCardElementView($0.item)
                            .padding($0.edges, $0.length)
                            .transition(.scale)
                    }
                } else {
                    HStack {
                        Spacer()
                    }
                }
            }
        }
    }

    private extension CardElement {
        var bleed: Bool {
            switch self {
            case .textBlock, .image, .richTextBlock, .actionSet, .factSet, .custom:
                return false
            case let .container(element):
                return element.bleed
            case let .columnSet(element):
                return element.bleed
            case .unknown:
                return false
            }
        }
    }

#endif
