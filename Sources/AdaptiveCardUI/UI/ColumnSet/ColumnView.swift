#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ColumnView: View {
        @Environment(\.spacingStyle) private var spacingStyle
        @Environment(\.colorStyle) private var colorStyle
        @Environment(\.containerStyle) private var parentContainerStyle

        private let column: Column
        private let minWidth: CGFloat?
        private let height: CGFloat?

        init(column: Column, minWidth: CGFloat?, height: CGFloat?) {
            self.column = column
            self.minWidth = minWidth
            self.height = height
        }

        var body: some View {
            CardElementList(column.items, padding: padding)
                // Make sure auto width columns are fixed to its ideal width
                .fixedSize(horizontal: column.width == .auto, vertical: false)
                .collectSize(tag: column.id)
                .frame(
                    width: column.pixelWidth, // for pixel width columns, use the specified width
                    height: height, // height is determined by the parent view
                    alignment: Alignment(column.verticalContentAlignment)
                )
                // Stretch columns use the parent computed minWidth and .infinity maxWidth
                .frame(minWidth: minWidth, maxWidth: column.maxWidth)
                .layoutPriority(column.layoutPriority)
                .containerStyle(column.style)
                .backgroundImage(column.backgroundImage)
                .background(backgroundColor)
                .selectAction(column.selectAction)
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    private extension ColumnView {
        var padding: CGFloat {
            if column.backgroundImage != nil {
                return spacingStyle.padding
            } else {
                switch (column.style, parentContainerStyle) {
                case (.none, _), (ContainerStyle.default, ContainerStyle.default):
                    return 0
                case (.some, _):
                    return spacingStyle.padding
                }
            }
        }

        var backgroundColor: Color? {
            column.style.flatMap {
                colorStyle.backgroundColor(for: $0)
            }
        }
    }

    private extension Column {
        var maxWidth: CGFloat? {
            switch width {
            case .stretch, .weight:
                return .infinity
            default:
                return nil
            }
        }

        var pixelWidth: CGFloat? {
            guard case let .pixels(value) = width else {
                return nil
            }
            return CGFloat(value)
        }

        var layoutPriority: Double {
            switch width {
            case .pixels:
                return 2
            case .auto:
                return 1
            case .stretch, .weight:
                return 0
            }
        }
    }

#endif
