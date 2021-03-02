//
//  Resuable.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation
import UIKit

//MARK: Reusable

/// Protocol meant to return self as a string
protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
