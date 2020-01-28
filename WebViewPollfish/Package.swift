// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PollfishWebView",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "PollfishWebView", targets: ["PollfishWebView"]),
        .library(name: "PollfishWebViewSwiftUI", targets: ["PollfishWebViewSwiftUI"]),
    ],
    targets: [
        .target(name: "PollfishWebView", dependencies: [], exclude: ["SwiftUI"]),
//        .target(name: "PollfishWebViewSwiftUI", dependencies: ["PollfishWebView"]),
//        .target(name: "PollfishWebViewSwiftUI", dependencies: ["PollfishWebView"], sources: ["SwiftUI"]),
        .target(name: "PollfishWebViewSwiftUI", dependencies: ["PollfishWebView"], path: "Sources/PollfishWebView/SwiftUI"),
        .testTarget(name: "WebPollfishSupportTests", dependencies: ["PollfishWebView"]),
    ]
    
)
