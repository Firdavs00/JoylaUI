//
//  ProfileModel.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 24/11/21.
//

import Foundation

struct ProfileModel: Codable, Equatable, Identifiable, Hashable {

    var id: Int?
    var name: String?
    var description: String?
    var state: String?
    var lat: String?
    var lan: String?
    var createdAt: String?
    var imageMode: String?
    var imageUrl: String?
    var imagePath: String?
    var price: String?
    var currencyType: String?
    var createdBy: Int?
    var favoriteId: String?
    var destination: Double?
    var type: String?
}

