# CommonKeyboard
An elegant Keyboard library for iOS.

![Swift](https://img.shields.io/badge/Swift-4.2.0-green.svg)
![Swift](https://img.shields.io/badge/License-MIT-green.svg)

![CommonKeyboard](https://user-images.githubusercontent.com/7533178/64527021-728cc180-d337-11e9-99d0-4acd3fd339d3.gif)
![CommonKeyboardObserver](https://user-images.githubusercontent.com/7533178/64527035-7ae4fc80-d337-11e9-96c5-607ae3428ba4.gif)

## Installation

#### [CocoaPods](https://cocoapods.org/)
Add the following to your `Podfile`
````
pod 'CommonKeyboard'
````

#### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your `Cartfile`
````
github "kaweerutk/CommonKeyboard"
````

## Using
In AppDelegate.swift, just `import CommonKeyboard` framework and enable CommonKeyboard.
```swift
import CommonKeyboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Just enabled a single line of code
        CommonKeyboard.shared.enabled = true

        return true
    }
}
```
`CommonKeyboard` will automatically scroll to input view when the cursor focused. This working with UIScrollView and all inheritance classes including UITableView and UICollectionView
(Note: This does not work with `UITableViewController` because it will handle by itself)

You can adjust an offset between keyboard and input view by set `keyboardOffset` the default value is 10, Or you can ignore keyboard handle by giving `ignoredCommonKeyboard` a true value.

```swift
  textField.keyboardOffset = 20
  textField.ignoredCommonKeyboard = true

  textView.keyboardOffset = 2
  textView.ignoredCommonKeyboard = false
```

#### CommonKeyboardObserver
Subscribe `CommonKeyboardObserver` to get keyboard notification info.

```swift
import CommonKeyboard

class ExampleChatViewController: UIViewController {

    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    let keyboardObserver = CommonKeyboardObserver()

    override func viewDidLoad() {
        super.viewDidLoad()
        // drag down to dismiss keyboard
        tableView.keyboardDismissMode = .interactive

        keyboardObserver.subscribe(events: [.willChangeFrame, .dragDown]) { [weak self] (info) in
            guard let weakSelf = self else { return }
            var bottom = 0
            if info.isShowing {
                bottom = -info.visibleHeight
                if #available(iOS 11, *) {
                    bottom += safeAreaInsets.bottom
                }
            }
            UIView.animate(info, animations: { [weak self] in
                self?.bottomConstraint.constant = bottom
                self?.view.layoutIfNeeded()
            })
        }
    }

}
```

Sometimes there are many UIScrollView containers in UI Stack View and the CommonKeyboard cannot find the right container you can implement `CommonKeyboardContainerProtocol` and return specific container

```swift
extension ChatViewController: CommonKeyboardContainerProtocol {
    // return specific scrollView
    // UIScrollView or a class that inherited from (e.g., UITableView or UICollectionView)
    var scrollViewContainer: UIScrollView {
        return tableView
    }
}
```

## Requirements
- **iOS9** or later
- **Swift 4.2** or later

## Contact
If you have any question or issue please create an [issue](https://github.com/kaweerutk/CommonKeyboard/issues/new)!

## License
CommonKeyboard is released under the [MIT License](https://github.com/kaweerutk/CommonKeyboard/blob/master/LICENSE.md).
