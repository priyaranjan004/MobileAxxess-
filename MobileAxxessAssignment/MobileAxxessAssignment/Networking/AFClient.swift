//
//  AFClient.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 06/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
import Alamofire
class AFClient {
    //MARK: - Write methods for get post with parameters usinf alamofire at here
    func get<T: Codable>(url: URL, resultType: T.Type, completion:@escaping(_ result: T?, _ message: String?) -> Void) {
        AF.request(url).responseData { (response) in
            do {
                if let localData = response.data {
                    let result = try JSONDecoder().decode(T.self, from: localData)
                    completion(result, nil)
                }
                if let err = response.error {
                    completion(nil, err.localizedDescription)
                }
            } catch let err {
                completion(nil, err.localizedDescription)
            }
        }
    }
}
