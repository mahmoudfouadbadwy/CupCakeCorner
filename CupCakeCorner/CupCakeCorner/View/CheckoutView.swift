//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Mahmoud Fouad on 7/28/21.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation =  false
    @ObservedObject var order: Order
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"),
                  message: Text(confirmationMessage),
                  dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
    
    private func placeOrder() {
        Network().makeRequest(with: "https://reqres.in/api/cupcakes",
                              order: order) {
            self.confirmationMessage = "Your order for \($0.quantity)x \($0.type.text.lowercased()) cupcakes is on its way"
            self.showingConfirmation = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
