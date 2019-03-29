//
//  AccessToken.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/16/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

struct AccesToken: Codable {
    let access_token: String
    let token_type: String
}


struct User: Codable {
    let ID: Int
//    var UserName: String?
    var FirstName: String
    var LastName: String
    let Email: String
    var Address: String?
    var City: String?
    var MainPhoto: String?
    var ProfileDescription: String?
    var Rate: Int?
    var MainPhotoImage: String?
    var IsProfileVerified: Bool?
    var HasPassword: Bool?
    var FacebookId: Int?
}

struct FBUser: Codable {
    let MainUser: User
}
