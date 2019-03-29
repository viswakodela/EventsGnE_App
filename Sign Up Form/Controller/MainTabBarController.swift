//
//  ViewController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/14/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    var loginSignupController: LoginSignUpController?

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewControllers()
    }
    
    func addViewControllers() {
        
        view.backgroundColor = .white
        let homeController = HomeController()
        let homeTabBar = navController(title: "Home", image: #imageLiteral(resourceName: "icons8-home-page-100-2"), viewController: homeController)
        
        let eventsController = UIViewController()
        let eventsTabBar = navController(title: "Events", image: #imageLiteral(resourceName: "icons8-add-90"), viewController: eventsController)
        
        self.loginSignupController = LoginSignUpController()
        let loginSignUpController = navController(title: "Account", image: #imageLiteral(resourceName: "icons8-account-filled-100"), viewController: loginSignupController!)
        
        let user = UserDefaults.standard.savedUser()
        
        let userDetails = UserDetailsController()
        userDetails.user = user
        let userDetailTab = navController(title: "Account", image: #imageLiteral(resourceName: "icons8-account-filled-100"), viewController: userDetails)
        
        
        viewControllers = [homeTabBar, eventsTabBar, loginSignUpController]
//        if user == nil {
//            
//        } else {
//            viewControllers = [homeTabBar, eventsTabBar, userDetailTab]
//        }
        tabBar.tintColor = #colorLiteral(red: 0.2431372549, green: 0.337254902, blue: 0.6784313725, alpha: 1)
        
    }
}


extension MainTabBarController {
    
    func navController(title: String, image: UIImage, viewController: UIViewController = UIViewController()) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        viewController.navigationItem.title = title
        if viewController == self.loginSignupController || viewController == UserDetailsController() {
            let navController = CustomNavigationController(rootViewController: viewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            navController.navigationBar.prefersLargeTitles = false
            return navController
        } else {
            navController.navigationBar.prefersLargeTitles = true
        }
        return navController
    }
    
}

