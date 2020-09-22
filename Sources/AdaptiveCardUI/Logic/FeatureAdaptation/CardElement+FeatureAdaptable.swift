// swiftformat:options --self insert

import Foundation

extension CardElement: FeatureAdaptable {
    func adaptingToFeatures(_ features: [String: SemanticVersion], shouldFallback: inout Bool) -> CardElement? {
        guard features.satisfies(self.requires) else {
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }

        switch self {
        case .textBlock, .image, .richTextBlock, .factSet, .custom:
            return self
        case var .actionSet(actionSet):
            var elementShouldFallback = false
            actionSet.actions = actionSet.actions.compactMap { action in
                action.adaptingToFeatures(features, shouldFallback: &elementShouldFallback)
            }
            if elementShouldFallback {
                return actionSet.fallback.adaptingToFeatures(
                    features,
                    shouldFallback: &shouldFallback
                ) ?? .actionSet(actionSet)
            } else {
                return .actionSet(actionSet)
            }
        case var .container(container):
            var elementShouldFallback = false
            container.items = container.items.compactMap { item in
                item.adaptingToFeatures(features, shouldFallback: &elementShouldFallback)
            }
            if elementShouldFallback {
                return container.fallback.adaptingToFeatures(
                    features,
                    shouldFallback: &shouldFallback
                ) ?? .container(container)
            } else {
                return .container(container)
            }
        case var .columnSet(columnSet):
            var elementShouldFallback = false
            columnSet.columns = columnSet.columns.compactMap { column in
                column.adaptingToFeatures(features, shouldFallback: &elementShouldFallback)
            }
            if elementShouldFallback {
                return columnSet.fallback.adaptingToFeatures(
                    features,
                    shouldFallback: &shouldFallback
                ) ?? .columnSet(columnSet)
            } else {
                return .columnSet(columnSet)
            }
        case .unknown:
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }
    }
}
