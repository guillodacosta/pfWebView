//
//  PollfishWebViewInteractor.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import WebKit

protocol PollfishWebViewBusinessLogic {
    func closeView()
    func errorOcurred(_ error: Error)
    func openView()
    func preLoad(whenFinishLoad: @escaping PollfishWebViewReady)
    func notifyWebViewLoaded()
    func setView()
}


class PollfishWebViewInteractor: PollfishWebViewBusinessLogic {
    private var isAdvertisingTrackingEnabled = false
    private var onClose: PollfishWebViewClose?
    private var onError: PollfishWebViewError?
    private var onOpen: PollfishWebViewOpen?
    private var params: PollfishWebViewParams?
    private var presenter: PollfishWebViewPresentationLogic?
    private var whenCompleteLoad: PollfishWebViewReady?
    private var webView: WKWebView?
    private var worker: PollfishWebViewWorker?
    
    init(onClose: PollfishWebViewClose?, onError: PollfishWebViewError?, onOpen: PollfishWebViewOpen?,
        params: PollfishWebViewParams, presenter: PollfishWebViewPresentationLogic, worker: PollfishWebViewWorker) {
        self.onClose = onClose
        self.onError = onError
        self.onOpen = onOpen
        self.params = params
        self.presenter = presenter
        self.worker = worker
    }
    
    func closeView() {
        if let onClose = onClose, let params = params {
            onClose(params.paramThree, params.paramFour, params.paramFive)
        }
    }
    
    func errorOcurred(_ error: Error) {
        onError?(error)
    }
    
    func notifyWebViewLoaded() {
        if isAdvertisingTrackingEnabled, let whenCompleteLoad = whenCompleteLoad {
            do {
                try whenCompleteLoad()
            } catch {
                self.onError?(error)
            }
        }
    }
    
    func preLoad(whenFinishLoad: @escaping PollfishWebViewReady) {
        worker?.getOrigin(completionHandler: { origin in
            webView = worker?.getWebview(
                url: origin,
                notifyWebViewLoaded: {
                    try whenFinishLoad()
                },
                errorOcurred: { [weak self] error in
                    self?.onError?(error)
                }).webview
        }, errorHandler: { [weak self] in self?.onError?(PollfishWebViewErrorType.EmptyPlistProp)
        })
        worker?.advertisingIdentifier(completionHandler: { [weak self] advertisingId in
            self?.isAdvertisingTrackingEnabled = true
        }, errorHandler: { [weak self] in
            self?.onError?(PollfishWebViewErrorType.NilAdvertisinId)
        })
    }
        
    func openView() {
        (onOpen ?? {})()
    }
    
    func setView() {
        if let webView = webView {
            presenter?.loadWebview(url: "", webView: webView)
            worker?.advertisingIdentifier(completionHandler: { [weak self] advertisingId in
                self?.isAdvertisingTrackingEnabled = true
                self?.presenter?.showAdvertisingInfo(advertisingId: advertisingId)
            }, errorHandler: { [weak self] in self?.onError?(PollfishWebViewErrorType.NilAdvertisinId)
            })
            presenter?.showTitleParam(titleParamOne: params?.paramOne ?? "", titleParamTwo: params?.paramTwo ?? "")
        }
    }
}
