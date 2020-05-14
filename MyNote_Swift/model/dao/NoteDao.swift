//
//  NoteDao.swift
//  MyNote_Swift
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import Foundation

let DB_FILE_NAME = "NotesList.sqlite3"

//sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK
//if sqlite3_step(statement) != SQLITE_DONE
// while sqlite3_step(statement) == SQLITE_ROW
//if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK{
// if sqlite3_open(cpath!, &db) != SQLITE_OK {

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
    
    public func insert(_ note:Note!){
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        openSqlite {
            let sql = "INSERT OR REPLACE INTO Note (cdate,content) VALUES (?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK{
                let date = self.dateFormatter.string(from: note.date as Date)
                let content = note.content
                
                let cDate = date.cString(using: String.Encoding.utf8)
                let cContent = content.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cDate, -1, nil)
                sqlite3_bind_text(statement, 2, cContent, -1, nil)
                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE{
                    NSLog("插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
    }
    public func quaryAll() -> NSMutableArray{
        let listData = NSMutableArray()
        openSqlite {
            let sql = "SELECT cdate,content FROM Note"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                //执行查询
                while sqlite3_step(statement) == SQLITE_ROW {
                    let note = Note()
                    if let cdata = getColumnValue(index: 0, stmt: statement!){
                        let date : Date = self.dateFormatter.date(from: cdata)!
                        if date != nil {
                             note.date = date
                        }
                       
                    }
                    if let cContent = getColumnValue(index: 1, stmt: statement!){
                        note.content = cContent
                    }
                    listData.add(note)
                }
            }
            sqlite3_finalize(statement)
        }
        return listData
    }
    public func update(note:Note!){
        openSqlite {
            let sql = "UPDATE Note set content=? where cdate=?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                let cDate = (self.dateFormatter.string(from: note.date)).cString(using: String.Encoding.utf8)
                let cContent = note.content.cString(using: String.Encoding.utf8)
                
                //绑定数据
                sqlite3_bind_text(statement, 1, cContent, -1, nil)
                sqlite3_bind_text(statement,2, cDate, -1, nil)
                //执行修改数据
                if sqlite3_step(statement) != SQLITE_DONE {
                    NSLog("修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
    }
    
    public func delete(note:Note!){
        openSqlite {
            let sql = "DELETE from Note where cdate=?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                let cDate = (self.dateFormatter.string(from: note.date)).cString(using: String.Encoding.utf8)
                
                //绑定数据
                sqlite3_bind_text(statement, 1, cDate, -1, nil)
                //执行修改数据
                if sqlite3_step(statement) != SQLITE_DONE {
                    NSLog("修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
    }
    
    private func openSqlite(block:(() -> Void)){
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            block()
        }
        sqlite3_close(db)
    }
    
    //获得字段数据
    private func getColumnValue(index:CInt, stmt:OpaquePointer)->String? {
        if let ptr = UnsafeRawPointer.init(sqlite3_column_text(stmt, index)) {
            let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
            let txt = String(validatingUTF8:uptr)
            return txt
        }
        return nil
    }
}
