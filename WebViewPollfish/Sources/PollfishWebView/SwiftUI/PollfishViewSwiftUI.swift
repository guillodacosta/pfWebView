//
//  PollfishWebViewView.swift
//  WebPollfish
//
//  Created by guillermo on 1/27/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

#if canImport(SwiftUI)

import SwiftUI

struct ParamLabel: View {

    @State private var title = ""

    var body: some View {
        Text(self.title)
            .accessibility(addTraits: .isStaticText)
            .allowsTightening(true)
            .background(Color.orange)
            .foregroundColor(Color.white)
//            .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 200)
            .lineLimit(1)
            .truncationMode(Text.TruncationMode.tail)
    }
}

struct CloseButton: View {

    @State private var callback: () -> ()

    var body: some View {
        Button(action: {
            self.callback()
        }) {
//            ParamLabel(title: "X")
//            .padding()
            Image(systemName: "close")
                .background(Color.orange)
                .foregroundColor(Color.white)
        }
    }
}

#endif
