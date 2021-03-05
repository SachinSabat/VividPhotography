//
//  GalleryPageBuilder.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import Foundation


protocol GalleryPageBuilderProtocol {
    func buildModule(delegate: PageDeletePhotoDelegate,index: Int, viewModel: PageDetailViewModel) -> PagePhotoDetailViewController
}

final class GalleryPageModuleBuilder: GalleryPageBuilderProtocol {
    
    func buildModule(delegate: PageDeletePhotoDelegate, index: Int, viewModel: PageDetailViewModel) -> PagePhotoDetailViewController {
        
        let detailViewController = PagePhotoDetailViewController()
        let presenter = GalleryPagePresenter(indexAt: index, viewModel: viewModel)
        let router = PagePhotoDetailRouter()
        
        presenter.view = detailViewController
        presenter.delegate = delegate

        presenter.router = router
        
        detailViewController.presenter = presenter
        router.viewController = detailViewController
        
        return detailViewController
    }
}

