//
//  ReactNavigationFlow.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc(ReactNavigationFlow)
class ReactNavigationFlow: NSObject {

  @objc
  public func registerScreen(_ screenName: String, properties: [String: AnyObject]) {
    // TODO
    ReactNavigationGateway.shared.registerScreen(screenName, properties: properties)
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
