//
//  Order.swift
//  CupCakeCorner
//
//  Created by Mahmoud Fouad on 7/28/21.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    @Published var type = Type.vanilla
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet {
            if !oldValue {
                extraFrosting = !oldValue
                addSprinkles = !oldValue
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty ) ? false : true
    }
    
    var cost: Double {
        // $2 per cake
        var cakeCost = Double(quantity) * 2
        
        // complicated cakes cost more
        
        cakeCost += Double(type.rawValue) / 2
        
        // 1$ per cake for extra frosting
        if extraFrosting {
        cakeCost += Double(quantity)
        }
        
        // 0.5$ per cake for extra sprinkles
        if addSprinkles {
        cakeCost += Double(quantity) / 2
        }
        
        return cakeCost
    }

    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = Type(rawValue: try container.decode(Int.self, forKey: .type)) ?? Type.vanilla
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city =  try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    init() {
        
    }
}


enum Type: Int, CaseIterable {
    case vanilla = 0
    case strawberry
    case chooclate
    case rainbow
    
    init(type: Int) {
        switch type {
        case 0 : self = .vanilla
        case 1 : self = .strawberry
        case 2 : self = .chooclate
        case 3 : self = .rainbow
            
        default : self = .vanilla
        }
    }
    
    var text: String {
        switch self {
        case .vanilla    : return "Vanilla"
        case .strawberry : return "Strawberry"
        case .chooclate  : return "Chooclate"
        case .rainbow    :return "Rainbow"
        }
    }
}
