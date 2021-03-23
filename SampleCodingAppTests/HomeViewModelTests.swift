//
//  HomeViewModelTests.swift
//  SampleCodingAppTests
//
//  Created by Stephen on 23/03/21.
//

import XCTest
@testable import SampleCodingApp

class HomeViewModelTests: XCTestCase {
    
    var viewModel:HomeViewModel!
    var mockService = MockService()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let viewController = HomeViewController()
        viewModel = HomeViewModel(delegate:viewController, service:  mockService)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetItemSuccess() {
        mockService.responseFileName = "ItemsSuccessResponse"
        viewModel.getItems()
        XCTAssertEqual(viewModel.numberOfItems, 5 , "Items are nil")

        let post =  viewModel.getItem(for: 0)

        XCTAssertNotNil(post.name)
        XCTAssertNotNil(post.comment)
        XCTAssertNotNil(post.email)

        XCTAssertGreaterThan(post.name.count, 0, "name is blank")
        XCTAssertGreaterThan(post.comment.count, 0, "comment is blank")
        XCTAssertGreaterThan(post.email.count, 0, "email is blank")
    }
    
    func testGetItemSuccessOutOfIndex(){
        
        mockService.responseFileName = "ItemsSuccessResponse"
        viewModel.getItems()
        
        // Out of Index boundary conditon
        let post1 = viewModel.getItem(for:10)

        XCTAssertEqual(post1.name, "" , "Name found for out of index")
        XCTAssertEqual(post1.comment, "" , "Comment found for out of index")
        XCTAssertEqual(post1.email, "" , "Email found for out of index")
        
        // Out of Index boundary conditon, Negative Index
        let post2 = viewModel.getItem(for:-1)

        XCTAssertEqual(post2.name, "" , "Name found for out of  negative index")
        XCTAssertEqual(post2.comment, "" , "Comment found for out of negative index")
        XCTAssertEqual(post2.email, "" , "Email found for out of  negative index")

    }
    
    func testGetItemFailure() {

        // when search text not empty Success Scenario
        mockService.responseFileName = "ItemFailureResonse"
        viewModel.getItems()
        XCTAssertEqual(viewModel.numberOfItems, 0 , "Items not nil")

        let post1 =  viewModel.getItem(for:0)

        XCTAssertEqual(post1.name, "" , "Name found for out of index")
        XCTAssertEqual(post1.comment, "" , "Comment found for out of index")
        XCTAssertEqual(post1.email, "" , "Email found for out of index")

    }
    
}
