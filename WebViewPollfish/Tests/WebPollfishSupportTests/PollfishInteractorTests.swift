//
//  WebPollfishInteractorTests.swift
//  PollfishAppSupport
//
//  Created by guillermo on 1/25/20.
//  Copyright (c) 2020 pollfish. All rights reserved.
//

@testable import PollfishWebView
import XCTest
import WebKit

class PollfishInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    
    var sut: PollfishWebViewInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupWebPollfishInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupWebPollfishInteractor() {
        let params = PollfishWebViewParams(paramOne: "valueOne", paramTwo: "valueTwo", paramThree: "valueTrhee", paramFour: "4", paramFive: "5")
        let localStore = PollfishWebViewLocalStoreSpy()
        let webViewFactory = PollfishWebViewFactorySpy()
        let presenter = PollfishWebViewPresentationLogicSpy(viewController: UIViewController())
        let worker = PollfishWebViewWorkerSpy(webviewStore: localStore, webViewFactory: webViewFactory)
        
        sut = PollfishWebViewInteractor(
            onClose: { (three, four, five) -> Void in },
            onError: { _ in },
            onOpen: {},
            params: params,
            presenter: presenter,
            worker: worker
        )
    }
    
    // MARK: Test doubles
    
    class PollfishWebViewLocalStoreSpy: PollfishWebViewStore {
        func advertisingIdentifier() -> String? {
            return ""
        }
        
        func getOrigin() -> String? {
            return ""
        }
    }
    
    class PollfishWebViewFactorySpy: PollfishWebViewFactory {}
    
    class PollfishWebViewPresentationLogicSpy: PollfishWebViewPresentationLogic {
        var viewController: PollfishWebViewDisplayLogic?
        
        init(viewController: UIViewController) {
            self.viewController = viewController as? PollfishWebViewDisplayLogic
        }
        
        func loadWebview(url: String, webView: WKWebView) {
            
        }
        
        func showAdvertisingInfo(advertisingId: String) {
            
        }
        
        func showTitleParam(titleParamOne: String, titleParamTwo: String) {
            
        }
    }
    
    class PollfishWebViewWorkerSpy: PollfishWebViewWorker {
        
        var advertisingId = "0-0-0-0-0"
        var origin = "https://www.pollfish.com"
        var tagWebview = 0x7A6
        
        override init(webviewStore: PollfishWebViewStore, webViewFactory: PollfishWebViewFactory) {
            super.init(webviewStore: webviewStore, webViewFactory: webViewFactory)
            self.webviewStore = webviewStore
            self.webViewFactory = webViewFactory
        }
        
        override func advertisingIdentifier(completionHandler: (String) -> (), errorHandler: () -> ()) {
            completionHandler(advertisingId)
        }
        
        override func getOrigin(completionHandler: (String) -> (), errorHandler: () -> ()) {
            completionHandler(origin)
        }
        
        override func getWebview(
            url: String,
            notifyWebViewLoaded: @escaping (() throws -> ()),
            errorOcurred: @escaping ((_ error: Error) -> ())) -> PollfishWebviewModel.Webview.ViewModel {
            let webview = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
            
            webview.tag = tagWebview
            
            // Spy webview load delegate
            do {
                try notifyWebViewLoaded()
            } catch {}
            
            return PollfishWebviewModel.Webview.ViewModel(url: url, webview: webview)
        }
    }
    
    // MARK: Tests
    
    func testNotifyOpenView() {
        var didOpen = false
        let params = PollfishWebViewParams(paramOne: "valueOne", paramTwo: "valueTwo", paramThree: "valueTrhee", paramFour: "4", paramFive: "5")
        let localStore = PollfishWebViewLocalStoreSpy()
        let webViewFactory = PollfishWebViewFactorySpy()
        let presenter = PollfishWebViewPresentationLogicSpy(viewController: UIViewController())
        let worker = PollfishWebViewWorkerSpy(webviewStore: localStore, webViewFactory: webViewFactory)
        
        sut = PollfishWebViewInteractor(
            onClose: { (three, four, five) -> Void in },
            onError: { _ in },
            onOpen: {
                didOpen = true
            },
            params: params,
            presenter: presenter,
            worker: worker
        )
        
        // When
        sut.openView()
        
        // Then
        XCTAssertTrue(didOpen, "onOpen must be executed but is nil")
    }
    
    func testNotificationCalled() {
        enum ErrorSpyType: Error {
            case spy
            case other
        }
        var errorExpected = ErrorSpyType.other
        var didOpen = false
        var paramThree = ""
        var paramFour = ""
        var paramFive = ""
        let params = PollfishWebViewParams(paramOne: "valueOne", paramTwo: "valueTwo", paramThree: "valueThree", paramFour: "valueFour", paramFive: "5")
        let localStore = PollfishWebViewLocalStoreSpy()
        let webViewFactory = PollfishWebViewFactorySpy()
        let presenter = PollfishWebViewPresentationLogicSpy(viewController: UIViewController())
        let worker = PollfishWebViewWorkerSpy(webviewStore: localStore, webViewFactory: webViewFactory)
        
        let errorSpy = ErrorSpyType.spy
        
        sut = PollfishWebViewInteractor(
            onClose: { (three, four, five) -> Void in
                paramThree = three
                paramFour = four
                paramFive = five
            },
            onError: { error in
                errorExpected = error as? ErrorSpyType ?? .other
            },
            onOpen: {
                didOpen = true
            },
            params: params,
            presenter: presenter,
            worker: worker
        )
        
        // When
        sut.errorOcurred(errorSpy)
        sut.openView()
        sut.closeView()
        
        // Then
        XCTAssertTrue(didOpen, "onOpen must be called but is null")
        XCTAssertEqual(errorSpy, errorExpected, "Error returned is not consistent")
        XCTAssertEqual(paramFour, params.paramFour, "Param Four returned is different")
        XCTAssertEqual(paramFive, params.paramFive, "Param Five returned is different")
        XCTAssertEqual(paramThree, params.paramThree, "Params Three returned is different")
    }
    
    func testWebViewSetted() {
        var paramThree = ""
        let params = PollfishWebViewParams(paramOne: "valueOne", paramTwo: "valueTwo", paramThree: "valueThree", paramFour: "valueFour", paramFive: "5")
        let localStore = PollfishWebViewLocalStoreSpy()
        let webViewFactory = PollfishWebViewFactorySpy()
        let presenter = PollfishWebViewPresentationLogicSpy(viewController: UIViewController())
        let worker = PollfishWebViewWorkerSpy(webviewStore: localStore, webViewFactory: webViewFactory)
        
        let finishLoadSpy = {
            paramThree = params.paramThree
        }
        
        sut = PollfishWebViewInteractor(
            onClose: { (three, four, five) -> Void in },
            onError: { _ in },
            onOpen: { },
            params: params,
            presenter: presenter,
            worker: worker
        )
        
        // When
        sut.preLoad(whenFinishLoad: finishLoadSpy)
        
        // Then
        XCTAssertEqual(paramThree, params.paramThree, "Callback getWebView is null or not ")
    }
    
    static var allTests = [
        ("testNotifyOpenView", testNotifyOpenView),
        ("testNotificationCalled", testNotificationCalled),
        ("testNotifyErrorMessage", testWebViewSetted),
    ]
}
