//
//  UserDescriptionCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/18/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class UserDescriptionCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            self.descriptionDetailsLabel.text = user?.ProfileDescription
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    let desrciptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = #colorLiteral(red: 0.3397630453, green: 0.4180935621, blue: 0.7107003331, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionDetailsLabel: VerticalTopAlignLabel = {
        let label = VerticalTopAlignLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description will go here"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    func setupLayout() {
        
        let descriptionView = handlerForAddressCityDescriptionViews(headingLabel: desrciptionLabel, detailsLabel: descriptionDetailsLabel)
        
        addSubview(descriptionView)
        descriptionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
    }
    
    
    func handlerForAddressCityDescriptionViews(headingLabel: UILabel, detailsLabel: UILabel) -> UIView {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 1.5
        
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [headingLabel, detailsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        
        containerView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        return containerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
