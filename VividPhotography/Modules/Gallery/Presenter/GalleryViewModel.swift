//
//  GalleryViewModel.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation

struct GalleryViewModel {
    var photosUrlList: [URL] = []
    
    var isEmpty: Bool {
        return photosUrlList.isEmpty
    }
    
    var totalCount: Int {
        return photosUrlList.count
    }
    
    init(urlList: [URL]) {
        photosUrlList = urlList
    }
    
    mutating func appendPhotodUrlList(with urlList: [URL]) {
        photosUrlList += urlList
    }
}

extension GalleryViewModel {
    func photoUrlAt(_ index: Int) -> URL {
        guard !photosUrlList.isEmpty else {
            fatalError("No URL found")
        }
        return photosUrlList[index]
    }
}
