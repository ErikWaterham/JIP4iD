import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {

    public let url: URL

    public func makeUIView(context: Context) -> WKWebView {

        // swiftlint:disable explicit_type_interface
        let view = WKWebView()
        // swiftlint:enable explicit_type_interface
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {

        guard context.coordinator.needsToLoadURL else {
            return
        }

        uiView.load(URLRequest(url: url))
    }

    public func makeCoordinator() -> WebView.Coordinator {

        Coordinator()
    }

    public class Coordinator {

        public var needsToLoadURL: Bool = true
    }
}

private struct WebKitView_Previews: PreviewProvider {

    static var previews: some View {
        WebView(url: URL(string: "...")!) // swiftlint:disable:this force_unwrapping
    }
}
