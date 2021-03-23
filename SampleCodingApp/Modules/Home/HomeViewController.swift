//
//  HomeViewController.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

protocol HomeViewControllerProtocol: class {
    func updateUI()
    func showError()
}

final class HomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!

    var homeViewModel:HomeViewModelProtocal!  // ViewModel
    weak var coordinator: Coordinator?        // Coordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeViewModel.getItems()
        setupUI()
    }
    
    // MARK: Private Methods

    private func setupUI() {
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
    }
}

// MARK: UITableViewDataSource Methods

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"homeCell", for:indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let item = homeViewModel.getItem(for: indexPath.section)
        cell.setItemData(item:item)

        return cell
    }
}

// MARK: UITableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = homeViewModel.getItem(for: indexPath.section)
        coordinator?.homeDetails(comment: item.comment)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1 : 20 
    }
}

// MARK: HomeViewControllerProtocol Methods

extension HomeViewController: HomeViewControllerProtocol {
    func updateUI() {
        tableView.reloadData()
    }
    func showError() {
        self.showAlert()
    }
}
