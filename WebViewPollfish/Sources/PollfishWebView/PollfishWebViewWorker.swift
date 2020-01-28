//
//  PollfishWebViewWorker.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//


class PollfishWebViewWorker {
    
    var webviewStore: PollfishWebViewStore
    var webViewFactory: PollfishWebViewFactory
    
    init(webviewStore: PollfishWebViewStore, webViewFactory: PollfishWebViewFactory) {
        self.webviewStore = webviewStore
        self.webViewFactory = webViewFactory
    }
    
    func advertisingIdentifier(completionHandler: (String) -> (), errorHandler: () -> ()) {
        if let advertisingId = webviewStore.advertisingIdentifier() {
            completionHandler(advertisingId)
        } else {
            errorHandler()
        }
    }
    
    func getOrigin(completionHandler: (String) -> (), errorHandler: () -> ()) {
        if let origin = webviewStore.getOrigin() {
            completionHandler(origin)
        } else {
            errorHandler()
        }
    }
    
    func getWebview(url: String,
                    notifyWebViewLoaded: @escaping (() throws -> ()),
                    errorOcurred: @escaping ((_ error: Error) -> ())) -> PollfishWebviewModel.Webview.ViewModel {
        
        return webViewFactory.makeWebView(url: url, notifyWebViewLoaded: notifyWebViewLoaded, errorOcurred: errorOcurred)
    }
}
