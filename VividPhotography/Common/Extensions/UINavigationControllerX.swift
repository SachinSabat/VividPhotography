//
//  UINavigationControllerX.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import UIKit

extension UINavigationController {
    
    func themeNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = UIColor.appBlack()
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.fontColor()
        ]
        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
    
}
