//
//  ReactNavigationFlow.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

private let VERSION: Int8 = 1

@objc(ReactNavigationFlow)
class ReactNavigationFlow: NSObject {

  private var navigationGateway: ReactNavigationGateway!
  override init() {
      super.init()
      self.navigationGateway = ReactNavigationGateway.shared
  }
  
  func constantsToExport() -> [String: Any] {
    return [
      "VERSION": VERSION,
      "instanceIdKey": mNativeNavigationInstanceId,
      "events": [
        "didMount": "sceneDidMount"
      ]
    ]
  }

  @objc
  public func registerScreen(_ screenName: String, properties: [String: AnyObject]) {
    // TODO
    self.navigationGateway.registerScreen(screenName, properties: properties)
  }
  
  @objc
  public func push(_ screenName: String, properties: [String: AnyObject]) {
    // TODO
  }
  
  @objc
  public func pop(_ animated: Bool) {
    // TODO
  }
  
  @objc
  public func present(_ screenName: String, properties: [String: AnyObject]) {
    // TODO
  }
  
  @objc
  public func dismiss(_ animated: Bool) {
    // TODO
  }
}
