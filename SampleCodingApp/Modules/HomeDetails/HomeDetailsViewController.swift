//
//  HomeDetailsViewController.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

final class HomeDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var commentTextView: UITextView!
    
    var viewModel:HomeDetailViewModelProtocal?
    weak var coordinator:Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    private func updateData() {
        commentTextView.text = viewModel?.comment
    }

}
