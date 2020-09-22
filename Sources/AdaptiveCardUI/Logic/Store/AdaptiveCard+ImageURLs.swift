import Foundation

extension AdaptiveCard {
    var imageURLs: Set<URL> {
        Set(_imageURLs)
    }
}

private extension AdaptiveCard {
    var _imageURLs: [URL] {
        body.flatMap(\.imageURLs) +
            actions.flatMap(\.imageURLs) +
            [backgroundImage?.url].compactMap { $0 }
    }
}

private extension CardElement {
    var imageURLs: [URL] {
        switch self {
        case .textBlock, .richTextBlock, .factSet, .custom, .unknown:
            return []
        case let .image(image):
            return [image.url]
        case let .actionSet(actionSet):
            return actionSet.actions.flatMap(\.imageURLs)
        case let .container(container):
            return container.items.flatMap(\.imageURLs) +
                [container.backgroundImage?.url].compactMap { $0 }
        case let .columnSet(columnSet):
            return columnSet.columns.flatMap(\.imageURLs)
        }
    }
}

private extension Action {
    var imageURLs: [URL] {
        switch self {
        case let .showCard(action):
            return [action.iconURL].compactMap { $0 } + action.card._imageURLs
        case let .openURL(action):
            return [action.iconURL].compactMap { $0 }
        case let .submit(action):
            return [action.iconURL].compactMap { $0 }
        case let .toggleVisibility(action):
            return [action.iconURL].compactMap { $0 }
        case .unknown:
            return []
        }
    }
}

private extension ColumnSetElement {
    var imageURLs: [URL] {
        switch self {
        case let .column(column):
            return column.items.flatMap(\.imageURLs) +
                [column.backgroundImage?.url].compactMap { $0 }
        case .unknown:
            return []
        }
    }
}
