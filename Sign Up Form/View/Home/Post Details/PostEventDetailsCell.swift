//
//  PostEventDetailsCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostEventDetailsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scrabble Night Marathon"
        label.font = UIFont(name: "HelveticaNeue", size: 24)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6221 Bay Mills Street, Toronto"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        return label
    }()
    
    let entrenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Entrence:"
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Level:"
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        return label
    }()
    
    let descriptionDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue. HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeueHelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeueHelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeueHelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeueHelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue HelveticaNeue"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "architecture-buildings-cars-1034662")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Viswajith Kodela"
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate func setupLayout() {
        
        let titleLocationStackView = UIStackView(arrangedSubviews: [postTitleLabel, addressLabel])
        titleLocationStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLocationStackView.axis = .vertical
        titleLocationStackView.spacing = 10
        
        let entrenceLevelStactView = UIStackView(arrangedSubviews: [entrenceLabel, levelLabel])
        entrenceLevelStactView.translatesAutoresizingMaskIntoConstraints = false
        entrenceLevelStactView.axis = .vertical
        entrenceLevelStactView.spacing = 10
        
        
        let userStackView = UIStackView(arrangedSubviews: [userImageView, userNameLabel])
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.axis = .vertical
        userStackView.spacing = 2
        userStackView.alignment = .center
        
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        userStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
//        userStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        userStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let middleStackView = UIStackView(arrangedSubviews: [entrenceLevelStactView, userStackView])
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.axis = .horizontal
        middleStackView.alignment = .top
//        middleStackView.spacing = 10
        
        let descriptionDetailsStackView = UIStackView(arrangedSubviews: [descriptionLabel, descriptionDetailsLabel])
        descriptionDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionDetailsStackView.axis = .vertical
        descriptionDetailsStackView.spacing = 5
        
        let overAllStackView = UIStackView(arrangedSubviews: [titleLocationStackView, middleStackView, descriptionDetailsStackView])
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        overAllStackView.axis = .vertical
        overAllStackView.spacing = 10
        
        addSubview(overAllStackView)
        overAllStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        overAllStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        overAllStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        overAllStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
