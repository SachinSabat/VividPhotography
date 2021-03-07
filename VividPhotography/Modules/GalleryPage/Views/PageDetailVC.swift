//
//  PageDetailVC.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 07/03/21.
//

import Foundation
import UIKit


final class PageVC: UIViewController {
    
    fileprivate enum LayoutConstants {
        static let buttonWidth: CGFloat = 100
        static let rightpadding: CGFloat = 20
        static let topPadding: CGFloat = 5
    }
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.setImage(UIImage(with: .Delete).withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    var presenter: GalleryPageDetailViewOutput!
    var galleryViewModel: PageDetailViewModel!
    var pageViewController = UIPageViewController()
    
    var currentViewController: PagePhotoDetailViewController {
        return self.pageViewController.viewControllers![0] as! PagePhotoDetailViewController
    }
    
    var currentIndex = 0
    var nextIndex: Int?
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        presenter.onViewDidLoad()
    }
    
    private func prepareView() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil)
        add(pageViewController)
        pageViewController.view.frame = view.frame
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        // Add Delete button on the view
        view.addSubview(deleteButton)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.rightpadding).isActive = true
        deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.topPadding).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
    }
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
        presenter.didTapDelete(index: currentIndex)
    }
}

extension PageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            return nil
        }
        guard let urlString = galleryViewModel.photo[currentIndex - 1].largeImageURL, let imageUrl = URL(string: urlString) else {
            return nil
        }
        let vc = PagePhotoDetailViewController()
        vc.index = currentIndex - 1
        vc.imageURL = imageUrl
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == galleryViewModel.photo.count - 1 {
            return nil
        }
        guard let urlString = galleryViewModel.photo[currentIndex + 1].largeImageURL, let imageUrl = URL(string: urlString) else {
            return nil
        }
        let vc = PagePhotoDetailViewController()
        vc.index = currentIndex + 1
        vc.imageURL = imageUrl
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first as? PagePhotoDetailViewController else {
            return
        }
        self.nextIndex = nextVC.index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed && self.nextIndex != nil) {
            self.currentIndex = self.nextIndex!
        }
        self.nextIndex = nil
    }
    
}

extension PageVC: GalleryPageViewInput{
    func renderView(with imageUrl: URL, index:Int, viewModel: PageDetailViewModel) {
        galleryViewModel = viewModel
        currentIndex = index
        guard let urlString = galleryViewModel.photo[index].largeImageURL, let imageUrl = URL(string: urlString) else {
            return
        }
        let vc = PagePhotoDetailViewController()
        vc.index = index
        vc.imageURL = imageUrl
        let viewControllers = [vc]
        self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
}
