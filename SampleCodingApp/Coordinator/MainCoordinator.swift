//
//  MainCoordinator.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import Foundation
import UIKit

protocol Coordinator:class {
    var navigationController: UINavigationController { get set }
    func start()
    func homeDetails(comment:String)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        vc.homeViewModel = HomeViewModel(delegate:vc)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func homeDetails(comment:String) {
        let vc = HomeDetailsViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = HomeDetailViewModel(comment:comment)
        navigationController.pushViewController(vc, animated: true)
    }
}
