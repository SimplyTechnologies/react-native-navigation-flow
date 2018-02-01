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
  public func push(_ screenName: String, props: [String: AnyObject], options: [String: AnyObject], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    print("RNNF: Push has been called \(screenName) \(props) \(options)")

    // TODO - Pass data
    DispatchQueue.main.async {
      guard
        let vc = self.navigationGateway.topViewController() as? ReactViewController
        else { return }
      let nextVC = ReactViewController(sceneName: screenName, props: props, options: options)
      nextVC.delegate = vc.delegate
      nextVC.modalPresentationStyle = getModalPresentationStyle(from: options)
      self.navigationGateway.registerNavigationFlow(nextVC, resolve: resolve, reject: reject)
      vc.navigationController?.pushViewController(nextVC, animated: props["animated"] as? Bool ?? true)
    }
  }
  
  @objc
  public func pop(_ payload: [String: AnyObject], options: [String: AnyObject]) {
    print("RNNF: Pop has been called \(payload) \(options)")
    DispatchQueue.main.async {
      guard
        let vc = self.navigationGateway.topViewController() as? ReactViewController
        else { return }

      let nav = self.navigationGateway.topNavigationController()
      nav?.popViewController(animated: options["animated"] as? Bool ?? true)
      vc.dismiss(payload, animated: options["animated"] as? Bool ?? true)
    }
  }
  
  @objc
  public func present(_ screenName: String, props: [String: AnyObject], options: [String: AnyObject], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    print("RNNF: Present has been called \(screenName) \(props) \(options)")

    // TODO - Pass data
    DispatchQueue.main.async {
      guard
        let vc = self.navigationGateway.topViewController() as? ReactViewController
        else { return }
      let nextVC = ReactViewController(sceneName: screenName, props: props, options: options)
      let navVC = UINavigationController(rootViewController: nextVC)
      nextVC.delegate = vc.delegate
      navVC.modalPresentationStyle = getModalPresentationStyle(from: options)
      self.navigationGateway.registerNavigationFlow(nextVC, resolve: resolve, reject: reject)
      vc.present(navVC, animated: props["animated"] as? Bool ?? true, completion: nil)
    }
  }
  
  @objc
  public func dismiss(_ payload: [String: AnyObject], options: [String: AnyObject]) {
    print("RNNF: Dismiss has been called \(payload) \(options)")

    DispatchQueue.main.async {
      guard
        let vc = self.navigationGateway.topViewController() as? ReactViewController
        else { return }
      vc.dismiss(animated: options["animated"] as? Bool ?? true, completion: nil)
      vc.dismiss(payload, animated: options["animated"] as? Bool ?? true)
    }
  }
  
  @objc
  public func firstRenderComplete(_ navFlowInstanceId: String) {
    let vc = self.navigationGateway.viewController(forId: navFlowInstanceId)
    vc?.markAsRendered()
  }
}
