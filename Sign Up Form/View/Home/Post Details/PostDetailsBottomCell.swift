//
//  PostDetailsBottomCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/29/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostDetailsBottomCell: UICollectionViewCell {
    
    var eventDetails: EventDetails? {
        didSet {
            maxParticipantsAttributedString()
            takenAttributedString()
            dateAttributedString()
            timeLabelAttributedString()
            leftSpotsAttributedString()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let maxParticipantsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CALL", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.6, blue: 0.9843137255, alpha: 1)
        return button
    }()
    
    fileprivate func maxParticipantsAttributedString() {
        
        let maxParticipantsAttributedString = NSMutableAttributedString(string: "Max Participants: ", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6078431373, green: 0.6039215686, blue: 0.6039215686, alpha: 1)])
        maxParticipantsAttributedString.append(NSAttributedString(string: "\(eventDetails?.NbParticipants ?? 0)", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)]))
        maxParticipantsLabel.attributedText = maxParticipantsAttributedString
    }
    
    fileprivate func takenAttributedString() {
        
        let takenSeatsAttributedString = NSMutableAttributedString(string: "Taken: ", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6078431373, green: 0.6039215686, blue: 0.6039215686, alpha: 1)])
        takenSeatsAttributedString.append(NSAttributedString(string: "\(eventDetails?.NbParticipantsTaken ?? 0)", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)]))
        takenSeatsLabel.attributedText = takenSeatsAttributedString
    }
    
    fileprivate func dateAttributedString() {
        
        guard let eventDate = eventDetails?.EventDate else {return}
        
        let dateAttributedText = NSMutableAttributedString(string: "Date: ", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6078431373, green: 0.6039215686, blue: 0.6039215686, alpha: 1)])
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        newDateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatter.date(from: eventDate) {
            let realDate = newDateFormatter.string(from: date)
            dateAttributedText.append(NSAttributedString(string: realDate, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)]))
            dateLabel.attributedText = dateAttributedText
        }
    }
    
    fileprivate func timeLabelAttributedString() {
        
        let timeAttributedString = NSMutableAttributedString(string: "Time: ", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6078431373, green: 0.6039215686, blue: 0.6039215686, alpha: 1)])
        guard let eventDate = eventDetails?.EventDate else {return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        newDateFormatter.dateFormat = "HH:mm a"
        
        if let date = dateFormatter.date(from: eventDate) {
            let time = newDateFormatter.string(from: date)
            timeAttributedString.append(NSAttributedString(string: time, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)]))
            timeLabel.attributedText =  timeAttributedString
        }
        
    }
    
    fileprivate func leftSpotsAttributedString() {
        let leftAttributedString = NSMutableAttributedString(string: "Left: ", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6078431373, green: 0.6039215686, blue: 0.6039215686, alpha: 1)])
        leftAttributedString.append(NSAttributedString(string: "\(eventDetails?.NbParticipantsLeft ?? 0)", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)]))
        leftSeatsLabel.attributedText = leftAttributedString
    }
    
    func setupLayout() {
        
        let topStackView = UIStackView(arrangedSubviews: [maxParticipantsLabel, dateLabel])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.spacing = 10
        topStackView.axis = .horizontal
        
        maxParticipantsLabel.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.55).isActive = true
        
        let middleStackView = UIStackView(arrangedSubviews: [takenSeatsLabel, timeLabel])
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.spacing = 10
        middleStackView.axis = .horizontal
        
        takenSeatsLabel.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.55).isActive = true
        
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
