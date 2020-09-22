#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    extension HostConfig: FactStyle {
        public var titleValueSpacing: CGFloat {
            CGFloat(factSet.spacing)
        }

        public func titleAttributes(for containerStyle: ContainerStyle) -> TextAttributes {
            TextAttributes(
                font: font(.default, size: factSet.title.size),
                weight: Font.Weight(factSet.title.weight),
                textColor: textColor(
                    factSet.title.color,
                    isSubtle: factSet.title.isSubtle,
                    for: containerStyle
                ),
                wrap: factSet.title.wrap,
                maxWidth: factSet.title.maxWidth.map(CGFloat.init)
            )
        }

        public func valueAttributes(for containerStyle: ContainerStyle) -> TextAttributes {
            TextAttributes(
                font: font(.default, size: factSet.value.size),
                weight: Font.Weight(factSet.value.weight),
                textColor: textColor(
                    factSet.value.color,
                    isSubtle: factSet.value.isSubtle,
                    for: containerStyle
                ),
                wrap: factSet.value.wrap,
                maxWidth: factSet.value.maxWidth.map(CGFloat.init)
            )
        }
    }

#endif
