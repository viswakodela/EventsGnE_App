//
//  UserDefaultsExtension.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/16/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    static let saveUserLocallyKey = "saveUserLocallyKey"
    static let imageDataKey = "imageData"
    
    func savedUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.saveUserLocallyKey) else {return nil}
        let user = try? JSONDecoder().decode(User.self, from: data)
        return user
    }
    
    func saveUser(user: User) {
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: UserDefaults.saveUserLocallyKey)
    }
    
    func removeUser(){
        UserDefaults.standard.removeObject(forKey: UserDefaults.saveUserLocallyKey)
    }
    
    func saveUserImage(imageData: Data?) {
        UserDefaults.standard.set(imageData, forKey: UserDefaults.imageDataKey)
    }
    
    func removeImage() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.imageDataKey)
    }
    
    func fetchImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.imageDataKey) else {return nil}
        if let image = UIImage(data: data) {
            return image
        } else {
            return nil
        }
    }
    
}
