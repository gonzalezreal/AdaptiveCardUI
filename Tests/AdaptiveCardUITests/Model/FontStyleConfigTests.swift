import AdaptiveCardUI
import XCTest

final class FontStyleConfigTests: XCTestCase {
    func testAnyConfigFontFamilyNames() {
        // given
        var anyConfig = FontStyleConfig()
        anyConfig.fontFamily = "'Courier New', Courier, monospace"
        let expected = ["Courier New", "Courier", "monospace"]

        // when
        let result = anyConfig.fontFamilyNames

        // then
        XCTAssertEqual(expected, result)
    }

    func testNotMatchingFontFamilyNamesFirstFontFamilyName() {
        // given
        var anyConfig = FontStyleConfig()
        anyConfig.fontFamily = "'Courier New', Courier, monospace"
        let availableFontFamilyNames = Set(["Foo", "Bar"])

        // when
        let result = anyConfig.firstFontFamilyName(in: availableFontFamilyNames)

        // then
        XCTAssertNil(result)
    }

    func testMatchingFontFamilyNamesFirstFontFamilyName() {
        // given
        var anyConfig = FontStyleConfig()
        anyConfig.fontFamily = "'Courier New', Courier, monospace"
        let availableFontFamilyNames = Set(["Foo", "Bar", "courier"])
        let expected = "Courier"

        // when
        let result = anyConfig.firstFontFamilyName(in: availableFontFamilyNames)

        // then
        XCTAssertEqual(expected, result)
    }
}
