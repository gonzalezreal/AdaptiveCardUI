#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension View {
        /// Sets the renderer configuration values for adaptive cards within this view.
        func adaptiveCardConfiguration(_ hostConfig: HostConfig) -> some View {
            actionSetStyle(ActionSetStyle(hostConfig: hostConfig))
                .containerColorStyle(hostConfig)
                .factStyle(hostConfig)
                .imageSizeStyle(ImageSizeStyle(hostConfig: hostConfig))
                .spacingStyle(SpacingStyle(hostConfig: hostConfig))
                .textStyle(hostConfig)
        }
    }

#endif
