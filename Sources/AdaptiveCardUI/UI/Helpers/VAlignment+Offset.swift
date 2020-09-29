#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension VAlignment {
        func offset(for proposedSize: CGSize, contentSize: CGSize) -> CGSize {
            switch self {
            case .center:
                return CGSize(width: 0, height: (proposedSize.height - contentSize.height) * 0.5)
            case .bottom:
                return CGSize(width: 0, height: proposedSize.height - contentSize.height)
            default:
                return .zero
            }
        }
    }

#endif
