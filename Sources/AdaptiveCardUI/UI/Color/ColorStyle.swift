#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public protocol ColorStyle {
        func backgroundColor(for containerStyle: ContainerStyle) -> Color?
        func textColor(_ textColor: TextColor, isSubtle: Bool, for containerStyle: ContainerStyle) -> Color?
    }

#endif
