import AdaptiveCard
import Foundation

extension Fallback where Element: FeatureAdaptable {
    func adaptingToFeatures(_ features: [String: SemanticVersion], shouldFallback: inout Bool) -> Element? {
        switch self {
        case .none:
            shouldFallback = true
            return nil
        case .drop:
            return nil
        case let .element(element):
            return element.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }
    }
}
