//
//  HttpClient.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation


class HttpClient{
    //MARK: - Generic method to handle get request
    func get<T: Codable>(url: URL, resultType: T.Type, completion:@escaping(_ result: T?, _ message: String?) -> Void) {
           URLSession.shared.dataTask(with: url) { (data, _, error) in
               do {
                   if let localData = data {
                       let result = try JSONDecoder().decode(T.self, from: localData)
                       completion(result, nil)
                   }
                   if let err = error {
                       completion(nil, err.localizedDescription)
                   }
               } catch let err {
                   completion(nil, err.localizedDescription)
               }
           }.resume()
       }
}
