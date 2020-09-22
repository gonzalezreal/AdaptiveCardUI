import Foundation

extension AdaptiveCard {
    var duplicateIdentifiers: Set<String> {
        Set(
            Dictionary(grouping: identifiers, by: { $0 })
                .filter { $1.count > 1 }
                .keys
        )
    }
}

private extension AdaptiveCard {
    var identifiers: [String] {
        body.flatMap(\.identifiers) + actions.flatMap(\.identifiers)
    }
}

private extension CardElement {
    var identifiers: [String] {
        switch self {
        case .textBlock, .image, .richTextBlock, .factSet, .custom:
            return [id]
        case let .actionSet(actionSet):
            return [actionSet.id] + actionSet.actions.flatMap(\.identifiers)
        case let .container(container):
            return [container.id] + container.items.flatMap(\.identifiers)
        case let .columnSet(columnSet):
            return [columnSet.id] + columnSet.columns.flatMap(\.identifiers)
        case .unknown:
            return []
        }
    }
}

private extension Action {
    var identifiers: [String] {
        switch self {
        case let .showCard(action):
            return action.card.identifiers
        case .openURL, .submit, .toggleVisibility, .unknown:
            return []
        }
    }
}

private extension ColumnSetElement {
    var identifiers: [String] {
        switch self {
        case let .column(column):
            return [column.id] + column.items.flatMap(\.identifiers)
        case .unknown:
            return []
        }
    }
}
