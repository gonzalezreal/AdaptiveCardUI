import Foundation

/// An element inside an Adaptive Card.
@dynamicMemberLookup
public indirect enum CardElement {
    /// A text element.
    case textBlock(TextBlock)

    /// An image element.
    case image(Image)

    /// A rich text element.
    case richTextBlock(RichTextBlock)

    /// A set of actions.
    case actionSet(ActionSet)

    /// A collection of elements.
    case container(Container)

    /// Divides a region into columns, allowing elements to sit side-by-side.
    case columnSet(ColumnSet)

    /// A series of facts (i.e. name / value pairs) in a tabular form.
    case factSet(FactSet)

    /// A collection of images.
    case imageSet(ImageSet)

    /// A custom card element.
    case custom(CustomCardElement)

    /// An unknown card element. Unknown card elements are discarded or replaced
    /// by their `fallback`, in case one is provided.
    case unknown(UnknownCardElement)
}

extension CardElement: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case String(describing: TextBlock.self):
            self = .textBlock(try TextBlock(from: decoder))
        case String(describing: Image.self):
            self = .image(try Image(from: decoder))
        case String(describing: RichTextBlock.self):
            self = .richTextBlock(try RichTextBlock(from: decoder))
        case String(describing: ActionSet.self):
            self = .actionSet(try ActionSet(from: decoder))
        case String(describing: Container.self):
            self = .container(try Container(from: decoder))
        case String(describing: ColumnSet.self):
            self = .columnSet(try ColumnSet(from: decoder))
        case String(describing: FactSet.self):
            self = .factSet(try FactSet(from: decoder))
        case String(describing: ImageSet.self):
            self = .imageSet(try ImageSet(from: decoder))
        default:
            if let decodeCustomCardElement = Self.customCardElementDecoders[type] {
                self = .custom(try decodeCustomCardElement(decoder))
            } else {
                self = .unknown(try UnknownCardElement(from: decoder))
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .textBlock(element):
            try container.encode(String(describing: TextBlock.self), forKey: .type)
            try element.encode(to: encoder)
        case let .image(element):
            try container.encode(String(describing: Image.self), forKey: .type)
            try element.encode(to: encoder)
        case let .richTextBlock(element):
            try container.encode(String(describing: RichTextBlock.self), forKey: .type)
            try element.encode(to: encoder)
        case let .actionSet(element):
            try container.encode(String(describing: ActionSet.self), forKey: .type)
            try element.encode(to: encoder)
        case let .container(element):
            try container.encode(String(describing: Container.self), forKey: .type)
            try element.encode(to: encoder)
        case let .columnSet(element):
            try container.encode(String(describing: ColumnSet.self), forKey: .type)
            try element.encode(to: encoder)
        case let .factSet(element):
            try container.encode(String(describing: FactSet.self), forKey: .type)
            try element.encode(to: encoder)
        case let .imageSet(element):
            try container.encode(String(describing: ImageSet.self), forKey: .type)
            try element.encode(to: encoder)
        case let .custom(element):
            let typeName = type(of: element).typeName
            guard let encodeCustomCardElement = Self.customCardElementEncoders[typeName] else {
                let context = EncodingError.Context(
                    codingPath: encoder.codingPath,
                    debugDescription: "Unsupported custom card element '\(typeName)'"
                )
                throw EncodingError.invalidValue(element, context)
            }

            try container.encode(typeName, forKey: .type)
            try encodeCustomCardElement(element, encoder)

        case .unknown:
            break // do nothing
        }
    }
}

public extension CardElement {
    subscript<T>(dynamicMember keyPath: KeyPath<CardElementProtocol, T>) -> T {
        switch self {
        case let .textBlock(element):
            return element[keyPath: keyPath]
        case let .image(element):
            return element[keyPath: keyPath]
        case let .richTextBlock(element):
            return element[keyPath: keyPath]
        case let .actionSet(element):
            return element[keyPath: keyPath]
        case let .container(element):
            return element[keyPath: keyPath]
        case let .columnSet(element):
            return element[keyPath: keyPath]
        case let .factSet(element):
            return element[keyPath: keyPath]
        case let .imageSet(element):
            return element[keyPath: keyPath]
        case let .custom(element):
            return element[keyPath: keyPath]
        case let .unknown(element):
            return element[keyPath: keyPath]
        }
    }
}

extension CardElement: Identifiable {
    public var id: String {
        self[dynamicMember: \.id]
    }
}

public extension CardElement {
    static func register<Element>(_ type: Element.Type) where Element: Equatable, Element: Codable, Element: CustomCardElement {
        customCardElementDecoders[type.typeName] = { decoder in
            try Element(from: decoder)
        }
        customCardElementEncoders[type.typeName] = { value, encoder in
            try (value as! Element).encode(to: encoder)
        }
        customCardElementIsEqual[type.typeName] = { lhs, rhs in
            guard let l = lhs as? Element, let r = rhs as? Element else {
                return false
            }
            return l == r
        }
    }
}

extension CardElement: Equatable {
    public static func == (lhs: CardElement, rhs: CardElement) -> Bool {
        switch (lhs, rhs) {
        case let (.textBlock(l), .textBlock(r)):
            return l == r
        case let (.image(l), .image(r)):
            return l == r
        case let (.richTextBlock(l), .richTextBlock(r)):
            return l == r
        case let (.actionSet(l), .actionSet(r)):
            return l == r
        case let (.container(l), .container(r)):
            return l == r
        case let (.columnSet(l), .columnSet(r)):
            return l == r
        case let (.factSet(l), .factSet(r)):
            return l == r
        case let (.imageSet(l), .imageSet(r)):
            return l == r
        case let (.custom(l), .custom(r)):
            let typeName = type(of: l).typeName
            return Self.customCardElementIsEqual[typeName]?(l, r) ?? false
        case let (.unknown(l), .unknown(r)):
            return l == r
        default:
            return false
        }
    }
}

private extension CardElement {
    typealias CustomCardElementDecoder = (Decoder) throws -> CustomCardElement
    typealias CustomCardElementEncoder = (CustomCardElement, Encoder) throws -> Void
    typealias CustomCardElementEquatable = (CustomCardElement, CustomCardElement) -> Bool

    static var customCardElementDecoders: [String: CustomCardElementDecoder] = [:]
    static var customCardElementEncoders: [String: CustomCardElementEncoder] = [:]
    static var customCardElementIsEqual: [String: CustomCardElementEquatable] = [:]
}
