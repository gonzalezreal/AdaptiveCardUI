import AdaptiveCard
import XCTest

final class SemanticVersionTests: XCTestCase {
    private struct Model: Codable, Equatable {
        var version: SemanticVersion
    }

    func testParseAnyVersion() {
        // given
        let versionString = "*"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertEqual(SemanticVersion(major: 0), result)
        XCTAssertEqual(versionString, result?.description)
    }

    func testParseMajorVersion() {
        // given
        let versionString = "1"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertEqual(SemanticVersion(major: 1), result)
        XCTAssertEqual("1.0.0", result?.description)
    }

    func testParseMinorVersion() {
        // given
        let versionString = "1.2"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertEqual(SemanticVersion(major: 1, minor: 2), result)
        XCTAssertEqual("1.2.0", result?.description)
    }

    func testParsePatchNumber() {
        // given
        let versionString = "1.2.3"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertEqual(SemanticVersion(major: 1, minor: 2, patch: 3), result)
        XCTAssertEqual(versionString, result?.description)
    }

    func testParseEmptyVersion() {
        // given
        let versionString = ""

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertNil(result)
    }

    func testParseVersionWithTooManyComponents() {
        // given
        let versionString = "1.2.3.4"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertNil(result)
    }

    func testParseInvalidVersion() {
        // given
        let versionString = "fistro"

        // when
        let result = SemanticVersion(versionString)

        // then
        XCTAssertNil(result)
    }

    func testCompare() {
        XCTAssertEqual(SemanticVersion(major: 1), SemanticVersion(major: 1))
        XCTAssertTrue(SemanticVersion(major: 0, minor: 0, patch: 2) > SemanticVersion(major: 0, minor: 0, patch: 1))
        XCTAssertTrue(SemanticVersion(major: 0, minor: 1) > SemanticVersion(major: 0, minor: 0, patch: 1))
        XCTAssertTrue(SemanticVersion(major: 0, minor: 2) > SemanticVersion(major: 0, minor: 1))
        XCTAssertTrue(SemanticVersion(major: 1) < SemanticVersion(major: 1, minor: 1))
        XCTAssertTrue(SemanticVersion(major: 0, minor: 1) < SemanticVersion(major: 1))
        XCTAssertTrue(SemanticVersion(major: 0, minor: 0, patch: 1) < SemanticVersion(major: 1))
        XCTAssertTrue(SemanticVersion(major: 1) < SemanticVersion(major: 2))
    }

    func testAnyVersionDecode() throws {
        // given
        let json = """
        {
          "version": "*"
        }
        """.data(using: .utf8)!
        let expected = Model(version: SemanticVersion(major: 0))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testVersionDecode() throws {
        // given
        let json = """
        {
          "version": "1.2"
        }
        """.data(using: .utf8)!
        let expected = Model(version: SemanticVersion(major: 1, minor: 2))

        // when
        let result = try JSONDecoder().decode(Model.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testAnyVersionEncode() throws {
        // given
        let model = Model(version: SemanticVersion(major: 0))
        let expected = """
        {
          "version" : "*"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testVersionEncode() throws {
        // given
        let model = Model(version: SemanticVersion(major: 1, minor: 2))
        let expected = """
        {
          "version" : "1.2.0"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testGreaterVersionCapabilitiesSatisfiesRequirements() {
        // given
        let capabilities = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 2),
            "otherCapability": SemanticVersion(major: 2),
            "anotherCapability": SemanticVersion(major: 3),
        ]
        let requirements = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 1),
            "otherCapability": SemanticVersion(major: 1, minor: 9),
        ]

        // when
        let result = capabilities.satisfies(requirements)

        // then
        XCTAssertTrue(result)
    }

    func testEqualVersionCapabilitiesSatisfiesRequirements() {
        // given
        let capabilities = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 1),
            "otherCapability": SemanticVersion(major: 1, minor: 9),
            "anotherCapability": SemanticVersion(major: 3),
        ]
        let requirements = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 1),
            "otherCapability": SemanticVersion(major: 1, minor: 9),
        ]

        // when
        let result = capabilities.satisfies(requirements)

        // then
        XCTAssertTrue(result)
    }

    func testAnyLowerVersionCapabilityDoesNotSatisfyRequirements() {
        // given
        let capabilities = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 1),
            "otherCapability": SemanticVersion(major: 1, minor: 5),
            "anotherCapability": SemanticVersion(major: 3),
        ]
        let requirements = [
            "adaptiveCards": SemanticVersion(major: 1, minor: 1),
            "otherCapability": SemanticVersion(major: 1, minor: 9),
        ]

        // when
        let result = capabilities.satisfies(requirements)

        // then
        XCTAssertFalse(result)
    }
}
