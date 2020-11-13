import SwiftUI
import WebKit

struct JSONView: UIViewRepresentable {
    let resourceName: String

    func makeUIView(context _: Context) -> WKWebView {
        let uiView = WKWebView()
        uiView.isOpaque = false
        uiView.backgroundColor = .clear

        return uiView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: nil),
              let data = try? Data(contentsOf: url),
              let json = String(data: data, encoding: .utf8)
        else {
            return
        }

        uiView.loadHTMLString(
            htmlString(with: json, colorScheme: context.environment.colorScheme),
            baseURL: Bundle.main.resourceURL
        )
    }
}
