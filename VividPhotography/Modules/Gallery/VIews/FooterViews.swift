//
//  FooterViews.swift
//  VividPhotography
//
//  Created by Sachin Sabat on 03/03/21.
//

import UIKit

final class FooterView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    private func setup() {
        backgroundColor = .appBackground()
        showSpinner()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                backgroundColor = .appBackground()
            }
        }
    }
}

