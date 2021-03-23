//
//  HomeDetailViewModelTests.swift
//  SampleCodingAppTests
//
//  Created by Stephen on 23/03/21.
//

import XCTest
@testable import SampleCodingApp

class HomeDetailViewModelTests: XCTestCase {
    
    
    var viewModel:HomeDetailViewModel!
    var viewController:HomeDetailsViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         viewController = HomeDetailsViewController()
    }
    
    func testWhenCommentIsNotEmpty() {
        viewModel = HomeDetailViewModel(comment: "Test Comment")
        viewController.viewModel = viewModel
        XCTAssertNotNil(viewModel.comment)
        XCTAssertGreaterThan(viewModel.comment.count, 0, "comment is nil")
    }
    
    func testWhenCommentIsEmptyOrNil() {
        viewModel = HomeDetailViewModel(comment: nil)
        viewController.viewModel = viewModel
        XCTAssertEqual(viewModel.comment.count, 0, "comment is not nil")
    }

}
