//
//  VideoView.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let destinationURL = URL(string: url) else {return}
        uiView.scrollView.isScrollEnabled = true
        uiView.load(URLRequest(url: destinationURL))
    }
}

