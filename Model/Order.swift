//
//  Order.swift
//  CupCakeCorner
//
//  Created by Mahmoud Fouad on 7/28/21.
//

import SwiftUI

class Order: ObservableObject {
    
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
