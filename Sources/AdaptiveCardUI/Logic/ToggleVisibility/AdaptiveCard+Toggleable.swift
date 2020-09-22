import Foundation

extension AdaptiveCard {
    mutating func toggleVisibility(of targetElements: [TargetElement]) {
        for target in targetElements {
            body.toggleVisibility(of: target)
        }
    }
}
