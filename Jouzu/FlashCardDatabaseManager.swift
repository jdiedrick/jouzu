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
        //let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //let path = documentsFolder.stringByAppendingPathComponent("japanese.sqlite")
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("japanese.sqlite")

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
            
            /*
            if !sharedInstance.database!.executeUpdate("insert into japanese (call, response) values (?, ?)", withArgumentsInArray: ["thank you", "ありがとう" ]){
                println("failed to add to database")
                return false
            }else{
                if let rs = sharedInstance.database!.executeQuery("select call, response from japanese", withArgumentsInArray: nil) {
                    while rs.next() {
                        let x = rs.stringForColumn("call")
                        let y = rs.stringForColumn("response")
                      //  println("call = \(x); response = \(y);")
                    }
                } else {
                    println("select failed: \(sharedInstance.database!.lastErrorMessage())")
                }
                
                sharedInstance.database!.close()
                return true

            }
            */
        }
    }
    
    func getCallAndResponse()->FMResultSet?{
        var rs : FMResultSet
        if !sharedInstance.database!.open(){
            println("unable to open database")
            return nil
        }else{
            if let rs = sharedInstance.database!.executeQuery("select call, response from japanese", withArgumentsInArray: nil) {
                   return rs
        }   else {
            println("select failed: \(sharedInstance.database!.lastErrorMessage())")
            return nil
            }
        }
    }

    
}