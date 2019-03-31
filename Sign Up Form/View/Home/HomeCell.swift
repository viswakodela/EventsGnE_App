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
            priceLabel.text = "$\(String(describing: event?.EntranceFee ?? 0))"
            
            participantsLeftAttributedString()
            postAndAgeAttributedString()
            dateConvertion()
            
            guard let imageURL = event?.EventPhotoCollection?.first, let url = URL(string: imageURL) else {return}
            postImageView.sd_setImage(with: url)
        }
    }
    
    func postAndAgeAttributedString() {
        let postLevelAttributedString = NSMutableAttributedString(string: "Level: ", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 11)!, NSAttributedString.Key.foregroundColor : UIColor.gray])
        postLevelAttributedString.append(NSAttributedString(string: event?.Level ?? "N/A", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 11)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1490196078, green: 0.6, blue: 0.9843137255, alpha: 1)]))
        postLevelLabel.attributedText = postLevelAttributedString
        
        let ageAttributedString = NSMutableAttributedString(string: "Age: ", attributes: [NSMutableAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 11)!,
                NSAttributedString.Key.foregroundColor : UIColor.gray])
        ageAttributedString.append(NSAttributedString(string: "18", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 11)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1490196078, green: 0.6, blue: 0.9843137255, alpha: 1)]))
        postAgeLimitLabel.attributedText = ageAttributedString
        
    }
    
    func dateConvertion() {
        
        guard let eventDate = event?.EventDate else {return}
        
        let dateAttributedText = NSMutableAttributedString(string: "Date: ", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 10)!, NSAttributedString.Key.foregroundColor : UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)])
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        newDateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatter.date(from: eventDate) {
            let realDate = newDateFormatter.string(from: date)
            dateAttributedText.append(NSAttributedString(string: realDate, attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 10)!, NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
            dateLabel.attributedText = dateAttributedText
        }
    }
    
    func participantsLeftAttributedString() {
        if let spotsLeft = event?.NbParticipantsLeft {
            let participantsLeftAttributedString = NSMutableAttributedString(string: String(spotsLeft), attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.black])
            participantsLeftAttributedString.append(NSAttributedString(string: " spots left", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.gray]))
            participentsLeftLabel.attributedText = participantsLeftAttributedString
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
        iv.backgroundColor = .lightGray
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
