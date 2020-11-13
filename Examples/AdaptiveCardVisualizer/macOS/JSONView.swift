import SwiftUI
import WebKit

struct JSONView: NSViewRepresentable {
    let resourceName: String

    func makeNSView(context _: Context) -> WKWebView {
        WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: nil),
              let data = try? Data(contentsOf: url),
              let json = String(data: data, encoding: .utf8)
        else {
            return
        }

        nsView.loadHTMLString(
            htmlString(with: json, colorScheme: context.environment.colorScheme),
            baseURL: Bundle.main.resourceURL
        )
    }
}
