//
//  NetwrokService.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import Foundation
import UIKit

protocol NetworkService {
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: NetworkAPIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
    
    @discardableResult
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDownloadTask
}
