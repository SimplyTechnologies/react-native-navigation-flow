//
//  ReactNavigationGateway.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

open class ReactNavigationGateway: NSObject {
    var screenProperties: [String: [String: AnyObject]] = [:]
    
    public static var shared = ReactNavigationGateway()
    
    public func registerScreen(_ screenName: String, properties: [String: AnyObject]?) {
        var props: [String: AnyObject] = [:]

        if properties != nil {
            props = properties!
        }
        screenProperties[screenName] = props
    }
}
