//
//  Network.swift
//  CupCakeCorner
//
//  Created by Mahmoud Fouad on 7/30/21.
//

import Foundation

struct Network {
    
    func makeRequest(with url: String, order: Order, completion: @escaping (Order)-> Void) {
        guard let encoded = try? JSONEncoder().encode(order) else  {
            print("Failed to encode ...")
            return
        }
        guard let url = URL(string: url) else  { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "Post"
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard let data = data else { return }
            
            if let decoderData = try? JSONDecoder().decode(Order.self, from: data) {
                completion(decoderData)
            } else {
                print("Invalid response from server ")
            }
            
        }
        .resume()
        
    }
}
