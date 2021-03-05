//
//  GalleryPresenterTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class GalleryPresenterTests: XCTestCase {
    
    var interactor: GalleryIneractorMock!
    var presenter: GalleryPresenterMock!
    var view: GalleryVCMock!
    var router: GalleryRouterInput!
    var network: NetworkService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = GalleryPresenterMock()
        network = NetworkClientMock()
        interactor = GalleryIneractorMock(presenter: presenter, network: network)
        router = GalleryRouterMock()
        view = GalleryVCMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        view = nil
        interactor = nil
        network = nil
    }
    
    func testSearchMethodCall() {
        presenter.searchPhotos(matching: "Shiva")
        XCTAssertTrue(presenter.gallerySuccess)
        XCTAssertTrue(view.showGalleryImages)
        XCTAssertNotNil(presenter.galleryViewModel)
        XCTAssertTrue(presenter.galleryViewModel.totalCount == 2)
    }
    
    func testDidSelectPhotoCall() {
        presenter.didSelectPhoto(at: 0)
        XCTAssertTrue(presenter.selectedPhoto)
    }
}

final class GalleryPresenterMock: GalleryModuleInput, GalleryViewOutput, GalleryInteractorOutput {
    var photos: [Photo]?
    
    weak var view: GalleryViewInput?
    var interactor: GalleryInteractorInput!
    var router: GalleryRouterInput!
    var galleryViewModel: GalleryViewModel!
    
    var isMoreDataAvailable: Bool { return true }
    var gallerySuccess = false
    var selectedPhoto = false
    
    func searchPhotos(matching imageName: String) {
        interactor.loadPhotos(matching: imageName, pageNum: 1)
    }
    
    func gallerySearchSuccess(_ galleryPhotos: Gallery) {
        gallerySuccess = true
        
        guard let galleryHitData = galleryPhotos.hits else {
            return
        }
        XCTAssertFalse(galleryHitData.isEmpty)
    //    let galleryPhotoList = buildGalleryPhotoUrlList(from: galleryPhotos.hits ?? [])
        let viewModel = GalleryViewModel(urlList: galleryPhotos.hits ?? [])
        self.galleryViewModel = viewModel
        view?.displayImages(with: viewModel)
    }
    
    func gallerySearchError(_ error: NetworkError) {
        gallerySuccess = false

    }
    
    func clearData() {
        view?.resetViews()
    }
    
    //MARK: FlickrImageURLList
    func buildGalleryPhotoUrlList(from photos: [Photo]) -> [URL] {
        let galleryPhotoUrlList = photos.compactMap { (photo) -> URL? in
            let url = photo.previewURL
            guard let imageUrl = URL(string: url!) else {
                return nil
            }
            return imageUrl
        }
        return galleryPhotoUrlList
    }
    
    func didSelectPhoto(at index: Int) {
        selectedPhoto = true
    }
}


final class GalleryVCMock: UIViewController, GalleryViewInput {
    func reloadCell(at index: Int, viewModel: GalleryViewModel) {
        
    }
    

    var presenter: GalleryViewOutput!
    var showGalleryImages = false
    
    init(presenter: GalleryViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeViewState(_ state: ViewState) {}
    
    func resetViews() {}
    
    func displayImages(with viewModel: GalleryViewModel) {
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.photosUrlList.count == 2)
        showGalleryImages = true
    }
    
    func insertImages(with viewModel: GalleryViewModel, at indexPaths: [IndexPath]) {
    }
   
}


final class GalleryRouterMock: GalleryRouterInput {

    weak var viewController: UIViewController?
    var showPageDetailsCalled = false
    
    func showPhotoDetails(with currentIndex: Int, delegate: PageDeletePhotoDelegate, viewModel: PageDetailViewModel) {
        showPageDetailsCalled = true

    }
    
}
