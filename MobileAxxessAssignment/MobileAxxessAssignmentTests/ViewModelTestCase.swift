//
//  ViewModelTestCase.swift
//  MobileAxxessAssignmentTests
//
//  Created by Priya Ranjan on 06/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import XCTest
@testable import MobileAxxessAssignment

class ViewModelTestCase: XCTestCase {

    let viewModel = DataViewModel(httpClient: HttpClient())
    func test_GetAllDataFroApi(){
        let expec = expectation(description: "get data from api")
        viewModel.getAllDataFromAPI()
        viewModel.callForUpdate = {[weak self]() in
            expec.fulfill()
        }
        wait(for: [expec], timeout: 10)
    }
    
    func test_dataFectchFormDB(){
        viewModel.getAllDataFromDB()
        XCTAssert(viewModel.allData!.count>0, "data exist in db")
    }
    
    func test_DataGetAtIndex(){
        viewModel.getAllDataFromDB()
        let listData = viewModel.getSelectdAt(index: 0)
       // XCTAssertNil(listData)
        XCTAssertNotNil(listData)
    }

}
