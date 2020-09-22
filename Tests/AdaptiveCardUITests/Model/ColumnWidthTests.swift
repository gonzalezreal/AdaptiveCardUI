import AdaptiveCardUI
import XCTest

final class ColumnWidthTests: XCTestCase {
    private struct Model: Codable, Equatable {
        var width: ColumnWidth
    }

    func testAutoDecodeReturnsAutoColumnWidth() throws {
        // given
        let json = """
        {
          "width": "auto"
        }
        """.data(using: .utf8)!
        let expected = Model(width: .auto)

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testStretchDecodeReturnsStretchColumnWidth() throws {
        // given
        let json = """
        {
          "width": "stretch"
        }
        """.data(using: .utf8)!
        let expected = Model(width: .stretch)

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testNumberDecodeReturnsWeightColumnWidth() throws {
        // given
        let json = """
        {
          "width": 50
        }
        """.data(using: .utf8)!
        let expected = Model(width: .weight(50))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testNumericStringDecodeReturnsWeightColumnWidth() throws {
        // given
        let json = """
        {
          "width": "50"
        }
        """.data(using: .utf8)!
        let expected = Model(width: .weight(50))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testPixelValueDecodeReturnsPixelColumnWidth() throws {
        // given
        let json = """
        {
          "width": "50px"
        }
        """.data(using: .utf8)!
        let expected = Model(width: .pixels(50))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidValueDecodeThrows() {
        // given
        let json = """
        {
          "width": "foo"
        }
        """.data(using: .utf8)!

        // then
        XCTAssertThrowsError(try JSONDecoder().decode(Model.self, from: json))
    }

    func testAutoColumnWidthEncodeReturnsAutoJSON() throws {
        // given
        let model = Model(width: .auto)
        let expected = """
        {
          "width" : "auto"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testStretchColumnWidthEncodeReturnsStretchJSON() throws {
        // given
        let model = Model(width: .stretch)
        let expected = """
        {
          "width" : "stretch"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testWeightColumnWidthEncodeReturnsNumberJSON() throws {
        // given
        let model = Model(width: .weight(50))
        let expected = """
        {
          "width" : 50
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testPixelColumnWidthEncodeReturnsPixelValueJSON() throws {
        // given
        let model = Model(width: .pixels(50))
        let expected = """
        {
          "width" : "50px"
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
