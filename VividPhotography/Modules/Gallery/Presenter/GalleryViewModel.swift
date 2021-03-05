//
//  GalleryViewModel.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation

struct GalleryViewModel {
    var photosUrlList: [Photo] = []
    
    var isEmpty: Bool {
        return photosUrlList.isEmpty
    }
    
    var totalCount: Int {
        return photosUrlList.count
    }
    
    init(urlList: [Photo]) {
        photosUrlList = urlList
    }
    
    mutating func appendPhotodUrlList(with urlList: [Photo]) {
        photosUrlList += urlList
    }
}

extension GalleryViewModel {
    func photoUrlAt(_ index: Int) -> Photo {
        guard !photosUrlList.isEmpty else {
            fatalError("No URL found")
        }
        return photosUrlList[index]
    }
    
    @discardableResult
    mutating func deletephotoUrlAt(_ index: Int) -> Photo {
        guard !photosUrlList.isEmpty else {
            fatalError("No URL Found")
        }
        return photosUrlList.remove(at: index)
    }
}
