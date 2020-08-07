//
//  EndPoints.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let MainStoryboard = "Main"
let DetailViewControllerIdentifier = "DetailViewController"

struct  EndPoints{
    static let dataURL = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
}
