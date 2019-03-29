//
//  SignupController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/20/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire

class SignupController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    let firstNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "First name"
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    let lastNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Last name"
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    let yourEmailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "email"
        tf.layer.cornerRadius = 5
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let passwordTesxtField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "password"
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let retypePasswordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "re-type password"
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSignUpUser), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        
        let attributedText = NSMutableAttributedString(string: "You have an account?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        attributedText.append(NSAttributedString(string: " Login", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)]))
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleLoginPop), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Registration"
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), firstNameTextField, lastNameTextField, yourEmailTextField, passwordTesxtField, retypePasswordTextField, signUpButton, UIView(), UIView(), loginButton, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    @objc func handleSignUpUser() {
        
         if let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = yourEmailTextField.text,
            let password = passwordTesxtField.text,
            let repeatPassword = retypePasswordTextField.text {
            
            if password != repeatPassword {
                self.showAlert(text: "Something went wrong", message: "Entered passwords are nt same")
                return
            }
            
            APIService.shared.regidsterUserwith(firstName: firstName, lastName: lastName, email: email, password: password, repeatPassword: repeatPassword) { [weak self] (value) in
                
                if value == "true" {
                    print("User registration successfull...")
                    let confirmationPage = ConfirmationCodeController()
                    confirmationPage.email = email
                    confirmationPage.password = password
                    self?.navigationController?.pushViewController(confirmationPage, animated: true)
                } else {
                    print("User registration Failed")
                    self?.showAlert(text: "Registration Failed", message: "Please check your input fields")
                }
            }
        }
    }
    
    func showAlert(text: String, message: String) {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleLoginPop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismissKeyboard() {
        self.view.endEditing(true)
    }
}
