//
//  ViewController.swift
//  PollfishAppSupport
//
//  Created by guillermo on 1/26/20.
//  Copyright © 2020 pollfish. All rights reserved.
//

import UIKit
import PollfishWebView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try PollfishWebView.shared
                .load(viewController: self,
                      params: PollfishWebViewParams(paramOne: "Top", paramTwo: "Bottom", paramThree: "tres", paramFour: "4", paramFive: ""),
                      onClose: {(three, four, five) -> Void in
                          print("back with \(three) \(four) \(five)")
                      },
                      onError: { error in
                        print(error)
                      },
                      onOpen: {
                          print("Open webview")
                      }
            )
        } catch {
            print("Error on PollfishWebView: \(error).")
        }
        
    }

}

