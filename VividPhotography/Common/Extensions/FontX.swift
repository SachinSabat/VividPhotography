//
//  FontX.swift
//  MyEmployee-VIPER
//
//  Created by Sachin Sabat on 11/02/21.
//

import UIKit

extension UIFont {
    /// Custom init to make assignment of fonts easy n clean
    /// - Parameters:
    ///   - name: APP_FONT_STYLE
    ///   - size: APP_FONT_SIZE
    convenience init(with name: APP_FONT_STYLE,of size: APP_FONT_SIZE) {
        self.init(name: name.rawValue,size: CGFloat(size.rawValue))!
    }
}

