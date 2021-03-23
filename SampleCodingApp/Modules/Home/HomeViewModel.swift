//
//  HomeViewModel.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import Foundation

protocol HomeViewModelProtocal {
   var numberOfItems:Int {get}
   func getItems()
   func getItem(for index:Int)-> (name:String, email:String, comment:String)
}

final class HomeViewModel {
    
    weak private var delegate:HomeViewControllerProtocol!
    let service:Servicable!
    
    private var items:[Item]? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    /* Injecting Dependencies of delegate and service class ,
     Service class is default params */
    
    init(delegate:HomeViewControllerProtocol, service:Servicable = Service()) {
        self.delegate = delegate
        self.service = service
    }
    
}

extension HomeViewModel: HomeViewModelProtocal {
    var numberOfItems: Int {
        get {
            return items?.count ?? 0
        }
    }
    /*
     this method connect calls rest API to get data
     */
    func getItems() {
        let restClient = RestClient(baseUrl:Environment.baseUrl.rawValue, path:Path.posts.rawValue, params:"")
        service.fetchData(restClient:restClient, type:Item.self) { [weak self] (result)  in
            switch result {
            case .success(let items):
                self?.items = items
            case .failure(_):
                self?.items = nil
                DispatchQueue.main.async {
                    self?.delegate?.showError()
                }
            }
        }
    }
    
    /*
         params : index of type Int
         returns: tupple of name, email, comment
     */
    func getItem(for index:Int)-> (name:String, email:String, comment:String) {
        guard let _items = items, index >= 0, _items.count > index else {
            return ("", "", "")
        }
        let item = _items[index]
        return (item.name, item.email, item.body)
    }
}
