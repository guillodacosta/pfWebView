//
//  PollfishWebViewPresenter.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import WebKit

protocol PollfishWebViewPresentationLogic {
    func loadWebview(url: String, webView: WKWebView)
    func showAdvertisingInfo(advertisingId: String)
    func showTitleParam(titleParamOne: String, titleParamTwo: String)
}

class PollfishWebViewPresenter: PollfishWebViewPresentationLogic {
    
    private weak var viewController: PollfishWebViewDisplayLogic?
    
    init(viewController: UIViewController) {
        self.viewController = viewController as? PollfishWebViewDisplayLogic
    }
    
    func loadWebview(url: String, webView: WKWebView) {
        let viewModel = PollfishWebviewModel.Webview.ViewModel(url: url, webview: webView)
        
        viewController?.displayWebview(viewModel: viewModel)
    }
    
    func showAdvertisingInfo(advertisingId: String) {
        let viewModel = PollfishWebviewModel.Webview.AdvertisingViewModel(id: advertisingId)
        
        viewController?.displayAdvertisingIdentifier(with: viewModel)
    }
    
    func showTitleParam(titleParamOne: String, titleParamTwo: String) {
        viewController?.displayTitleParam(viewModel: PollfishWebviewModel.Webview.ParamViewModel(titleParamOne: titleParamOne, titleParamTwo: titleParamTwo))
    }
}
