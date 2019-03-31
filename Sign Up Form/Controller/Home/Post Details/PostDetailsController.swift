//
//  PostDetailsController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class PostDetailsController: UIViewController {
    
    private let postImagesCellID = "postImagesCellID"
    private let postTitleCellID = "postTitleCellID"
    private let postBottomCellID = "postBottomCellID"
    
    
    var eventDetails: EventDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        navigationController?.navigationBar.tintColor = .white
        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = StreatchyHeaderLayout()
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.delegate = self
        collView.dataSource = self
        return collView
    }()
    
    func setupCollectionView() {
        
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        
        guard let navBarHeight = navigationController?.navigationBar.frame.size.height else {return}
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        collectionView.contentInsetAdjustmentBehavior = .never
        let heightInset = (tabBarController?.tabBar.frame.height)! + 10
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: heightInset, right: 0)
        collectionView.register(PostDetailsImageCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: postImagesCellID)
        collectionView.register(PostEventDetailsCell.self, forCellWithReuseIdentifier: postTitleCellID)
        collectionView.register(PostDetailsBottomCell.self, forCellWithReuseIdentifier: postBottomCellID)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var changeY = scrollView.contentOffset.y / 130
        
        if changeY > 1 {
            changeY = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        } else {
            self.navigationController?.navigationBar.backgroundColor = .clear
            UIApplication.shared.statusBarView?.backgroundColor = .clear
        }
    }
}


extension PostDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postTitleCellID, for: indexPath) as! PostEventDetailsCell
            cell.eventDetails = eventDetails
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postBottomCellID, for: indexPath) as! PostDetailsBottomCell
            cell.eventDetails = eventDetails
            cell.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func callButtonTapped() {
        if let phone = eventDetails?.PhoneNumber {
            phone.makeAColl()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            
            let cell = PostEventDetailsCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: .greatestFiniteMagnitude))
            cell.eventDetails = eventDetails
            cell.layoutIfNeeded()
            let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: .greatestFiniteMagnitude))
            return CGSize(width: view.frame.width, height: estimatedSize.height)
        } else {
            return CGSize(width: view.frame.width, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: postImagesCellID, for: indexPath) as! PostDetailsImageCell
        header.swipingPage.eventDetails = eventDetails
        header.swipingPage.view.isUserInteractionEnabled = true
        header.swipingPage.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height * 0.35
        return CGSize(width: width, height: height)
    }
    
    @objc func handleTapGesture() {
        if let window = UIApplication.shared.keyWindow {
            
            let view = UIView()
            view.frame = window.frame
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .red
            print(view.frame)
            
            self.view.addSubview(view)
            view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
}
