//
//  PageDetailViewModel.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 05/03/21.
//

import Foundation

// Struct to delegate data to landing page.
//
struct PageDetailViewModel {
    var photo: [Photo]
    var index: Int
    
    init(_ _photo: [Photo], _index: Int) {
        photo = _photo
        index = _index
    }
}
