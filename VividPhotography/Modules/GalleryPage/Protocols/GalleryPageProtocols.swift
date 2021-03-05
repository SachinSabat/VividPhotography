//
//  GalleryPageProtocols.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import Foundation

// MARK: View Protocol
protocol GalleryPageViewInput: BaseViewInput {
    func renderView(with imageUrl: URL)
}

protocol GalleryPageDetailViewOutput: AnyObject {
   func didTapDelete()
   func onViewDidLoad()
}

protocol GalleryPageDetailModuleInput: AnyObject {
    var view: GalleryPageViewInput? { get set }
    var router: GalleryPageDetailRouterInput! { get set }
}

protocol GalleryPageDetailInteractorInput: AnyObject {
    
}

protocol GalleryPageDetailInteractorOutput: AnyObject {
    
}

protocol GalleryPageDetailRouterInput: AnyObject {
    func dismiss()
}
