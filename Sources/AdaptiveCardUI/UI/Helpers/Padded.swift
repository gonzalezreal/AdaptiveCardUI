#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct Padded<Item> {
        var item: Item
        var edges: Edge.Set
        var length: CGFloat
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension Padded: Identifiable where Item: Identifiable {
        var id: Item.ID {
            item.id
        }
    }

#endif
