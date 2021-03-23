//
//  Post.swift
//  CodingChallenge
//
//  Created by Stephen on  23/03/21..
//

import Foundation

struct ItemResult: Codable {
    let items:[Item]
}

struct Item: Codable {
    let postId:Int
    let name:String
    let email:String
    let body:String
}
