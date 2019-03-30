//
//  PostDetailsBottomCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/29/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostDetailsBottomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let maxParticipantsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max Participants:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let takenSeatsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taken:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let leftSeatsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Left:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let joinTheEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Join the Event"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CALL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.462745098, blue: 0.7294117647, alpha: 1)
        return button
    }()
    
    func setupLayout() {
        
        let topStackView = UIStackView(arrangedSubviews: [maxParticipantsLabel, dateLabel])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.spacing = 10
        topStackView.axis = .horizontal
        
        maxParticipantsLabel.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.65).isActive = true
        
        let middleStackView = UIStackView(arrangedSubviews: [takenSeatsLabel, timeLabel])
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.spacing = 10
        middleStackView.axis = .horizontal
        
        takenSeatsLabel.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.65).isActive = true
        
        let alltogetherStackView = UIStackView(arrangedSubviews: [topStackView, middleStackView, leftSeatsLabel])
        alltogetherStackView.translatesAutoresizingMaskIntoConstraints = false
        alltogetherStackView.spacing = 10
        alltogetherStackView.axis = .vertical
        
        let bottomStackView = UIStackView(arrangedSubviews: [joinTheEventLabel, callButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.spacing = 10
        bottomStackView.axis = .vertical
        
        callButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let overAllStackView = UIStackView(arrangedSubviews: [alltogetherStackView, bottomStackView])
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        overAllStackView.axis = .vertical
        overAllStackView.spacing = 20
//        overAllStackView.alignment = .top
        
        addSubview(overAllStackView)
        overAllStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overAllStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        overAllStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        overAllStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
