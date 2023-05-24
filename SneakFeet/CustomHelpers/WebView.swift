//
//  WebView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
