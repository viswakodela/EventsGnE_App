//
//  PostDetailsImageCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostDetailsImageCell: UICollectionViewCell {
    
    let swipingPage = SwipingImageCell(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        
        guard let postImageView = swipingPage.view else {return}
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postImageView)
        postImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        postImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
