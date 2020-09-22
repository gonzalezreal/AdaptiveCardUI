#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct CollectSizeModifier<Tag: Hashable>: ViewModifier {
        private let tag: Tag

        init(_ tag: Tag) {
            self.tag = tag
        }

        func body(content: Content) -> some View {
            content.background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: CollectSizePreference<Tag>.self,
                        value: [tag: proxy.size]
                    )
                }
            )
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct CollectSizePreference<Tag: Hashable>: PreferenceKey {
        static var defaultValue: [Tag: CGSize] {
            [:]
        }

        static func reduce(
            value: inout [Tag: CGSize],
            nextValue: () -> [Tag: CGSize]
        ) {
            value.merge(nextValue(), uniquingKeysWith: { $1 })
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension View {
        func collectSize<Tag: Hashable>(tag: Tag) -> some View {
            modifier(CollectSizeModifier(tag))
        }

        func onCollectedSizesChange<Tag: Hashable>(perform action: @escaping ([Tag: CGSize]) -> Void) -> some View {
            onPreferenceChange(CollectSizePreference<Tag>.self, perform: action)
        }
    }

#endif
