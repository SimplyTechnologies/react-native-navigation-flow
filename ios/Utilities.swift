//
//  Utilities.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

func colorForKey(_ key: String, _ props: [String: AnyObject]) -> UIColor? {
  guard let val = props[key] else { return nil }
  return RCTConvert.uiColor(val)
}

func getModalPresentationStyle(from options: [String: AnyObject]) -> UIModalPresentationStyle {
  guard let modalPresentationStyle = options["modalPresentationStyle"] as? String else {
    return .fullScreen
  }

  switch modalPresentationStyle {
  case "overCurrentContext": return .overCurrentContext
  case "currentContext":     return .currentContext
  case "overFullScreen":     return .overFullScreen
  case "fullScreen":         return .fullScreen
  case "formSheet":          return .formSheet
  case "pageSheet":          return .pageSheet
  case "popover":            return .popover
  case "custom":             return .custom
  case "none":               return .none
  default:                   return .fullScreen
  }
}
