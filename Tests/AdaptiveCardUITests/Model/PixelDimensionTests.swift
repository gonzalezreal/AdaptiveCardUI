import AdaptiveCardUI
import XCTest

final class PixelDimensionTests: XCTestCase {
    private struct Model: Codable, Equatable {
        var height: PixelDimension
    }

    func testPixelDimensionDecodeReturnsPixelDimension() throws {
        // given
        let json = """
        {
          "height": "50px"
        }
        """.data(using: .utf8)!
        let expected = Model(height: 50)

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidPixelDimensionDecodeThrows() {
        // given
        let json = """
        {
          "height": "foo"
        }
        """.data(using: .utf8)!

        // then
        XCTAssertThrowsError(try JSONDecoder().decode(Model.self, from: json))
    }

    func testPixelDimensionEncodeReturnsPixelDimensionJSON() throws {
        // given
        let model = Model(height: 75)
        let expected = """
        {
          "height" : "75px"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }
}
