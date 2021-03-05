//
//  GalleryPresenter.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation

final class GalleryPresenter: GalleryModuleInput {
    
    var searchText = ""
    weak var view: GalleryViewInput?
    var interactor: GalleryInteractorInput!
    var router: GalleryRouterInput!
    
    var galleryViewModel: GalleryViewModel!
    
    var pageNumber = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    
    //Mark:- insertMorePhoto
    // Pagination method call
    //
    fileprivate func insertMorePhotos(with photosUrlList: [Photo]) {
        let previousCount = totalCount
        totalCount += photosUrlList.count
        
        galleryViewModel.appendPhotodUrlList(with: photosUrlList)
        let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
            return IndexPath(item: $0, section: 0)
        }
        DispatchQueue.main.async { [unowned self] in
            self.view?.insertImages(with: self.galleryViewModel, at: indexPaths)
            self.view?.changeViewState(.content)
        }
    }
    
    // Mark:- didSelectPhoto
    // To navigate to detailPageViewController
    //
    func didSelectPhoto(at index: Int) {
        
        let gallery = galleryViewModel.photosUrlList[index]
        let galleryDetailModel = PageDetailViewModel(gallery, _index: index)
        
        router.showPhotoDetails(with: index, delegate: self, viewModel: galleryDetailModel)
    }
    
}
// Mark:- GalleryViewOutput
// searchPhoto
// isMoreDataAvailable
//
extension GalleryPresenter: GalleryViewOutput {
    
    func searchPhotos(matching imageName: String) {
        searchText = imageName
        view?.changeViewState(.none)
        guard isMoreDataAvailable else { return }
        pageNumber += 1
        view?.changeViewState(.loading)
        interactor.loadPhotos(matching: imageName, pageNum: pageNumber)
        if pageNumber == 1 { DataBaseUtils.shared.insertSearchText(object: imageName) }
        
    }
    
    var isMoreDataAvailable: Bool {
        guard pageNumber != 0 else {
            return true
        }
        return (pageNumber < Constants.maximumPageNum)
    }
    
    func clearData() {
        pageNumber = Constants.defaultPageNum
        totalCount = Constants.defaultTotalCount
        galleryViewModel = nil
        view?.resetViews()
        view?.changeViewState(.none)
    }
}
// Mark:- GalleryInteractorOutput
// gallerySearchSuccess
// gallerySearchError
//
extension GalleryPresenter: GalleryInteractorOutput {
    func gallerySearchSuccess(_ galleryPhotos: Gallery) {
        
        guard let galleryHitDataList = galleryPhotos.hits else {
            return
        }
    
        if totalCount == Constants.defaultTotalCount {
            galleryViewModel = GalleryViewModel(urlList: galleryHitDataList)
            totalCount = galleryHitDataList.count
            DispatchQueue.main.async { [unowned self] in
                self.view?.displayImages(with: self.galleryViewModel)
                self.view?.changeViewState(.content)
            }
        } else {
            DispatchQueue.main.async { [unowned self] in
                view?.changeViewState(.content)
            }
            insertMorePhotos(with: galleryHitDataList)
        }
    }
    
    func gallerySearchError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.error(error.description))
        }
    }
}

// MARK: Delegate Method of UpdateFavouriteDelegate
extension GalleryPresenter: PageDeletePhotoDelegate {
    func userTappedOnDeleteButton(indexAt: Int, viewModel: PageDetailViewModel) {
        galleryViewModel.deletephotoUrlAt(indexAt)
        totalCount = galleryViewModel.totalCount
        view?.reloadCell(at: indexAt, viewModel: galleryViewModel)
    }

}
