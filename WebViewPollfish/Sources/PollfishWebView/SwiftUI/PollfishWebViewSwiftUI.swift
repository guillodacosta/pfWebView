//
//  WebPollfish.swift
//  WebPollfish
//
//  Created by guillermo on 1/27/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

#if canImport(SwiftUI)

import SwiftUI
import PollfishWebView

//struct CollectionView: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> UICollectionViewController {
//        let vc = UICollectionViewController(collectionViewLayout: UICollectionViewLayout())
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {
//        //
//    }
//}
//
//#if DEBUG
//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView()
//    }
//}
//#endif

//public class PollfishWebViewSwiftUI {
//    
//    private var closeClosure: PollfishWebViewClose?
//    private var errorClosure: PollfishWebViewError?
//    private var openClosure: PollfishWebViewOpen?
//    public static let shared = PollfishWebViewSwiftUI()
//    private let rootViewController = PollfishWebViewVC()
//    
//    private init() {}
//    
//    @discardableResult
//    public func load(viewController: UIViewController,
//                     params: PollfishWebViewParams,
//                     onClose: @escaping PollfishWebViewClose,
//                     onError: @escaping PollfishWebViewError,
//                     onOpen: @escaping PollfishWebViewOpen
//                     ) throws -> PollfishWebViewSwiftUI {
//        self.closeClosure = onClose
//        self.errorClosure = onError
//        self.openClosure = onOpen
//        
//        try setupWebview(viewController: viewController, params: params)
//        
//        return PollfishWebViewSwiftUI.shared
//    }
//    
//    @discardableResult
//    public func load(view swiftUIView: AnyView,
//                     params: PollfishWebViewParams,
//                     onClose: @escaping PollfishWebViewClose,
//                     onError: @escaping PollfishWebViewError,
//                     onOpen: @escaping PollfishWebViewOpen
//                     ) throws -> PollfishWebViewSwiftUI {
//        self.closeClosure = onClose
//        self.errorClosure = onError
//        self.openClosure = onOpen
//        
//        try setupWebview(viewController: UIHostingController(rootView: swiftUIView), params: params)
//        
//        return PollfishWebViewSwiftUI.shared
//    }
//}
//
//private extension PollfishWebViewSwiftUI {
//    
//    func setupWebview(viewController: UIViewController, params: PollfishWebViewParams) throws {
//        let localStore = PollfishWebViewLocalStore()
//        let webViewFactory = PollfishWebViewFactory()
//        let presenter = PollfishWebViewPresenter(viewController: rootViewController)
//        let worker = PollfishWebViewWorker(webviewStore: localStore, webViewFactory: webViewFactory)
//        let interactor = PollfishWebViewInteractor(
//            onClose: closeClosure,
//            onError: errorClosure,
//            onOpen: openClosure,
//            params: params,
//            presenter: presenter,
//            worker: worker
//        )
//            
//        rootViewController.interactor = interactor
//        interactor.preLoad(whenFinishLoad: {
//            try self.startWebview(viewController: viewController)
//        })
//    }
//    
//    func startWebview(viewController: UIViewController) throws {
//        guard let navigationController = viewController.navigationController else {
//            throw PollfishWebViewErrorType.EmptyNavigationController
//        }
//        let transition: CATransition = CATransition()
//        if navigationController.topViewController == rootViewController {
//            navigationController.popViewController(animated: false)
//        }
//        
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
//        transition.type = .push
//        transition.subtype = .fromRight
//        navigationController.view.layer.add(transition, forKey: kCATransition)
//        navigationController.modalPresentationStyle = .fullScreen
//        navigationController.setNavigationBarHidden(true, animated: false)
//        navigationController.pushViewController(rootViewController, animated: false)
//    }
//}

//@available(iOS 13, *)
//public class UIHostingController<Content> : UIViewController where Content : View {}

#endif
