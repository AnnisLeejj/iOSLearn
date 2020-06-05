//
//  AddViewController.swift
//  MyNotes-swift-Alamofire
//
//  Created by 俊杰李 on 2020/5/19.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import UIKit
import Alamofire
class AddViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let mContent =  textView.text
        
        saveNote( mContent ?? "")
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true );
    }
    
    func saveNote(_ content:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date =  Date()
        let dateStr = dateFormatter.string(from: date )
        
        let strURL = "http://www.51work6.com/service/mynotes/WebService.php";
        let params: Parameters = ["email":"l536510961@126.com","type":"JSON","action":"add","date":dateStr,"content":content]
        
        AF.request(strURL,method: .post,parameters: params    )
//            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.showSuccess()
                case let .failure(error):
                    print(error)
                }
        }
    }
    
    func showSuccess(){
        let controller = UIAlertController(title: "添加信息", message: "添加成功", preferredStyle: UIAlertController.Style.alert)
        controller.addAction(   UIAlertAction(title: "OK", style: UIAlertAction.Style.default){action in
            NotificationCenter.default.post(name:Notification.Name( "reload"), object: nil)
            self.dismiss(animated: true );
        })
        present(controller, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
