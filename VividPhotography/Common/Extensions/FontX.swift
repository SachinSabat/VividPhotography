//
//  FontX.swift
//  MyEmployee-VIPER
//
//  Created by Sachin Sabat on 11/02/21.
//

import UIKit

extension UIFont {
    convenience init(with name: APP_FONT_STYLE,of size: APP_FONT_SIZE) {
        self.init(name: name.rawValue,size: CGFloat(size.rawValue))!
    }
}
