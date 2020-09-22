#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public extension View {
        func adaptiveCardConfiguration(_ hostConfig: HostConfig) -> some View {
            actionSetStyle(ActionSetStyle(hostConfig: hostConfig))
                .colorStyle(hostConfig)
                .factStyle(hostConfig)
                .imageSizeStyle(ImageSizeStyle(hostConfig: hostConfig))
                .spacingStyle(SpacingStyle(hostConfig: hostConfig))
                .textStyle(hostConfig)
        }
    }

#endif
