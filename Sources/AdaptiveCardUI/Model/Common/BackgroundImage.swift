import DefaultCodable
import Foundation

/// Specifies a background image.
public struct BackgroundImage: Codable, Equatable {
    /// The URL (or data url) of the image.
    public var url: URL

    /// Describes how the image should fill the area.
    public var fillMode: ImageFillMode

    /// Describes how the image should be aligned if it must be cropped or if using repeat fill mode.
    public var horizontalAlignment: HAlignment

    /// Describes how the image should be aligned if it must be cropped or if using repeat fill mode.
    public var verticalAlignment: VAlignment

    public init(
        url: URL,
        fillMode: ImageFillMode = .cover,
        horizontalAlignment: HAlignment = .left,
        verticalAlignment: VAlignment = .top
    ) {
        self.url = url
        self.fillMode = fillMode
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
    }

    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()

        if let url = try? singleValueContainer.decode(URL.self) {
            self.init(url: url)
        } else {
            try self.init(PrimitiveBackgroundImage(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        try PrimitiveBackgroundImage(self).encode(to: encoder)
    }

    private init(_ primitiveValue: PrimitiveBackgroundImage) {
        url = primitiveValue.url
        fillMode = primitiveValue.fillMode
        horizontalAlignment = primitiveValue.horizontalAlignment
        verticalAlignment = primitiveValue.verticalAlignment
    }
}

private struct PrimitiveBackgroundImage: Codable {
    var url: URL
    @Default<FirstCase> var fillMode: ImageFillMode
    @Default<FirstCase> var horizontalAlignment: HAlignment
    @Default<FirstCase> var verticalAlignment: VAlignment

    init(_ value: BackgroundImage) {
        url = value.url
        fillMode = value.fillMode
        horizontalAlignment = value.horizontalAlignment
        verticalAlignment = value.verticalAlignment
    }
}
