# WebPfSupport

<p align="left">
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
<br />
</p>

Library to load a wkwebview in whichever view.

## Features

- [x] Load a webview when initialize the library.
- [x] Show panel only if webview content is loaded and device return advertising id.
- [x] Send messages to caller when the device is turned.
- [x] Send messages to caller when the webview is open/closed.

### How to use

You need add the property `Pollfish_Url` in your main .plist file of type `String` setting the URL as value 

The simplest use-case is starting the `WKWebView` when the library is init:

```swift

do {
    try PollfishWebView.shared
        .load(viewController: self,
              params: PollfishWebViewParams(paramOne: "", paramTwo: "", paramThree: "", paramFour: "", paramFive: ""),
              onClose: {(three, four, five) -> Void in
                // ...
              },
              onError: { error in
                // ...
              },
              onOpen: {
                // ...
              }
    )
} catch {
    print("Error on PollfishWebView: \(error).")
}

```

## Requirements

- iOS 10.0+
- Swift 5.0+

### License

PfWebView is released under the MIT license. See LICENSE for details.
