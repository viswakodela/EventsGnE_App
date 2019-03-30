//
//  PostDetailsImageCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostDetailsImageCell: UICollectionViewCell {
    
    let postImagesController = PostImagesController()
    
    var event: Event? {
        didSet {
            guard let imageURL = event?.EventPhotoCollection?.first, let url = URL(string: imageURL) else {return}
            
            postImageView.sd_setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "star-trek-logo")
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()
    
    func setupLayout() {
        
        guard let postImagesView = self.postImagesController.view else {return}
        postImagesView.translatesAutoresizingMaskIntoConstraints = false
//
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        addSubview(containerView)
//        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
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
