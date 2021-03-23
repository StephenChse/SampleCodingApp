//
//  HomeDetailVeiwModel.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import Foundation

protocol HomeDetailViewModelProtocal {
    var comment:String { get set }
}
class HomeDetailViewModel: HomeDetailViewModelProtocal {
    var comment: String = ""
    
    init(comment:String?) {
        self.comment = comment ?? ""
    }
        
}
