//
//  MoreLikeModel.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 11/11/21.
//

import Foundation

struct MoreLikeModel: Codable,Equatable, Identifiable,Hashable {
    
    var id: Int?
    var name: String?
    var description: String?
    var state: String?
    var lat: String?
    var lan: String?
    var createdAt: String?
    var imageMode: String?
    var imageUrl: String?
    var price: String?
    var createdBy: Int?
    var currencyType: String?
    var favoriteId: Int?
    var destination: Double?
    var type: String?
    
    
}


