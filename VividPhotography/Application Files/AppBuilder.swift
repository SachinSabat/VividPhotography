//
//  AppBuilder.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import UIKit

/// AppBuilder should contain task wrt the application
final public class AppBuilder {
    
    /// This method helps to setup Root VC
    /// - Parameter window: UIWindow object
    /// - Returns: default response
    @discardableResult
    func setRootViewController(in window: UIWindow?) -> Bool {
        let vc = ViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        //NOTE: Following instance method is responsible for bring the window to the front of the screen
        window?.makeKeyAndVisible()
        return true
    }
}
