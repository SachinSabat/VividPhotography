//
//  GalleryPageVC.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 04/03/21.
//

import UIKit


final class PagePhotoDetailViewController: UIViewController, GalleryPageViewInput {

    var presenter: GalleryPageDetailViewOutput!
    
    fileprivate enum LayoutConstants {
        static let buttonWidth: CGFloat = 100
        static let rightpadding: CGFloat = 20
        static let topPadding: CGFloat = 5
    }
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.setImage(UIImage(with: .Delete).withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.onViewDidLoad()
    }
    
    private func setupViews() {
        view.addSubview(photoImageView)
        view.addSubview(deleteButton)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        photoImageView.centerInSuperView()
        photoImageView.widthAnchor.constraint(equalToConstant: Constants.screenWidth - Constants.defaultPadding).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: Constants.screenWidth - Constants.defaultPadding).isActive = true
        
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.rightpadding).isActive = true
        deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.topPadding).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
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
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
        presenter.didTapDelete()
    }
}
