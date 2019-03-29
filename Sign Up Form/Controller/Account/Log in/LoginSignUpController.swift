//
//  SignUpController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/14/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import FacebookLogin
import Alamofire

class LoginSignUpController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        checkIfUserSavedLocally()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyBoardDismiss)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.337254902, blue: 0.6784313725, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
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
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 8)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forget Password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.addTarget(self, action: #selector(handleForgetButton), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        
        let attributedText = NSMutableAttributedString(string: "You don't have account?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        attributedText.append(NSAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)]))
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        return button
    }()
    
    let loginWithFaceBookButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login or Sign Up with Facebook", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.4352941176, blue: 0.7019607843, alpha: 1)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleFacebookTapped), for: .touchUpInside)
        return button
    }()
    
    let activitySpinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.backgroundColor = .lightGray
        ai.alpha = 0.4
        ai.color = .black
        ai.hidesWhenStopped = true
        ai.layer.cornerRadius = 10
        return ai
    }()
    
    func checkIfUserSavedLocally() {
        let user = UserDefaults.standard.savedUser()
        if user != nil {
            let userDetails = UserDetailsController()
            userDetails.user = user
            userDetails.collectionView.reloadData()
            navigationController?.pushViewController(userDetails, animated: false)
            return
        }
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Join the Events GnE"
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), signInLabel, emailTextField, passwordTextField, loginButton, forgetPasswordButton, UIView(), UIView(), UIView(), signUpButton, UIView(), UIView(), UIView(), loginWithFaceBookButton, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
//        stackView.distribution = .fillEqually
        
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        loginWithFaceBookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        
        
        view.addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        activitySpinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activitySpinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func handleFacebookTapped() {
        self.FacebookLogin()
    }
    
    @objc func handleKeyBoardDismiss() {
        self.view.endEditing(true)
    }
    
    @objc func handleLoginButtonTapped() {
        APIService.shared.getAccessToken { [weak self] (accessToken) in
            self?.loginAuthenticationwithAccessToken(accessToken: accessToken)
        }
    }
    
    @objc func handleRegisterUser() {
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc func handleForgetButton() {
        
        let forgetPasswordController = ForgetPasswordController()
        navigationController?.pushViewController(forgetPasswordController, animated: true)
    }
    
    
    func loginAuthenticationwithAccessToken(accessToken: String) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        self.activitySpinner.startAnimating()
        APIService.shared.loginAuthenticationwithAccessToken(accessToken: accessToken, email: email, password: password) { [weak self] (user, err) in
            
            self?.activitySpinner.stopAnimating()
            
            if let error = err {
                print(error.localizedDescription)
                self?.showAlert(error: error)
                return
            }
            
            
            if user?.IsProfileVerified == false {
                let verificationController = ConfirmationCodeController()
                guard let email = self?.emailTextField.text else {return}
                guard let password = self?.passwordTextField.text else {return}
                verificationController.email = email
                verificationController.password = password
                self?.navigationController?.pushViewController(verificationController, animated: true)
            } else {
                let userDetailsController = UserDetailsController()
                userDetailsController.user = user
                
                UserDefaults.standard.saveUser(user: user!)
                self?.navigationController?.pushViewController(userDetailsController, animated: true)
            }
        }
    }
    
    //MARK: Actions
    func FacebookLogin() {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email ], viewController: self){
            loginResult in switch loginResult{
            case .failed(let error): print(error)
            case .cancelled: print("User canceled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getAccessToken()
            }
        }
    }
    
    func getAccessToken() {
        
        APIService.shared.getAccessToken { (accessToken) in
            self.facebookLogin(with: accessToken)
        }
    }
    
    func facebookLogin(with accessToken: String){
        APIService.shared.loginWithFacebook(accessToken: accessToken) { [weak self] (user, err) in
            
            if let error = err {
                self?.showAlert(error: error)
                return
            }
            
            if user?.HasPassword == false && user?.FacebookId != nil {
                let changePassword = ChangePasswordController()
                changePassword.user = user
                self?.navigationController?.pushViewController(changePassword, animated: true)
                return
            }
            
            UserDefaults.standard.saveUser(user: user!)
            let userDetails = UserDetailsController()
            userDetails.user = user
            userDetails.collectionView.reloadData()
            self?.navigationController?.pushViewController(userDetails, animated: true)
        }
    }
    
    func showAlert(error: Error?) {
        
        if error != nil {
            let alert = UIAlertController(title: "Something went wrong", message: error?.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            
            let alert = UIAlertController(title: "Something went wrong", message: "Bad username or password is incorrect.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
