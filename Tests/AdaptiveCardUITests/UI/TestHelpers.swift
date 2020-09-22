import Foundation

func fixtureURL(_ fileName: String, file: StaticString = #file) -> URL {
    URL(fileURLWithPath: "\(file)", isDirectory: false)
        .deletingLastPathComponent()
        .appendingPathComponent("__Fixtures__")
        .appendingPathComponent(fileName)
}
