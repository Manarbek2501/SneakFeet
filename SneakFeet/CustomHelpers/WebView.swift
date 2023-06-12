//
//  WebView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//
import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    init (progress: Double) {
        self.progress = progress
    }
}

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let url: URL
    
    let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        var parent: WebView
        private var estimatedProgressObserver: NSKeyValueObservation?
        
        init(_ parent: WebView, viewModel: WebViewModel) {
            self.parent = parent
            self.viewModel = viewModel
            super.init()
            
            estimatedProgressObserver = self.parent.webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    guard let weakSelf = self else { return }
                    weakSelf.viewModel.progress = webView.estimatedProgress
                }
            }
        }
        
        deinit {
            estimatedProgressObserver = nil
        }
    }
}

