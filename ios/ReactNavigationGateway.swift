//
//  ReactNavigationGateway.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc public enum NavigationFlowResultCode: Int {
  case cancelled = 0
  case ok = -1
  
  public static func isOk(_ value: Int?) -> Bool {
    if value != nil {
      return NavigationFlowResultCode(rawValue: value!) == .ok
    }
    return false
  }
}

@objc public protocol ReactNavigationGatewayDelegate {
  func rootViewController(gateway: ReactNavigationGateway) -> UIViewController?
}

@objc public protocol NavigationGatewayFlowProtocol: class {
  @objc var reactFlowId: String? { get set }
  @objc func start(_ props: [String: AnyObject]?)
  
  @objc func finish(_ resultCode: NavigationFlowResultCode, payload: [String: AnyObject]?)
}

private var _id = 0

public struct ReactViewControllerHolder {
  weak var controller: ReactViewController?
}

private func generateId() -> String {
  _id = _id + 1
  return "\(_id)"
}

open class ReactNavigationGateway: NSObject {
  private var screenProperties: [String: [String: AnyObject]] = [:]
  private var screenRenderOptions: [String: [String: AnyObject]] = [:]

  public var bridge: RCTBridge?
  public var delegate: ReactNavigationGatewayDelegate?

  public static var shared = ReactNavigationGateway()
  public var viewControllers: [String: ReactViewControllerHolder]! = [:]

  // Keep Registered screen's properties
  public func registerScreen(_ screenName: String, properties: [String: AnyObject]?, waitForRender: Bool) {
    var props: [String: AnyObject] = [:]
    
    if properties != nil {
      props = properties!
    }
    screenProperties[screenName] = props
    screenRenderOptions[screenName] = [
      "waitForRender": waitForRender as AnyObject
    ]
  }

  public func getScreenProperties(_ screenName: String) -> [String: AnyObject]? {
    return screenProperties[screenName]
  }

  func registerViewController(_ viewController: ReactViewController) {
    viewControllers[viewController.navigationInstanceId] = ReactViewControllerHolder(controller: viewController)
  }
  
  public func topViewController() -> UIViewController? {
    guard
      let vc = self.delegate?.rootViewController(gateway: self)
      else { return nil}
    
    return vc.topMostViewController()
  }
  
  func viewController(forId id: String) -> ReactViewController? {
    return self.viewControllers[id]?.controller
  }
  
  func unregisterController(_ instanceId: String) -> ReactViewControllerHolder? {
    return viewControllers.removeValue(forKey: instanceId)
  }
}
