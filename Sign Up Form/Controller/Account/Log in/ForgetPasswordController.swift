//
//  ForgetPasswordController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/21/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPasswordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyBoardDismissal)))
    }
    
    let forgetPasswordLabel: UILabel = {
        
        let attributedText = NSMutableAttributedString(string: "Forget Password", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\nPlease enter your email address below and we will send you an email to change your password", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "email"
        tf.layer.cornerRadius = 5
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let sendEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send Email", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSendEmailButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let stackView = UIStackView(arrangedSubviews: [UIView(), forgetPasswordLabel, UIView(), emailTextField, UIView(), sendEmailButton, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
//        forgetPasswordLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sendEmailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    @objc func handleSendEmailButton() {
        if let email = emailTextField.text {
            
            if self.emailTextField.text == "" {
                let alert = UIAlertController(title: "Email field is empty", message: "Please enter your email", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                return
            }
            
            APIService.shared.forgetPassword(email: email) { [weak self] (alert, email, accessToken) in
                
                if email != nil, accessToken != nil, alert != nil {
                    self?.present(alert!, animated: true, completion: {
                        DispatchQueue.main.async {
                            let confimationController = ConfirmationCodeController()
                            confimationController.email = email
                            confimationController.accessToken = accessToken
                            self?.navigationController?.pushViewController(confimationController, animated: true)
                            return
                        }
                    })
                } else {
                    self?.present(alert!, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    
    @objc func handleKeyBoardDismissal() {
        view.endEditing(true)
    }
    
}
