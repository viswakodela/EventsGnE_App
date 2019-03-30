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
    
    let postImagesController = PostDetailsImageCell()
    
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
        collectionView.register(PostDetailsImageCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: postImagesCellID)
        collectionView.register(PostEventDetailsCell.self, forCellWithReuseIdentifier: postTitleCellID)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var changeY = scrollView.contentOffset.y / 130
//        var width = view.frame.width + changeY * 2
//        width = max(width, view.frame.width)
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postTitleCellID, for: indexPath) as! PostEventDetailsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = PostEventDetailsCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: .greatestFiniteMagnitude))
        cell.layoutIfNeeded()
        let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: .greatestFiniteMagnitude))
        return CGSize(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: postImagesCellID, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height * 0.35
        return CGSize(width: width, height: height)
    }
    
}
