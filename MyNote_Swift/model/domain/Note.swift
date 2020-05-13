//
//  Note.swift
//  MyNote_Swift
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import Foundation

public class Note: NSObject, NSCoding {
    
    public var date:Date;
    public var content:String;
    
    public required init?(date: Date,content:String) {
        self.date = date;
        self.content=content;
    }
    
    override public init() {
        self.date = Date()
        self.content = ""
    }
    
    public required init?(coder: NSCoder) {
        self.date = coder.decodeObject(forKey: "date") as! Date
        self.content = coder.decodeObject(forKey: "content") as! String
    }
    
    // MARK: --实现NSCoding协议
    public func encode(with coder: NSCoder) {
        coder.encode(date, forKey: "date")
        coder.encode(content, forKey: "content")
    }
    
}
