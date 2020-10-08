import Foundation

extension Image: Toggleable {
    mutating func toggleVisibility(of target: TargetElement) -> Bool {
        guard id == target.elementId else { return false }

        if let isVisible = target.isVisible {
            self.isVisible = isVisible
        } else {
            isVisible.toggle()
        }

        return true
    }
}
