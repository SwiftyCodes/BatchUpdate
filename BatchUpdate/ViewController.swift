//
//  ViewController.swift
//  BatchUpdate
//
//  Created by chetu on 5/30/19.
//  Copyright © 2019 chetu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.persistentContainer.persistentStoreDescriptions)
        insertData()
       // deleteAllRecords()
    }

    func insertData() {
        for i in 1...50000 {
            let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
            student.studentName = "\(Date())"
            student.studentRollNo = Int64(i)
        }
        appDelegate.saveContext()
    }
    
    //Using NSBatchDeleteRequest
    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func currentTimeMillis() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    //Traditional Approach
    func update() {
        
        let request:NSFetchRequest<Student> = Student.fetchRequest()
        do {
            
            let start = currentTimeMillis()
            let searchResults = try context.fetch(request)
            for student in searchResults {
                student.studentName = "Rajan"
            }
            appDelegate.saveContext()
            print("Difference is \(currentTimeMillis()-start)")
        } catch {
        }
    }
    
    //Using NSBatchUpdateRequest
    func updateWithBatch() {
        let request = NSBatchUpdateRequest(entityName: "Student")
        request.propertiesToUpdate = ["studentName":"Rajan Maheshwari"]
        request.resultType = .updatedObjectsCountResultType
        
        do {
            let start = currentTimeMillis()
            let result = try context.execute(request) as! NSBatchUpdateResult
            //Will print the number of rows affected/updated
            print(result.result!)
            print("Success")
            print("Difference is \(currentTimeMillis()-start)")
        }catch {
        }
    }
}

