import Foundation

extension ColumnSetElement: Toggleable {
    mutating func toggleVisibility(of target: TargetElement) -> Bool {
        guard case var .column(column) = self else {
            return false
        }

        var visibilityChanged = false

        if column.id == target.elementId {
            if let isVisible = target.isVisible {
                column.isVisible = isVisible
            } else {
                column.isVisible.toggle()
            }
            visibilityChanged = true
        } else {
            visibilityChanged = column.items.toggleVisibility(of: target)
        }

        if visibilityChanged {
            self = .column(column)
        }

        return visibilityChanged
    }
}
