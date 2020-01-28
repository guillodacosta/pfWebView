//
//  PollfishWebViewModels.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import WebKit

enum PollfishWebviewModel {
    
    enum Webview {
        
        struct Origin {
            let url: String
        }
        
        struct ViewModel {
            let url: String
            let webview: WKWebView
            
            init(url: String, webview: WKWebView) {
                self.url = url
                self.webview = webview
            }
        }
        
        struct AdvertisingViewModel {
            let id: String
            
            init(id: String) {
                self.id = id
            }
        }
        
        struct ParamViewModel {
            let titleParamOne: String
            let titleParamTwo: String
            
            init(titleParamOne: String, titleParamTwo: String) {
                self.titleParamOne = titleParamOne
                self.titleParamTwo = titleParamTwo
            }
        }
        
    }
}
