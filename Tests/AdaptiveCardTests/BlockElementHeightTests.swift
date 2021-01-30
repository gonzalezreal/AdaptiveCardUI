import AdaptiveCard
import XCTest

final class BlockElementHeightTests: XCTestCase {
    private struct Model: Codable, Equatable {
        var height: BlockElementHeight
    }

    func testAutoDecodeReturnsAutoBlockElementHeight() throws {
        // given
        let json = """
        {
          "height": "auto"
        }
        """.data(using: .utf8)!
        let expected = Model(height: .auto)

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testStretchDecodeReturnsStretchBlockElementHeight() throws {
        // given
        let json = """
        {
          "height": "stretch"
        }
        """.data(using: .utf8)!
        let expected = Model(height: .stretch)

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testPixelDecodeReturnsPixelBlockElementHeight() throws {
        // given
        let json = """
        {
          "height": "50px"
        }
        """.data(using: .utf8)!
        let expected = Model(height: .pixels(50))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidBlockElementHeightDecodeThrows() {
        // given
        let json = """
        {
          "height": "foo"
        }
        """.data(using: .utf8)!

        // then
        XCTAssertThrowsError(try JSONDecoder().decode(Model.self, from: json))
    }

    func testAutoBlockElementHeightEncodeReturnsAutoBlockElementHeightJSON() throws {
        // given
        let model = Model(height: .auto)
        let expected = """
        {
          "height" : "auto"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testStretchBlockElementHeightEncodeReturnsStretchBlockElementHeightJSON() throws {
        // given
        let model = Model(height: .stretch)
        let expected = """
        {
          "height" : "stretch"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testPixelBlockElementHeightEncodeReturnsPixelBlockElementHeightJSON() throws {
        // given
        let model = Model(height: .pixels(50))
        let expected = """
        {
          "height" : "50px"
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
