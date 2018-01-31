# iOS Installation

!> Make sure you are using **react-native** version >= 0.51.

1. Install `react-native-navigation-flow` from npm.

```sh
npm install react-native-navigation-flow
```

2. Copy all Swift & Bridge file into your project

<div align="center">
	<video src="todo">
</div>

3. Open your AppDelegate.swift file and add the following lines into your project

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ReactNavigationGatewayDelegate, RCTBridgeDelegate {

  var window: UIWindow!
  var bridge: RCTBridge!

  func sourceURL(for bridge: RCTBridge!) -> URL! {
//      return URL(string: "http://192.168.2.91:8081/index.bundle?platform=ios&dev=true")
      return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
  }
  
  func rootViewController(gateway: ReactNavigationGateway) -> UIViewController? {
    return window?.rootViewController
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
	window = UIWindow(frame: UIScreen.main.bounds)
    bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    ReactNavigationGateway.shared.bridge = bridge
    ReactNavigationGateway.shared.delegate = self

    let mRoot = ReactViewController(sceneName: "YOUR_INITIAL_SCREEN_NAME")
    let mNav = UINavigationController(rootViewController: mRoot)

    window?.rootViewController = mNav
    window?.makeKeyAndVisible()
    return true
  }
}

```