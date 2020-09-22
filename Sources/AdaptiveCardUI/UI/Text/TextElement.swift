import Foundation

enum DateStyle: Equatable {
    case compact, short, long
}

enum TextElement: Equatable {
    case plain(String)
    case date(Date, DateStyle)
    case time(Date)
}

extension TextElement {
    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    static func parse(_ input: String) -> [TextElement] {
        let matches = NSRegularExpression.dateTimeFunc.matches(
            in: input,
            options: [],
            range: NSRange(input.startIndex ..< input.endIndex, in: input)
        )
        var result: [TextElement] = []
        var lastIndex = input.startIndex

        for match in matches {
            guard let range = Range(match.range, in: input) else {
                continue
            }

            if range.lowerBound > lastIndex {
                let text = String(input[lastIndex ..< range.lowerBound])
                result.append(.plain(text))
            }

            lastIndex = range.upperBound

            guard let funcRange = Range(match.range(withName: "func"), in: input),
                let dateRange = Range(match.range(withName: "date"), in: input),
                let date = ISO8601DateFormatter.withInternetDateTime.date(from: String(input[dateRange]))
            else {
                let text = String(input[range])
                result.append(.plain(text))
                continue
            }

            let `func` = String(input[funcRange])
            let styleRange = Range(match.range(withName: "style"), in: input)
            let style = styleRange.map { String(input[$0]) }

            switch (`func`, style) {
            case ("DATE", .none):
                result.append(.date(date, .compact))
            case ("DATE", "COMPACT"):
                result.append(.date(date, .compact))
            case ("DATE", "SHORT"):
                result.append(.date(date, .short))
            case ("DATE", "LONG"):
                result.append(.date(date, .long))
            case ("TIME", .none):
                result.append(.time(date))
            default:
                let text = String(input[range])
                result.append(.plain(text))
            }
        }

        if lastIndex < input.endIndex {
            let text = String(input[lastIndex ..< input.endIndex])
            result.append(.plain(text))
        }

        return result
    }
}

private extension NSRegularExpression {
    static let dateTimeFunc = try! NSRegularExpression(
        pattern: #"\{\{(?<func>DATE|TIME){1}\((?<date>[\d]{4}-[\d]{2}-[\d]{2}T[\d]{2}:[\d]{2}:[\d]{2}[Z+-].*?){1}(?:,\s*(?<style>SHORT|LONG|COMPACT){1}\s*)??\)\}\}"#,
        options: []
    )
}

private extension ISO8601DateFormatter {
    static let withInternetDateTime: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        return formatter
    }()
}
