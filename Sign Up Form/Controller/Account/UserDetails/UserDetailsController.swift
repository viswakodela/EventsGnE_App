//
//  UserProfileController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/15/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailsController: UICollectionViewController {
    
    private static let headerCellID = "headerCellID"
    private static let cityAddressCellID = "cityAddressCellID"
    private static let descriptionCellID = "descriptionCellID"
    
    var user: User?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationControllerSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.3397630453, green: 0.4180935621, blue: 0.7107003331, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.337254902, blue: 0.6784313725, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        
        fetchUser()
    }
    
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
    
    func fetchUser() {
        let user = UserDefaults.standard.savedUser()
        self.user = user
        self.collectionView.reloadData()
    }
    
    func setupCollectionView() {
        
        view.addSubview(activitySpinner)
        activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activitySpinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activitySpinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        navigationControllerSettings()
        collectionView.register(UserDetailsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserDetailsController.headerCellID)
        collectionView.register(UserDetailsCityAddressCell.self, forCellWithReuseIdentifier: UserDetailsController.cityAddressCellID)
        collectionView.register(UserDescriptionCell.self, forCellWithReuseIdentifier: UserDetailsController.descriptionCellID)
    }
    
    func navigationControllerSettings() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(handleEditButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handleUserSignout))
    }
    
    @objc func handleEditButton() {
        let updateController = UpdateUserController()
        updateController.user = self.user
        let navController = UINavigationController(rootViewController: updateController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handleUserSignout() {
        
        activitySpinner.startAnimating()
        
        UserDefaults.standard.removeImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activitySpinner.stopAnimating()
            UserDefaults.standard.removeUser()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UserDetailsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDetailsController.cityAddressCellID, for: indexPath) as! UserDetailsCityAddressCell
            cell.user = user
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDetailsController.descriptionCellID, for: indexPath) as! UserDescriptionCell
            cell.user = user
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserDetailsController.headerCellID, for: indexPath) as! UserDetailsHeaderCell
        headerCell.user = user
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
