//
//  ImageCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "star-trek-logo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate func setupLayout() {
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
