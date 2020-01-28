//
//  PollfishWebViewStore.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import os
import AdSupport
import UIKit
import WebKit

protocol PollfishWebViewStore {
    func advertisingIdentifier() -> String?
    func getOrigin() -> String?
}

class PollfishWebViewLocalStore: PollfishWebViewStore {
    
    public init() {}
    
    func getOrigin() -> String? {
        if let url = Bundle.main.object(forInfoDictionaryKey: "Pollfish_Url") as? String {
            os_log("WebPollfish URL: %@", log: .default, type: .debug, url)
            return url
        } else {
            os_log("Error getting WebPollfish URL from plist", log: .default, type: .error)
        }
        return nil
    }
    
    func advertisingIdentifier() -> String? {
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            os_log("Application not authorized to track advertising identifier", log: .default, type: .error)
            return nil
        }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}

class PollfishWebViewFactory: NSObject, WKNavigationDelegate {
    
    var errorOcurred: ((_ error: Error) -> ())?
    var notifyWebViewLoaded: (() throws -> ())?
    
    
    func makeWebView(url: String,
                     notifyWebViewLoaded: @escaping (() throws -> ()),
                     errorOcurred: @escaping ((_ error: Error) -> ())) -> PollfishWebviewModel.Webview.ViewModel {
        self.errorOcurred = errorOcurred
        self.notifyWebViewLoaded = notifyWebViewLoaded
        guard let link = URL(string: url) else {
            errorOcurred(PollfishWebViewErrorType.BadUrl)
            return PollfishWebviewModel.Webview.ViewModel(url: url, webview: WKWebView())
        }
        let request = URLRequest(url: link)

        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        
        webView.navigationDelegate = self
        webView.load(request)
        return PollfishWebviewModel.Webview.ViewModel(url: url, webview: webView)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        errorOcurred?(error)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        do {
            try notifyWebViewLoaded?()
        } catch {
            errorOcurred?(error)
        }
    }
}
