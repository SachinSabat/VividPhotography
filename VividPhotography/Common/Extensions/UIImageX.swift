//
//  UIImageX.swift
//  MyEmployee-VIPER
//
//  Created by Sachin Sabat on 11/02/21.
//


import UIKit

extension UIImage {
//    convenience init(with name: APP_IMAGES) {
//        self.init(named: name.rawValue)!
//    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

