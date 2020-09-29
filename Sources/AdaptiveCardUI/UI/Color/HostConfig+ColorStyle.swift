#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension HostConfig: ContainerColorStyle {
        public func backgroundColor(for containerStyle: ContainerStyle) -> Color? {
            let containerStyleConfig = containerStyles[containerStyle]
            let hexColor = containerStyleConfig.backgroundColor

            return Color(argbHex: hexColor)
        }

        public func textColor(_ textColor: TextColor, isSubtle: Bool, for containerStyle: ContainerStyle) -> Color? {
            let containerStyleConfig = containerStyles[containerStyle]
            let hexColor = containerStyleConfig.foregroundColors[textColor, isSubtle]

            return Color(argbHex: hexColor)
        }
    }

#endif
