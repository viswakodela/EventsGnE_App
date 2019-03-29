//
//  CofermationCodeController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/22/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire

class ConfirmationCodeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismissal)))
    }
    
    var email: String?
    var password: String?
    var accessToken: String?
    
    let confirmationCodeLabel: UILabel = {
        
        let attributedText = NSMutableAttributedString(string: "Confirmation Code", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\nPlease enter the 8 digit code you receive in your email", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let enterCodeTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Code"
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let confirmCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleConfirmCodeButton), for: .touchUpInside)
        return button
    }()
    
    let didnotReceiveLabel: UILabel = {
        
        let attributedText = NSMutableAttributedString(string: "You didn't received? Please check your Spam Folder", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let sendAnotherButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send another Code", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.tintColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.addTarget(self, action: #selector(handleSendAnotherCode), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), confirmationCodeLabel, UIView(), UIView(), enterCodeTextField, confirmCodeButton, UIView(), didnotReceiveLabel, sendAnotherButton, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        confirmCodeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    
    
    @objc func handleConfirmCodeButton() {
        
        if let text = enterCodeTextField.text {
            if text.count > 6 || text.count < 6 {
                print("Not enough code")
            } else {
                
                if let email = self.email, let password = self.password, let code = enterCodeTextField.text {
                    
                    //Code Verification for signUp
                    APIService.shared.verificationCodeforSignUp(email: email, passwod: password, verificationCode: code, completion: { [weak self] (value, user, alert) in
                        
                        if alert != nil {
                            self?.present(alert!, animated: true, completion: nil)
                            return
                        }
                        
                        if value == "true" {
                            let userDetails = UserDetailsController()
                            userDetails.user = user
                            UserDefaults.standard.saveUser(user: user!)
                            userDetails.collectionView.reloadData()
                            self?.navigationController?.pushViewController(userDetails, animated: true)
                        }
                    })
                } else if self.email != nil, let code = enterCodeTextField.text, let accessToken = self.accessToken {
                    
                    //Code verification for Forget password
                    APIService.shared.verifycodeForForgetPassword(email: email!, code: code, accessToken: accessToken) { [weak self] (alert, email, accessToken) in
                        
                        if email != nil, accessToken != nil {
                            self?.present(alert!, animated: true, completion: {
                                DispatchQueue.main.async {
                                    let changePassword = ChangePasswordController()
                                    changePassword.accessToken = accessToken
                                    changePassword.email = email
                                    self?.navigationController?.pushViewController(changePassword, animated: true)
                                }
                            })
                        } else {
                            self?.present(alert!, animated: true, completion: nil)
                        }
                    }
                } else {
                    print("Not enough Details")
                }
            }
        }
    }
    
    
    @objc func handleSendAnotherCode() {
        
        APIService.shared.forgetPassword(email: email!) { [weak self] (alert, _, _) in
            
            if alert != nil {
                self?.present(alert!, animated: true, completion:  nil)
            }
            
        }
    }
    
    @objc func handleKeyboardDismissal() {
        view.endEditing(true)
    }
}

