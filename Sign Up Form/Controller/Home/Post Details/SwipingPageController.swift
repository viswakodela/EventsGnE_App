//
//  SwipingPageController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/30/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SwipingImageCell: UIPageViewController {
    
    
    var eventDetails: EventDetails! {
        didSet {
            
            if let photocollection = eventDetails.EventPhotoCollection {
                controllers = photocollection.map({ (imageUrl) -> UIViewController in
                    let photoController = PhotoController(imageUrl: imageUrl)
                    return photoController
                })
            setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        dataSource = self
        delegate = self
//        setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
    }
}

extension SwipingImageCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex { (controller) -> Bool in
            return controller == viewController
        }
        if index == 0 {return nil}
        return controllers[index! - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 {return nil}
        return controllers[index + 1]
    }
}











class PhotoController: UIViewController {
    
    let imageView = UIImageView()
    
    init(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
      print("Image Tapped")
        
        let imageView = gesture.view as! UIImageView
        
        let newImageView = UIImageView(image: imageView.image)
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(newImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
