//
//  ListData.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
struct ListData: Codable {
    let id: String
    let type: TypeEnum
    let date: String?
    let data: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
    case other = "other"
    case text = "text"
}

typealias ListDataArray = [ListData]
