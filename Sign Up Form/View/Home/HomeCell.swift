//
//  HomeCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    
    var event: Event? {
        didSet {
            postTitleLabel.text = event?.Name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "star-trek-logo")
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()
    
    let postTitleLabel: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scrabble Night Marathon 3h Fun"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.allowsDefaultTighteningForTruncation = true
        label.textColor = UIColor(red: 29/255, green: 28/255, blue: 28/255, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    let postLevelLabel: CustomLabel =  {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Level:"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 11)
        label.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        return label
    }()
    
    let postAgeLimitLabel: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Age:"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 11)
        label.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        return label
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date:"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let priceLabel: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$10.00"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.allowsDefaultTighteningForTruncation = true
        return label
    }()
    
    let participentsLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 spots left"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.allowsDefaultTighteningForTruncation = true
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-heart-outline-100").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupLayout() {
        
        layer.cornerRadius = 16
        
        backgroundColor = .white
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 16
        layer.shadowOffset = .init(width: 0, height: 2)
        
        favoriteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        let bottomStackView = UIStackView(arrangedSubviews: [priceLabel, participentsLeftLabel, favoriteButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.spacing = 3
        bottomStackView.axis = .horizontal
        
        bottomStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [postImageView,postTitleLabel, postLevelLabel, postAgeLimitLabel, dateLabel, bottomStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        postImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.60, constant: -10).isActive = true
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    @objc func handleFavoriteButton() {
        print("Fav tapped")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
