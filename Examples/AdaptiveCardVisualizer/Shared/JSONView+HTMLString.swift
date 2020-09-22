import SwiftUI

extension JSONView {
    private enum Constants {
        static let htmlFormat = """
        <!DOCTYPE html>
        <html>
        <head>
            <link rel="stylesheet" href="%@">
        </head>
        <body>
            <script src="prism.js"></script>
            <pre>
                <code class="language-json">
        %@
                </code>
            </pre>
        </body>
        </html>
        """
    }

    func htmlString(with json: String, colorScheme: ColorScheme) -> String {
        let css: String

        switch colorScheme {
        case .dark:
            css = "okaidia.css"
        default:
            css = "default.css"
        }

        return String(format: Constants.htmlFormat, css, json)
    }
}
