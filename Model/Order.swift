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
