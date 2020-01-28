//
//  WebPollfish.swift
//  WebPollfish
//
//  Created by guillermo on 1/23/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

public typealias PollfishWebViewClose = (String, String, String) -> Void
public typealias PollfishWebViewError = (Error) -> Void
public typealias PollfishWebViewOpen = () -> ()
public typealias PollfishWebViewReady = () throws -> ()

public enum PollfishWebViewErrorType: Error {
    case BadParams
    case BadUrl
    case EmptyPlistProp
    case EmptyNavigationController
    case NilAdvertisinId
}

public class PollfishWebViewParams {
    
    private (set) var paramOne: String
    private (set) var paramTwo: String
    private (set) var paramThree: String
    private (set) var paramFour: String
    private (set) var paramFive: String
    
    public init(paramOne: String, paramTwo: String, paramThree: String, paramFour: String, paramFive: String) {
        self.paramOne = paramOne
        self.paramTwo = paramTwo
        self.paramThree = paramThree
        self.paramFour = paramFour
        self.paramFive = paramFive
    }
}

public class PollfishWebView {
    
    private var closeClosure: PollfishWebViewClose?
    private var errorClosure: PollfishWebViewError?
    private var openClosure: PollfishWebViewOpen?
    public static let shared = PollfishWebView()
    private let rootViewController = PollfishWebViewVC()
    
    private init() {}
    
    @discardableResult
    public func load(viewController: UIViewController,
                     params: PollfishWebViewParams,
                     onClose: @escaping PollfishWebViewClose,
                     onError: @escaping PollfishWebViewError,
                     onOpen: @escaping PollfishWebViewOpen
                     ) throws -> PollfishWebView {
        self.closeClosure = onClose
        self.errorClosure = onError
        self.openClosure = onOpen
        
        try setupWebview(viewController: viewController, params: params)
        
        return PollfishWebView.shared
    }
        
}

private extension PollfishWebView {
    
    func setupWebview(viewController: UIViewController, params: PollfishWebViewParams) throws {
        let localStore = PollfishWebViewLocalStore()
        let webViewFactory = PollfishWebViewFactory()
        let presenter = PollfishWebViewPresenter(viewController: rootViewController)
        let worker = PollfishWebViewWorker(webviewStore: localStore, webViewFactory: webViewFactory)
        let interactor = PollfishWebViewInteractor(
            onClose: closeClosure,
            onError: errorClosure,
            onOpen: openClosure,
            params: params,
            presenter: presenter,
            worker: worker
        )
            
        rootViewController.interactor = interactor
        interactor.preLoad(whenFinishLoad: {
            try self.startWebview(viewController: viewController)
        })
    }
    
    func startWebview(viewController: UIViewController) throws {
        guard let navigationController = viewController.navigationController else {
            throw PollfishWebViewErrorType.EmptyNavigationController
        }
        let transition: CATransition = CATransition()
        if navigationController.topViewController == rootViewController {
            navigationController.popViewController(animated: false)
        }
        
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        transition.type = .push
        transition.subtype = .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}
