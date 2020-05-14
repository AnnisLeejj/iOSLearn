//
//  AddViewController.swift
//  MyNote_Swift
//
//  Created by 俊杰李 on 2020/5/14.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import UIKit
class AddViewController: UIViewController ,UITextViewDelegate{
//    private var textDelegate:UITextViewDelegate?
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    @IBAction func save(_ sender: Any) {
        let content = textView.text;
        let date = Date()
        
        let note = Note()
        note.date = date
        note.content = content!
        
        let dao = NoteDao.sharedInstance
        
        dao.insert(note)
        
        let notes = dao.quaryAll()
        
        NotificationCenter.default.post(name: Notification.Name("reaload"), object: notes)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
