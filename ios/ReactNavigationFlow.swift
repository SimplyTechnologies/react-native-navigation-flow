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
  public func registerScreen(_ screenName: String, properties: [String: AnyObject], waitForRender: Bool) {
    // TODO
    print("RNNF: \(screenName) has been registered with properties \(properties)")
    self.navigationGateway.registerScreen(screenName, properties: properties, waitForRender: waitForRender)
  }
  
  @objc
  public func push(_ screenName: String, properties: NSDictionary) {
    // TODO
    print("RNNF: Push has been called \(screenName) \(properties)")
    let vc = self.navigationGateway.topViewController()
    let nextVC = ReactViewController(sceneName: screenName)
    // TODO - Pass data
    DispatchQueue.main.async {
      vc?.navigationController?.pushViewController(nextVC, animated: properties.object(forKey: "animated") as? Bool ?? true)
    }
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
  
  @objc
  public func firstRenderComplete(_ navFlowInstanceId: String) {
    let vc = self.navigationGateway.viewController(forId: navFlowInstanceId)
    vc?.markAsRendered()
  }
}
