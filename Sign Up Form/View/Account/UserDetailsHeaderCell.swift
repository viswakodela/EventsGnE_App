//
//  UserDetailsHeaderCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/18/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class UserDetailsHeaderCell: UICollectionReusableView {
    
    var user: User? {
        didSet {
            
            ratingsLabel.text = "\(user?.Rate ?? 0) rating"
            
            let image = UserDefaults.standard.fetchImage()
            if image != nil {
                userImageView.image = image
                if userImageView.image == nil {
                    userImageView.image = #imageLiteral(resourceName: "icons8-user-100-2")
                }
            } else {
                guard let imageUrl = user?.MainPhoto, let url = URL(string: imageUrl) else {return}
                userImageView.sd_setImage(with: url)
                
                if userImageView.image == nil {
                    userImageView.image = #imageLiteral(resourceName: "icons8-user-100-2")
                }
            }
            
            if let user = self.user {
                let attributedText = NSMutableAttributedString(string: user.FirstName, attributes: [:])
                attributedText.append(NSAttributedString(string: " \(user.LastName)", attributes: [:]))
                userNameLabel.attributedText = attributedText
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3397630453, green: 0.4180935621, blue: 0.7107003331, alpha: 1)
        return view
    }()
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 50
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return iv
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    func setupLayout() {
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let imageStackView = UIStackView(arrangedSubviews: [UIView(), userImageView, UIView()])
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.spacing = 5
        imageStackView.axis = .horizontal
        
        
        let stackView = UIStackView(arrangedSubviews: [imageStackView, userNameLabel, ratingsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
//        userNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        containerView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: frame.width - 64).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
