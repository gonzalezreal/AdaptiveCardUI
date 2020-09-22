#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension Text {
        init(parsing input: String, locale: Locale? = nil) {
            let formatter = DateFormatter()
            formatter.locale = locale

            self = TextElement.parse(input).map { element -> Text in
                switch element {
                case let .plain(value):
                    return Text(value)
                case let .date(date, style):
                    switch style {
                    case .compact:
                        formatter.dateStyle = .short
                        formatter.timeStyle = .none
                    case .short:
                        formatter.dateStyle = .long
                        formatter.timeStyle = .none
                    case .long:
                        formatter.dateStyle = .full
                        formatter.timeStyle = .none
                    }
                    return Text(formatter.string(from: date))
                case let .time(date):
                    formatter.dateStyle = .none
                    formatter.timeStyle = .short
                    return Text(formatter.string(from: date))
                }
            }
            .joined()
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension Array where Element == Text {
        func joined() -> Text {
            var result = Text("")
            for element in self {
                result = result + element
            }
            return result
        }
    }

#endif
