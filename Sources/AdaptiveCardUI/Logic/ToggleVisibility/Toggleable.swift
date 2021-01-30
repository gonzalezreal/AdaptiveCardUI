import AdaptiveCard
import Foundation

protocol Toggleable {
    mutating func toggleVisibility(of target: TargetElement) -> Bool
}

extension Array where Element: Toggleable {
    @discardableResult mutating func toggleVisibility(of target: TargetElement) -> Bool {
        for index in indices {
            if self[index].toggleVisibility(of: target) {
                return true
            }
        }

        return false
    }
}
