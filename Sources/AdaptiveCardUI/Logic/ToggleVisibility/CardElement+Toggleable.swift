import AdaptiveCard
import Foundation

extension CardElement: Toggleable {
    mutating func toggleVisibility(of target: TargetElement) -> Bool {
        if id == target.elementId {
            toggleVisibility(target.isVisible)
            return true
        } else {
            switch self {
            case var .container(container):
                if container.items.toggleVisibility(of: target) {
                    self = .container(container)
                    return true
                } else {
                    return false
                }
            case var .columnSet(columnSet):
                if columnSet.columns.toggleVisibility(of: target) {
                    self = .columnSet(columnSet)
                    return true
                } else {
                    return false
                }
            case var .imageSet(imageSet):
                if imageSet.images.toggleVisibility(of: target) {
                    self = .imageSet(imageSet)
                    return true
                } else {
                    return false
                }
            case .textBlock, .image, .richTextBlock, .actionSet, .factSet, .custom, .unknown:
                return false
            }
        }
    }
}

private extension CardElement {
    mutating func toggleVisibility(_ isVisible: Bool?) {
        switch self {
        case var .textBlock(element):
            element.toggleVisibility(isVisible)
            self = .textBlock(element)
        case var .image(element):
            element.toggleVisibility(isVisible)
            self = .image(element)
        case var .richTextBlock(element):
            element.toggleVisibility(isVisible)
            self = .richTextBlock(element)
        case var .actionSet(element):
            element.toggleVisibility(isVisible)
            self = .actionSet(element)
        case var .container(element):
            element.toggleVisibility(isVisible)
            self = .container(element)
        case var .columnSet(element):
            element.toggleVisibility(isVisible)
            self = .columnSet(element)
        case var .factSet(element):
            element.toggleVisibility(isVisible)
            self = .factSet(element)
        case var .imageSet(element):
            element.toggleVisibility(isVisible)
            self = .imageSet(element)
        case var .custom(element):
            element.toggleVisibility(isVisible)
            self = .custom(element)
        case .unknown:
            break // do nothing
        }
    }
}

private extension CardElementProtocol {
    mutating func toggleVisibility(_ isVisible: Bool?) {
        if let isVisible = isVisible {
            self.isVisible = isVisible
        } else {
            self.isVisible.toggle()
        }
    }
}
