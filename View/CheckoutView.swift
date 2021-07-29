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
        guard let encoded = try? JSONEncoder().encode(order) else  {
            print("Failed to encode ...")
            return}
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else  { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "Post"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard let data = data else { return }
            
            if let decoderData = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decoderData.quantity)x \(order.type.text.lowercased()) cupcakes is on its way"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server ")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
