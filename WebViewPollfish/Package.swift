// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PollfishWebView",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "PollfishWebView", targets: ["PollfishWebView"]),
    ],
    targets: [
        .target(name: "PollfishWebView", dependencies: []),
        .testTarget(name: "WebPollfishSupportTests", dependencies: ["PollfishWebView"]),
    ]
    
)
