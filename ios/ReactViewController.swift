//
//  ReactNavigationController.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import UIKit

// MARK: Private
let mNativeNavigationInstanceId = "navFlowInstanceId"
let mViewControllerId = "viewControllerId"

private var _id = 0
let EMPTY_MAP = [String: AnyObject]()


func generateId(_ sceneName: String) -> String {
  _id += 1
  return "navigationFlow-\(sceneName)-\(_id)"
}

func wrapProps(
  _ props: [String: AnyObject],
  _ nativeNavigationInstanceId: String
) -> [String: AnyObject] {
  var mProps = props
  mProps[mNativeNavigationInstanceId] = nativeNavigationInstanceId as AnyObject?
  return mProps
}

class ReactViewController: UIViewController {
  public var navigationInstanceId: String
  private var reactViewHasBeenRendered: Bool = false
  private var sceneName: String!
  private let gateway = ReactNavigationGateway.shared
  private var props: [String: AnyObject]
  private var initialConfig: [String: AnyObject]
  private var renderConfig: [String: AnyObject]
  private var statusBarHidden: Bool = false
  private var statusBarStyle = UIStatusBarStyle.default

  public convenience init(sceneName: String) {
    self.init(sceneName: sceneName, props: [:])
  }
  
  public init(sceneName: String, props: [String: AnyObject]) {
    self.navigationInstanceId = generateId(sceneName)
    self.sceneName = sceneName
    
    self.props = EMPTY_MAP
    self.initialConfig = EMPTY_MAP
    self.renderConfig = EMPTY_MAP
    
    super.init(nibName: nil, bundle: nil)
    
    if let currentConfig = self.gateway.getScreenProperties(sceneName) {
      self.initialConfig = currentConfig
      self.renderConfig = currentConfig
    }
  }
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override public var prefersStatusBarHidden : Bool {
    return statusBarHidden
  }
  override public var preferredStatusBarStyle : UIStatusBarStyle {
    return statusBarStyle
  }

  // Load RCTRootView into ViewController root
  override open func loadView() {
    self.gateway.registerViewController(self)
    
    self.view = RCTRootView(
      bridge: self.gateway.bridge,
      moduleName: self.sceneName,
      initialProperties: self.props
    )
    if let screenColor = colorForKey("screenColor", initialConfig) {
      self.view.backgroundColor = screenColor
    }
  }
  
  public func emitEvent(_ eventName: String, data: AnyObject?) {
    let name = String(format: "NavigationFlowScreen-%@.%@", eventName, self.navigationInstanceId)
    let args: [AnyObject]
    if let payload = data {
      args = [name as AnyObject, payload]
    } else {
      args = [name as AnyObject]
    }
    self.gateway.bridge.enqueueJSCall("RCTDeviceEventEmitter.emit", args: args)
  }

  
}