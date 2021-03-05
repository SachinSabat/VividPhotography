//
//  GalleryRouter.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import UIKit

final class GalleryRouter: GalleryRouterInput {

    
    weak var viewController: UIViewController?
    
    func showPhotoDetails(with currentIndex: Int, delegate: PageDeletePhotoDelegate, viewModel: PageDetailViewModel) {

        let pageVC = GalleryPageModuleBuilder().buildModule(delegate: delegate, index: currentIndex, viewModel: viewModel)
        viewController?.present(pageVC, animated: true)
    }
}

