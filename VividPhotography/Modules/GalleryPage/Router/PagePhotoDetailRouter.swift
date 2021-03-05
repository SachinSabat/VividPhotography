//
//  PagePhotoDetailRouter.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import UIKit

final class PagePhotoDetailRouter: GalleryPageDetailRouterInput {
    
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
