//
//  GalleryPageProtocols.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import Foundation

// MARK: View Protocol
protocol GalleryPageViewInput: BaseViewInput {
    func renderView(with imageUrl: URL, index:Int, viewModel: PageDetailViewModel)

}

protocol GalleryPageDetailViewOutput: AnyObject {
   func didTapDelete(index: Int)
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
