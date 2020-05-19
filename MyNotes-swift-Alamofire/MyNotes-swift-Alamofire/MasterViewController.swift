//
//  MasterViewController.swift
//  MyNotes-swift-Alamofire
//
//  Created by 俊杰李 on 2020/5/19.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import UIKit
import Alamofire
class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var notes:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新");
        rc.addTarget(self, action: #selector(loadNotes), for: UIControl.Event.valueChanged)
        self.refreshControl = rc;
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name("reload"), object: nil)
        loadNotes();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(true)
        self.loadNotes()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let note = notes[indexPath.row] as! NSDictionary
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = note
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = notes[indexPath.row] as! NSDictionary
        let content = object["Content"] as! String
        let date = object["CDate"] as! String
        
        cell.textLabel!.text = content
        cell.detailTextLabel!.text = date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = notes[indexPath.row] as! NSDictionary
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteNote(object)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func deleteNote(_ note:NSDictionary){
        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        let params:Parameters = ["email": "l536510961@126.com", "type": "JSON", "action": "remove","id":note["ID"] ?? "0"]
        AF.request(strURL,method: .post,parameters: params    )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.loadNotes()
                    break
                case let .failure(error):
                    print(error)
                    break
                }
                
        }
    }
    
    @objc func loadNotes(){
        if(self.refreshControl!.isRefreshing){
             self.refreshControl!.attributedTitle = NSAttributedString(string: "加载数据中...")
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible  = true
        print("查询列表.....")
        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        let params:Parameters  = ["email": "l536510961@126.com", "type": "JSON", "action": "query"]
        
        AF.request(strURL,method: .post,parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let data =  response.value as! NSDictionary
                    self.notes = data["Record"] as! NSArray
                    self.tableView.reloadData()
                case let .failure(error):
                    print(error)
                }
                self.refreshControl!.endRefreshing()
                self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
                 UIApplication.shared.isNetworkActivityIndicatorVisible  = false
        }
    }
}

