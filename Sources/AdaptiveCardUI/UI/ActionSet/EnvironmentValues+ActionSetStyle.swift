#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        /// The action set style of this environment.
        var actionSetStyle: ActionSetStyle {
            get { self[ActionSetStyleKey.self] }
            set { self[ActionSetStyleKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        /// Sets the action set style for adaptive cards within this view.
        func actionSetStyle(_ actionSetStyle: ActionSetStyle) -> some View {
            environment(\.actionSetStyle, actionSetStyle)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ActionSetStyleKey: EnvironmentKey {
        static let defaultValue = ActionSetStyle()
    }

#endif
