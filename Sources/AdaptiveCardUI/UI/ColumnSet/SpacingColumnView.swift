#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct SpacingColumnView: View {
        @Environment(\.spacingConfiguration) private var spacingConfiguration

        private let column: Column
        private let minWidth: CGFloat?
        private let height: CGFloat?

        init(column: Column, minWidth: CGFloat?, height: CGFloat?) {
            self.column = column
            self.minWidth = minWidth
            self.height = height
        }

        var body: some View {
            HStack(spacing: 0) {
                if column.separator {
                    Divider()
                        .padding(.horizontal, spacingConfiguration[column.spacing] * 0.5)
                    ColumnView(column: column, minWidth: minWidth, height: height)
                } else {
                    ColumnView(column: column, minWidth: minWidth, height: height)
                        .padding(.leading, spacingConfiguration[column.spacing])
                }
            }
        }
    }

#endif
