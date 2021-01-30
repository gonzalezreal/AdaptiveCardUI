import AdaptiveCard
import Foundation

extension AdaptiveCard {
    func adaptingToFeatures(_ features: [String: SemanticVersion]) -> AdaptiveCard {
        var result = self
        var shouldFallback = false

        result.body = body.compactMap { element in
            element.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }
        result.actions = actions.compactMap { action in
            action.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }

        return result
    }
}
