#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct CustomCardElementView: View {
        @Environment(\.customCardElementViewFactories) private var customCardElementViewFactories

        private let customCardElement: CustomCardElement

        init(_ customCardElement: CustomCardElement) {
            self.customCardElement = customCardElement
        }

        var body: some View {
            if let viewFactory = customCardElementViewFactories[type(of: customCardElement).typeName] {
                viewFactory(customCardElement)
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        func customCardElement<Element, Content>(
            _: Element.Type = Element.self,
            content: @escaping (Element) -> Content
        ) -> some View where Element: Equatable, Element: Codable, Element: CustomCardElement, Content: View {
            CardElement.register(Element.self)
            return environment(
                \.customCardElementViewFactories,
                [Element.typeName: { AnyView(content($0 as! Element)) }]
            )
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension EnvironmentValues {
        var customCardElementViewFactories: [String: CustomCardElementViewFactory] {
            get { self[CustomCardElementViewFactoriesKey.self] }
            set {
                self[CustomCardElementViewFactoriesKey.self]
                    .merge(newValue) { _, b in b }
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private typealias CustomCardElementViewFactory = (CustomCardElement) -> AnyView

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct CustomCardElementViewFactoriesKey: EnvironmentKey {
        static let defaultValue: [String: CustomCardElementViewFactory] = [:]
    }

#endif
