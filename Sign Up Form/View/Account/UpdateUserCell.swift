//
//  UpdateUserCell.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/16/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class UpdateUserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let inputTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .right
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, inputTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
