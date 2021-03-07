//
//  GalleryPageVC.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import UIKit


final class PagePhotoDetailViewController: UIViewController, BaseViewInput {
  
    var index: Int = 0
    var imageURL: URL?
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(photoImageView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        photoImageView.centerInSuperView()
        photoImageView.widthAnchor.constraint(equalToConstant: Constants.screenWidth - Constants.defaultPadding).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: Constants.screenWidth - Constants.defaultPadding).isActive = true
        
        if let imageURL = imageURL {
            renderView(with: imageURL)
        }
    }
    
    func renderView(with imageUrl: URL) {
        ImageDownloader.shared.downloadImage(withURL: imageUrl, size: view.bounds.size) { [weak self] (image, _, _, error) in
            DispatchQueue.main.async {
                guard let photoImageView = self?.photoImageView, let image = image else {
                    return
                }
                photoImageView.fadeTransition(with: image)
            }
        }
    }
    
}
