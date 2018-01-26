//
//  Utilities.swift
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

func colorForKey(_ key: String, _ props: [String: AnyObject]) -> UIColor? {
    guard let val = props[key] as? NSNumber else { return nil }
    let argb: UInt = val.uintValue;
    let a = CGFloat((argb >> 24) & 0xFF) / 255.0;
    let r = CGFloat((argb >> 16) & 0xFF) / 255.0;
    let g = CGFloat((argb >> 8) & 0xFF) / 255.0;
    let b = CGFloat(argb & 0xFF) / 255.0;
    return UIColor(red: r, green: g, blue: b, alpha: a)
}
