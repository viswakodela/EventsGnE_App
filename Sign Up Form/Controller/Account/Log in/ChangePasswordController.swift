//
//  ChangePasswordController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/22/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    var email: String?
    var accessToken: String?
    var user: User?
    
    let newPasswordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "New password"
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let retypePasswordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Re-type new password"
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleNewPassword), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Change Password"
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), newPasswordTextField, retypePasswordTextField, changePasswordButton, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        changePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    
    @objc func handleNewPassword() {
        
        //When user Forgets his Password and wants to reset
        if let newPassword = newPasswordTextField.text,
            let retypedPassword = retypePasswordTextField.text,
            let email = self.email,
            let accessToken = self.accessToken {
            
            APIService.shared.enterNewPassword(newPassword: newPassword, retypedPassword: retypedPassword, email: email, accessToken: accessToken) { [weak self] (boolValue) in
                
                if boolValue != nil {
                    self?.navigationController?.popToRootViewController(animated: true)
                } else {
                    //Show alert saying that the password is not Strong or something like that.
                }
            }
        } else {
            
            //When user tries to login with the Facebook
            guard let email = user?.Email,
            let newPassword = newPasswordTextField.text,
            let retypedPassword = retypePasswordTextField.text else {return}
            
            APIService.shared.getAccessToken { (accessToken) in
                
                APIService.shared.enterNewPassword(newPassword: newPassword, retypedPassword: retypedPassword, email: email, accessToken: accessToken, completion: { [weak self] (boolValue) in
                    
                    if boolValue != nil {
                        self?.user?.HasPassword = true
                        let userDetails = UserDetailsController()
                        userDetails.user = self?.user
                        userDetails.collectionView.reloadData()
                        UserDefaults.standard.saveUser(user: (self?.user)!)
                        self?.navigationController?.pushViewController(userDetails, animated: true)
                    }
                })
            }
        }
    }
}
