#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct ContentSizeKey: PreferenceKey {
        static let defaultValue: CGSize? = nil

        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }

#endif
