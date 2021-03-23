//
//  HomeViewModel.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import Foundation

protocol HomeViewModelProtocal {
   var numberOfItems:Int {get}
   func fetchPosts()
   func getItem(for index:Int)-> (name:String, email:String, comment:String)
}

class HomeViewModel {
    
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
     this method called from outside to connect to server to get posts result
     Only integrated page = 1 currently
     */
    func fetchPosts() {
        let restClient = RestClient(baseUrl:Environment.baseUrl.rawValue, path:Path.posts.rawValue, params:"")
        service.fetchData(restClient:restClient, type:Item.self) { [weak self] (result )  in
            switch result {
            case .success(let items):
                self?.items = items
            case .failure(_):
                self?.items = nil
                self?.delegate?.showError()
            }
        }
    }
    
    /*
        this method will take index as input and return post name, email  and comment  as tupple if post exists for that index otherwise will return empty values.
     */
    func getItem(for index:Int)-> (name:String, email:String, comment:String) {
        guard let _items = items, _items.count > index else {
            return ("", "", "")
        }
        let item = _items[index]
        return (item.name, item.email, item.body)
    }
}
