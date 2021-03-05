//
//  MockNetworkClient.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import Foundation
import UIKit
@testable import VividPhotography

final class NetworkClientMock: NetworkService {
    
    func dataRequest<T>(_ endPoint: NetworkAPIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask where T : Decodable {
        
        if case GalleryAPI.search(query: "Shiva", page: 1) = endPoint {
            
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            let json = try! JSONDecoder().decode(objectType, from: data)
            completion(Result.success(json))
            
        } else if case GalleryAPI.search(query: "Shiva", page: -1) = endPoint {
            
            completion(Result.failure(.invalidStatusCode(401)))
            
        } else if case GalleryAPI.search(query: "dfdfdf23", page: 1) = endPoint {
            
            completion(Result.failure(.emptyData))
        }
        return URLSessionDataTask()
    }
    
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDownloadTask {
        if url.absoluteString == "https://cdn.pixabay.com/photo/2018/02/05/12/43/deity-3132133_150.jpg" {
            let image = UIImage(color: .black)!
            completion(Result.success(image))
        } else {
            completion(Result.failure(.somethingWentWrong))
        }
        
        return URLSessionDownloadTask()
    }
}

