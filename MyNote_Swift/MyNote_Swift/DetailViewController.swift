//
//  DetailViewController.swift
//  MyNote_Swift
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.content
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Note? {
        didSet {
            // Update the view.
            configureView()
        } 
    }


}

