import Foundation

protocol FeatureAdaptable {
    func adaptingToFeatures(_ features: [String: SemanticVersion], shouldFallback: inout Bool) -> Self?
}
