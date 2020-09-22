// swiftformat:options --self insert

import Foundation

extension ColumnSetElement: FeatureAdaptable {
    func adaptingToFeatures(_ features: [String: SemanticVersion], shouldFallback: inout Bool) -> ColumnSetElement? {
        guard features.satisfies(self.requires) else {
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }

        switch self {
        case var .column(column):
            var elementShouldFallback = false
            column.items = column.items.compactMap { item in
                item.adaptingToFeatures(features, shouldFallback: &elementShouldFallback)
            }
            if elementShouldFallback {
                return column.fallback.adaptingToFeatures(
                    features,
                    shouldFallback: &shouldFallback
                ) ?? .column(column)
            } else {
                return .column(column)
            }
        case .unknown:
            return self.fallback.adaptingToFeatures(features, shouldFallback: &shouldFallback)
        }
    }
}
