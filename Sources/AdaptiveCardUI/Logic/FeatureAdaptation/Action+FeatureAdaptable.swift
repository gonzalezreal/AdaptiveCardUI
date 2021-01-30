// swiftformat:options --self insert

import AdaptiveCard
import Foundation

extension Action: FeatureAdaptable {
    func adaptingToFeatures(_ features: [String: SemanticVersion], shouldFallback: inout Bool) -> Action? {
        guard features.satisfies(self.requires) else {
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }

        switch self {
        case .openURL, .submit, .toggleVisibility:
            return self
        case var .showCard(action):
            action.card = action.card.adaptingToFeatures(features)
            return .showCard(action)
        case .unknown:
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }
    }
}
