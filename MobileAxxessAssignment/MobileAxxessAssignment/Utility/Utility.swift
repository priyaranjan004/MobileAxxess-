//
//  Utility.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Utility methods at here

func getViewController(idenfifier:String,storyboadName:String)->UIViewController{
    let storyBoard = UIStoryboard(name: storyboadName, bundle: Bundle.main)
    return storyBoard.instantiateViewController(identifier: idenfifier)
}
