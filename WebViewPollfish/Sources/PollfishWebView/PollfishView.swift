//
//  PollfishWebViewView.swift
//  WebPollfish
//
//  Created by guillermo on 1/25/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

class ParamLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        backgroundColor = .magenta
    }
    
}

class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setTitle("X", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemPink
    }
    
}
