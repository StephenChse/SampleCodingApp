//
//  ViewController.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
    }
}

