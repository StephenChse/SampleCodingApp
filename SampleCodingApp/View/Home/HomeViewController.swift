//
//  ViewController.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

protocol HomeViewControllerProtocol: class {
    func updateUI()
    func showError()
}

class HomeViewController: UIViewController,Storyboarded {

    @IBOutlet weak var tableView: UITableView!

    var homeViewModel:HomeViewModelProtocal!
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func updateUI() {
        
    }
    
    func showError() {
        
    }
}

