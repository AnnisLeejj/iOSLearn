//
//  NoteDao.swift
//  MyNote_Swift
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import Foundation

let DB_FILE_NAME = "NotesList.sqlite3"

public class NoteDao{
    private var db:OpaquePointer? = nil
    
    //私有DateFormatter属性
    private var dateFormatter = DateFormatter()
    //私有沙箱目录中属性列表文件路径
    private var plistFilePath: String!
    
    public static let sharedInstance :NoteDao = {
        let instance = NoteDao()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        return instance
    }()
    
    private func applicationDocumentsDirectoryFile() -> String {
        //           let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        //           let path = (documentDirectory[0] as AnyObject).appendingPathComponent(DB_FILE_NAME) as String
        //           return path
        let documentDirectory:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent(DB_FILE_NAME) as String
        return path
    }
    
    //初始化文件
       private func createEditableCopyOfDatabaseIfNeeded() {
           
           let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
           
           if sqlite3_open(cpath!, &db) != SQLITE_OK {
               NSLog("数据库打开失败。")
           } else {
               let sql = "CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT)"
               let cSql = sql.cString(using: String.Encoding.utf8)
               
               if (sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK) {
                   NSLog("建表失败。")
               }
           }
           sqlite3_close(db)
       }
    
    
    
    
    
    
}
