//
//  FlashCardDatabaseManager.swift
//  Jouzu
//
//  Created by Johann Diedrick on 4/2/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import Foundation

let sharedInstance = FlashCardDatabaseManager()

class FlashCardDatabaseManager{
    
    var database : FMDatabase? = nil

    
    class var instance : FlashCardDatabaseManager{
        let path = NSBundle.mainBundle().pathForResource("japanese", ofType:"sqlite")
        println("path: \(path)")
        sharedInstance.database = FMDatabase(path: path)
        return sharedInstance
    }
    
    func addCallAndResponse()->Bool{
        if !sharedInstance.database!.open(){
            println("unable to open database")
            return false
        }else{
            println("opened database")
            let sql_stmt = "CREATE TABLE IF NOT EXISTS japanese (ID INTEGER PRIMARY KEY AUTOINCREMENT, call TEXT, response TEXT)"
            if !sharedInstance.database!.executeStatements(sql_stmt) {
                println("Error: \(sharedInstance.database!.lastErrorMessage())")
                return false

            }else{
                sharedInstance.database!.close()
                return true
            }
        }
    }
    
    func getCallAndResponse()->FMResultSet?{
        var rs : FMResultSet
        if !sharedInstance.database!.open(){
            println("unable to open database")
            return nil
        }else{
            if let rs = sharedInstance.database!.executeQuery("select call, response from japanese", withArgumentsInArray: nil) {
                    println(rs)
                    return rs
        }   else {
            println("select failed: \(sharedInstance.database!.lastErrorMessage())")
            return nil
            }
        }
    }
}