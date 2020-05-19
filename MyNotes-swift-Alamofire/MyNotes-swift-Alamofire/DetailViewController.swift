//
//  DetailViewController.swift
//  MyNotes-swift-Alamofire
//
//  Created by 俊杰李 on 2020/5/19.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textVIew: UITextView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let note = detailItem {
            if let label = textVIew {
                label.text = note["Content"] as? String
            }
        }
    }
    @IBAction func save(_ sender: Any) {
        if let label = textVIew {
            let content = label.text
            if content != detailItem?["Content"] as? String {
                let strURL = "http://www.51work6.com/service/mynotes/WebService.php";
                let params: Parameters = ["email":"l536510961@126.com",
                                          "type":"JSON",
                                          "action":"modify",
                                          "date":detailItem?["CDate"] ?? "",
                                          "content":content ?? "",
                                          "id":detailItem?["ID"] ?? ""];
                AF.request(strURL,method: .post ,parameters: params).validate(statusCode: 200..<300)
                    .validate(contentType:["application/json"]) .responseJSON { response in
                        switch response.result{
                        case.success:
                            let data = response.value as! NSDictionary
                            let code = data["ResultCode"] as! NSNumber
                            
                            var msg = "修改成功"
                            if(code.intValue < 0){
                                msg = code.errorMessage
                            }
                            NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                            self.showAleter(msg:msg,true)
                            break
                        case.failure:
                            self.showAleter(msg:"修改失败")
                            break
                        }
                }
            }
        }
    }
    func showAleter(msg:String,_ close:Bool = false){
        let controller =  UIAlertController(title: "修改提示", message: msg, preferredStyle: UIAlertController.Style.alert)
        let actionOK =  UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            if close {
                self.dismiss(animated: true)
            }
        }
        controller.addAction(actionOK)
        present(controller, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    func fackClose(){

    }
    var detailItem: NSDictionary? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
}

