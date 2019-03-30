//
//  Event.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/27/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

struct Event: Codable, Equatable {
    
    let ID: Int
    let Name: String
    var Address: String
//    var Category: String
//    var Description: String?
    var EntranceFee: Decimal
//    var EventCategory: String
    var EventDate: String
    var NbParticipantsTaken: Int?
    var NbParticipantsLeft: Int?
//    var IsFavorited: Bool
//    var Latitude: Double
//    var Longitude: Double
    var Level: String
    var MainEventPhoto: String?
//    var PhoneNumber: String
//    var EventPhotoCollection: [String]?
    
}

//struct Event: Codable, Equatable {
//
//    let ID: Int
//    let Name: String
//    var Address: String
//    var Category: Int
//    var Description: String?
//    var EntranceFee: Decimal
//    var EventCategory: Int
//    var EventDate: String
//    var IsFavorited: Bool
//    var Latitude: Double
//    var Longitude: Double
//    var Level: String
//    var MainEventPhoto: String?
//    var PhoneNumber: String?
//    var EventPhotoCollection: [String]?
//
//}
