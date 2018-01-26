//
//  ReactNavigationGateway.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation


private var _id = 0

private struct ReactViewControllerHolder {
  weak var controller: ReactViewController?
}

private func generateId() -> String {
  _id = _id + 1
  return "\(_id)"
}

open class ReactNavigationGateway: NSObject {
  private var screenProperties: [String: [String: AnyObject]] = [:]
  public var bridge = RCTBridge()
  public static var shared = ReactNavigationGateway()
  private var viewControllers: [String: ReactViewControllerHolder]!

  // Keep Registered screen's properties
  public func registerScreen(_ screenName: String, properties: [String: AnyObject]?) {
    var props: [String: AnyObject] = [:]
    
    if properties != nil {
      props = properties!
    }
    screenProperties[screenName] = props
  }
  public func getScreenProperties(_ screenName: String) -> [String: AnyObject]? {
    return screenProperties[screenName]
  }
  func registerViewController(_ viewController: ReactViewController) {
    viewControllers[viewController.navigationInstanceId] = ReactViewControllerHolder(controller: viewController)
  }
}
