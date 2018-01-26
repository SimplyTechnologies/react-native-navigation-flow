//
//  UIViewController+ TopMostViewController.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomTopMostViewController {
    func customTopMostViewController() -> UIViewController
}

public extension UIViewController {
  func topMostViewController() -> UIViewController? {
    if let custom = (self as? CustomTopMostViewController)?.customTopMostViewController() {
      return custom.topMostViewController()
    } else if let presented = self.presentedViewController {
      return presented.topMostViewController()
    } else if let tabBarSelected = (self as? UITabBarController)?.selectedViewController {
      return tabBarSelected.topMostViewController()
    } else if let navVisible = (self as? UINavigationController)?.visibleViewController {
      return navVisible.topMostViewController()
    } else if let lastChild = self.childViewControllers.last {
      return lastChild.topMostViewController()
    } else {
      return self
    }
  }
}
