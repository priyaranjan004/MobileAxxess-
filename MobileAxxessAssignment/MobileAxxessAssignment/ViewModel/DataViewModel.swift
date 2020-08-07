//
//  DataViewModel.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
class DataViewModel {
    var httpClient:HttpClient?
    var isAsscending = false
    var dataString = ""
    var sortKey = 0
    let dbManager = DBManager()
    var callForUpdate = {()->Void in }
    var allData:[ListData]? {
        didSet{
            callForUpdate()
        }
    }
    init(httpClient:HttpClient) {
        self.httpClient = httpClient
    }
    
    //MARK: - API call to get data list
    func getAllDataFromAPI(){
        if let url = URL(string: EndPoints.dataURL){
            httpClient?.get(url: url, resultType: [ListData].self, completion: { (listDataArray, message) in
                if listDataArray != nil{
                    self.allData = listDataArray
                    DispatchQueue.main.async {
                        self.clearOldData()
                        self.saveListDataInDatabase()
                    }
                }
            })
        }
    }
    
    func getDataString(at index:Int)->String{
        return self.allData?[index].data ?? ""
    }
    
    func sortData(){
        if(sortKey == 0){
            let sortedData = allData?.sorted(by: { $0.type.rawValue < $1.type.rawValue})
            allData = sortedData
            sortKey = 1
        }else if(sortKey == 1){
            let sortedData = allData?.sorted(by: { $0.type.rawValue > $1.type.rawValue})
            allData = sortedData
            sortKey = 0
        }
    }
    
    func getNumberOfRows()->Int{
        if let dataList = allData{
            return dataList.count
        }
        return 0
    }
    func getSelectdAt(index:Int)->ListData{
        return allData![index]
    }
}


extension DataViewModel{
    //MARK: - DB Operations
    
    //Insert data in db
    fileprivate func saveListDataInDatabase(){
        DispatchQueue.main.async {
            if let dataList = self.allData{
                for data in dataList{
                    self.dbManager.saveListData(data: data)
                }
            }
        }
    }
    
    func getAllDataFromDB() {
        allData = dbManager.geAllData()
    }
   fileprivate func clearOldData(){
        dbManager.clearData()
    }
}
