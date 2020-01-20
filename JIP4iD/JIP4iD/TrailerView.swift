//
//  TrailerView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import WebKit

public struct TrailerView: View {

    @ObservedObject private var webViewStore = WebViewStore()
    @Environment(\.presentationMode) private var presentationMode

    public var key: String

    public var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: "https://www.youtube.com/embed/\(self.key)")!)
                Spacer()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Done") })
        }
        .onAppear {
            self.webViewStore.webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(self.key)")!))
        }
    }
}
