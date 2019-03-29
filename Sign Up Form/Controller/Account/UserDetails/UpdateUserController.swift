//
//  UpdateUserController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/16/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class UpdateUserController: UITableViewController {
    
    private static let updateUserCellID = "updateUserCellID"
    
    var user: User? {
        didSet {
            let image = UserDefaults.standard.fetchImage()
            
            if image != nil {
                userImageView.image = image
            } else {
                
                if user?.MainPhoto == nil {
                    self.userImageView.image = #imageLiteral(resourceName: "icons8-user-100-2")
                }
                
                guard let imageUrl = user?.MainPhoto, let url = URL(string: imageUrl) else {return}
                userImageView.sd_setImage(with: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.337254902, blue: 0.6784313725, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        checkPermission()
    }
    
    lazy var userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 50
        iv.isUserInteractionEnabled = true
//        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUserImageChange)))
        return iv
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .green
        
        header.addSubview(userImageView)
        userImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        userImageView.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        userImageView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        userImageView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        return header
    }()
    
    let activitySpinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.backgroundColor = .lightGray
        ai.hidesWhenStopped = true
        ai.layer.cornerRadius = 10
        ai.alpha = 0.4
        ai.color = .black
        return ai
    }()
    
    func setupLayout() {
        
        view.addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activitySpinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activitySpinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UpdateUserCell.self, forCellReuseIdentifier: UpdateUserController.updateUserCellID)
        navigationBarSetup()
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    func navigationBarSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        
        activitySpinner.startAnimating()
        
        APIService.shared.getAccessToken { [weak self] (accessToken) in
            
            let headers = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + accessToken]
            let params: Parameters = ["City" : self?.user?.City ?? "",
                                      "MainPhoto" : self?.user?.MainPhoto ?? "",
                                      "Rate" : self?.user?.Rate ?? "",
                                      "ProfileDescription" : self?.user?.ProfileDescription ?? "",
                                      "MainPhotoImage" : self?.user?.MainPhotoImage ?? "",
                                      "Address" : self?.user?.Address ?? "",
                                      "FirstName" : self?.user?.FirstName ?? "",
                                      "LastName" : self?.user?.LastName ?? "",
//                                      "UserName" : self.user?.UserName ?? "",
                                      "ID" : self?.user?.ID ?? 0,
                                      "Email" : self?.user?.Email ?? ""
                                      ]
            
            let saveProfileURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/SaveProfile"
            
            guard let user = self?.user else {return}
            UserDefaults.standard.saveUser(user: user)
            
            //MARK:- To update the user profile in the database
            Alamofire.request(saveProfileURL, method: .put, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseData { [weak self] (dataResp) in
                self?.activitySpinner.stopAnimating()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleFirstNameChange(textField: UITextField) {
        self.user?.FirstName = textField.text ?? "No Name"
    }
    
    @objc func handleLastNameChange(textField: UITextField) {
        self.user?.LastName = textField.text ?? "Nil"
    }
    
    @objc func handleAddressChange(textField: UITextField) {
        self.user?.Address = textField.text
    }
    
    @objc func handleCityChange(textField: UITextField) {
        self.user?.City = textField.text
    }
    
    @objc func handleDescriptionChange(textField: UITextField) {
        self.user?.ProfileDescription = textField.text
    }
    
    @objc func handleUserImageChange() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
}


//MARK:- Table view Delegate, Data source methods
extension UpdateUserController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateUserController.updateUserCellID, for: indexPath) as! UpdateUserCell
            cell.titleLabel.text = "Firstname"
            cell.inputTextField.placeholder = self.user?.FirstName
            cell.inputTextField.addTarget(self, action: #selector(handleFirstNameChange), for: .editingChanged)
            return cell
        } else if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateUserController.updateUserCellID, for: indexPath) as! UpdateUserCell
            cell.titleLabel.text = "Lastname"
            cell.inputTextField.placeholder = self.user?.LastName
            cell.inputTextField.addTarget(self, action: #selector(handleLastNameChange), for: .editingChanged)
            return cell
        } else  if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateUserController.updateUserCellID, for: indexPath) as! UpdateUserCell
            cell.titleLabel.text = "Address"
            cell.inputTextField.placeholder = self.user?.Address
            cell.inputTextField.addTarget(self, action: #selector(handleAddressChange), for: .editingChanged)
            return cell
        } else  if indexPath.item == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateUserController.updateUserCellID, for: indexPath) as! UpdateUserCell
            cell.titleLabel.text = "City"
            cell.inputTextField.placeholder = self.user?.City
            cell.inputTextField.addTarget(self, action: #selector(handleCityChange), for: .editingChanged)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateUserController.updateUserCellID, for: indexPath) as! UpdateUserCell
            cell.titleLabel.text = "Description"
            cell.inputTextField.placeholder = self.user?.ProfileDescription
            cell.inputTextField.addTarget(self, action: #selector(handleDescriptionChange), for: .editingChanged)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = view.frame.height * 0.25
        return height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = headerCellView()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    func headerCellView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.addSubview(userImageView)
        userImageView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        userImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        userImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        
        let addPhotoImageView = UIImageView()
        addPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoImageView.image = #imageLiteral(resourceName: "icons8-add-image-100")
        addPhotoImageView.isUserInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUserImageChange)))
        
        let transparentView = UIView()
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        transparentView.addSubview(addPhotoImageView)
        
        addPhotoImageView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor).isActive = true
        addPhotoImageView.centerYAnchor.constraint(equalTo: transparentView.centerYAnchor).isActive = true
        addPhotoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addPhotoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        userImageView.addSubview(transparentView)
        transparentView.topAnchor.constraint(equalTo: userImageView.topAnchor).isActive = true
        transparentView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor).isActive = true
        transparentView.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        return headerView
    }
}


//MARK:- Image picker Delegate methods
extension UpdateUserController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
//        let imageUrl = String(describing: fileUrl.lastPathComponent)
        self.user?.MainPhoto = fileUrl.lastPathComponent
        
        let imageData = editedImage?.jpegData(compressionQuality: 1)
        
        //Save image locally
        UserDefaults.standard.saveUserImage(imageData: imageData)
        
        let base64String = imageData?.base64EncodedString()
        
        self.user?.MainPhotoImage = base64String
        self.userImageView.image = editedImage
        
        dismiss(animated: true, completion: nil)
    }
}
