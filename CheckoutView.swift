//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Mahmoud Fouad on 7/28/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        
                    }
                    .padding()
                }
            }
        }.navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
