//
//  ReactPromise.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/30/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

class ReactPromise {
    private let resolvePromise: RCTPromiseResolveBlock
    private let rejectPromise: RCTPromiseRejectBlock
    private var resolvedOrRejected = false

    init(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        self.resolvePromise = resolve
        self.rejectPromise = reject
    }
    
    public func resolve(_ payload: [String: AnyObject]) {
        if self.resolvedOrRejected {
            return
        }
        self.resolvePromise(payload)
    }
    
    public func reject(_ payload: String?) {
        if self.resolvedOrRejected {
            return
        }
      self.rejectPromise(payload, nil, nil)
    }
}
