//
//  GalleryModuleBuilder.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation

protocol GalleryModuleBuilderProtocol: AnyObject {
    func buildModule() -> GalleryVC
}


final class GalleryModuleBuilder: GalleryModuleBuilderProtocol {
    
    func buildModule() -> GalleryVC {
        print("Gallery Module Builder")

        let galleryVC = GalleryVC()
        let presenter = GalleryPresenter()
        let network = NetworkAPI()
        let interactor = GalleryIneractor(network: network)
        let router = GalleryRouter()
        
        presenter.view = galleryVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        galleryVC.presenter = presenter
        router.viewController = galleryVC
        
        return galleryVC
    }
}

