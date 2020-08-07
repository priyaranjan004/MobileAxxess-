//
//  DBManager.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 06/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import Foundation
import CoreData

class DBManager{
     //MARK: - Insert List data fetched from api
    func saveListData(data:ListData){
        let persistenContainer = APP_DELEGATE.persistentContainer
        persistenContainer.performBackgroundTask { (managedContext) in
            let listEntity = NSEntityDescription.entity(forEntityName: "ListDataEntity", in: managedContext)!
            let listData = NSManagedObject(entity: listEntity, insertInto: managedContext)
            listData.setValue(data.id, forKey: "id")
            listData.setValue(data.date, forKey: "date")
            listData.setValue(data.data, forKey: "data")
            listData.setValue(data.type.rawValue, forKey: "type")
            
            do{
                try managedContext.save()
            }catch let err {
                print("saving error \(err)")
            }
        }
    }
    
    //MARK: - fetch all list data
    func geAllData()->[ListData]{
        var allDataArray = [ListData]()
        let managedContext = APP_DELEGATE.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListDataEntity")
        let allData = try! managedContext.fetch(fetchRequest)
        for listData in allData{
            let localData = listData as! ListDataEntity
            let data = ListData(id: localData.id ?? "", type: TypeEnum(rawValue: localData.type ?? "text")!, date: localData.date, data: localData.data)
            allDataArray.append(data)
        }
        print(allDataArray)
        return allDataArray
    }
    
    //MARK: - DELETE All data
       func clearData(){
           let managedContext = APP_DELEGATE.persistentContainer.viewContext
           let listFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListDataEntity")
           let listArray = try! managedContext.fetch(listFetchRequest)
           for listData in listArray{
               managedContext.delete(listData as! NSManagedObject)
           }
           do{
               try managedContext.save()
           }catch let err {
               print("saving error \(err)")
           }
       }
    
    
}
