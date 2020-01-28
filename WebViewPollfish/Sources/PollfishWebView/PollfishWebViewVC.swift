//
//  PollfishWebViewViewController.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import WebKit

protocol PollfishWebViewDisplayLogic: class {
    func displayAdvertisingIdentifier(with viewModel: PollfishWebviewModel.Webview.AdvertisingViewModel)
    func displayTitleParam(viewModel: PollfishWebviewModel.Webview.ParamViewModel)
    func displayWebview(viewModel: PollfishWebviewModel.Webview.ViewModel)
    
}

class PollfishWebViewVC: UIViewController, PollfishWebViewDisplayLogic {
    
    var advertisingIdLabel: ParamLabel?
    var closeButton: UIButton?
    var interactor: PollfishWebViewBusinessLogic?
    var paramOneLabel: ParamLabel?
    var paramTwoLabel: ParamLabel?
    var webView: WKWebView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupReload()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Never will happen")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        interactor?.openView()
        reload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func displayAdvertisingIdentifier(with viewModel: PollfishWebviewModel.Webview.AdvertisingViewModel) {
        makeParamLabel(label: &advertisingIdLabel,
                       frame: CGRect(x: view.frame.width / 8,
                                     y: view.frame.height / 2,
                                     width: view.frame.width * 80 / 100,
                                     height: 30.0))
        advertisingIdLabel?.text = viewModel.id
    }
    
    func displayTitleParam(viewModel: PollfishWebviewModel.Webview.ParamViewModel) {
        paramOneLabel?.text = viewModel.titleParamOne
        paramTwoLabel?.text = viewModel.titleParamTwo
    }
    
    func displayWebview(viewModel: PollfishWebviewModel.Webview.ViewModel) {
        webView = viewModel.webview
        if let webView = webView {
            webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.addSubview(webView)
            view.sendSubviewToBack(webView)
        }
    }
      
}

private extension PollfishWebViewVC {
    
    @objc func reload() {
        setupView()
        interactor?.setView()
    }
    
    @objc func close() {
        let transition = CATransition()
        
        interactor?.closeView()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        transition.type = .push
        transition.subtype = .fromLeft
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: false)
    }
    
    func makeParamLabel(label: inout ParamLabel?, frame: CGRect) {
        if label == nil {
            label = ParamLabel(frame: frame)
        } else {
            label?.removeFromSuperview()
        }
        if let label = label {
            view.addSubview(label)
        }
    }
    
    func setupReload() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(reload), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(reload), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func setupView() {
        if closeButton == nil {
            closeButton = CloseButton(frame: CGRect(x: 20, y: 30, width: 30.0, height: 30.0))
            closeButton?.addTarget(self, action: #selector(close), for: .touchUpInside)
        } else {
            closeButton?.removeFromSuperview()
        }
        if let closeButton = closeButton {
            view.addSubview(closeButton)
        }
        makeParamLabel(label: &paramOneLabel, frame: CGRect(x: view.frame.width / 4, y: 30, width: view.frame.width * 50 / 100, height: 30.0))
        makeParamLabel(label: &paramTwoLabel, frame: CGRect(x: view.frame.width / 4, y: view.frame.height - 30, width: view.frame.width * 50 / 100, height: 30.0))
    }
    
}
