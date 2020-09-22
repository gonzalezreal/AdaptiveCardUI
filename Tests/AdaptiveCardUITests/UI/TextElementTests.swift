@testable import AdaptiveCardUI
import XCTest

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
final class TextElementTests: XCTestCase {
    func testPlainTextParseReturnsPlainTextElement() {
        // given
        let input = "hello world, this is a test"
        let expected: [TextElement] = [
            .plain("hello world, this is a test"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testValidDateParseReturnsExpectedTextElements() {
        // given
        let input = "This {{DATE(2017-02-14T06:08:00Z)}} is compact by default"
        let expected: [TextElement] = [
            .plain("This "),
            .date(Date(timeIntervalSinceReferenceDate: 508_745_280), .compact),
            .plain(" is compact by default"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testValidCompactDateParseReturnsExpectedTextElements() {
        // given
        let input = "This {{DATE(2017-02-14T06:08:00Z, COMPACT)}} is compact"
        let expected: [TextElement] = [
            .plain("This "),
            .date(Date(timeIntervalSinceReferenceDate: 508_745_280), .compact),
            .plain(" is compact"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testValidShortDateParseReturnsExpectedTextElements() {
        // given
        let input = "This {{DATE(2017-02-14T06:08:00Z, SHORT)}} is short"
        let expected: [TextElement] = [
            .plain("This "),
            .date(Date(timeIntervalSinceReferenceDate: 508_745_280), .short),
            .plain(" is short"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testValidLongDateParseReturnsExpectedTextElements() {
        // given
        let input = "This {{DATE(2017-02-14T06:08:00Z, LONG)}} is long"
        let expected: [TextElement] = [
            .plain("This "),
            .date(Date(timeIntervalSinceReferenceDate: 508_745_280), .long),
            .plain(" is long"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testValidTimeParseReturnsExpectedTextElements() {
        // given
        let input = "This {{TIME(2017-02-14T06:08:00-07:00)}} should be rendered as time"
        let expected: [TextElement] = [
            .plain("This "),
            .time(Date(timeIntervalSinceReferenceDate: 508_770_480)),
            .plain(" should be rendered as time"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testCombinedDateAndTimeParseReturnsExpectedTextElements() {
        // given
        let input = "Combine {{DATE(2017-02-14T06:08:00+04:00)}} and {{TIME(2017-02-14T06:08:00+04:00)}} in the same text"
        let expected: [TextElement] = [
            .plain("Combine "),
            .date(Date(timeIntervalSinceReferenceDate: 508_730_880), .compact),
            .plain(" and "),
            .time(Date(timeIntervalSinceReferenceDate: 508_730_880)),
            .plain(" in the same text"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidSpacesParseReturnsPlainTextElement() {
        // given
        let input = "Invalid Spaces {{ DATE(2017-02-14T06:08:00Z) }} {{ TIME(2017-02-14T06:08:00Z) }}"
        let expected: [TextElement] = [
            .plain("Invalid Spaces {{ DATE(2017-02-14T06:08:00Z) }} {{ TIME(2017-02-14T06:08:00Z) }}"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidDateParseReturnsPlainTextElements() {
        // given
        let input = "Invalid Date {{DATE(2017-99-14T06:08:00Z)}} {{TIME(2017-99-14T06:08:00Z)}} 🤷🏽‍♂️"
        let expected: [TextElement] = [
            .plain("Invalid Date "),
            .plain("{{DATE(2017-99-14T06:08:00Z)}}"),
            .plain(" "),
            .plain("{{TIME(2017-99-14T06:08:00Z)}}"),
            .plain(" 🤷🏽‍♂️"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testInvalidCasingParseReturnsPlainTextElement() {
        // given
        let input = "Invalid casing {{date(2017-02-14T06:08:00Z)}} {{Time(2017-02-14T06:08:00Z)}} 🤷🏽‍♂️"
        let expected: [TextElement] = [
            .plain("Invalid casing {{date(2017-02-14T06:08:00Z)}} {{Time(2017-02-14T06:08:00Z)}} 🤷🏽‍♂️"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testMissingSecondsParseReturnsPlainTextElement() {
        // given
        let input = "Missing seconds {{DATE(2017-10-27T22:27Z)}} 🤷🏽‍♂️"
        let expected: [TextElement] = [
            .plain("Missing seconds {{DATE(2017-10-27T22:27Z)}} 🤷🏽‍♂️"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }

    func testTimeWithStyleParseReturnsPlainTextElements() {
        // given
        let input = "TIME doesn't allow a style param {{TIME(2017-02-14T06:08:00Z, SHORT)}}"
        let expected: [TextElement] = [
            .plain("TIME doesn't allow a style param "),
            .plain("{{TIME(2017-02-14T06:08:00Z, SHORT)}}"),
        ]

        // when
        let result = TextElement.parse(input)

        // then
        XCTAssertEqual(expected, result)
    }
}
