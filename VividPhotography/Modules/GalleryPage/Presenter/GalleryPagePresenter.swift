//
//  GalleryPagePresenter.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import Foundation

protocol PageDeletePhotoDelegate {
    func userTappedOnDeleteButton(indexAt: Int, viewModel: PageDetailViewModel)
}

final class GalleryPagePresenter: GalleryPageDetailModuleInput, GalleryPageDetailViewOutput {

    var view: GalleryPageViewInput?
    var router: GalleryPageDetailRouterInput!
    
    var delegate: PageDeletePhotoDelegate?
    var viewModel: PageDetailViewModel
    var index: Int

    init(indexAt: Int, viewModel: PageDetailViewModel) {
        self.index = indexAt
        self.viewModel = viewModel
    }
    
    func onViewDidLoad() {
        self.view?.showActivityLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else {
                return
            }
            guard let urlString = self.viewModel.photo.largeImageURL, let imageUrl = URL(string: urlString) else {
                return
            }
            self.view?.renderView(with: imageUrl)
            self.view?.hideActivityLoader()
        }
    }
    
    // Mark:- Delegate index and viewModel to GalleryPresenter
    //
    // Func called on delete button clicked
    //
    func didTapDelete() {
        delegate?.userTappedOnDeleteButton(indexAt: self.index, viewModel: viewModel)
        router.dismiss()
    }

}
