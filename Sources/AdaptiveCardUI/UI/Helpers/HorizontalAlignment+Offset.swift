#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension HorizontalAlignment {
        func offset(for proposedSize: CGSize, contentSize: CGSize) -> CGSize {
            switch self {
            case .center:
                return CGSize(width: (proposedSize.width - contentSize.width) * 0.5, height: 0)
            case .right:
                return CGSize(width: proposedSize.width - contentSize.width, height: 0)
            default:
                return .zero
            }
        }
    }

#endif
