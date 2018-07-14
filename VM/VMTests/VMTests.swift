//
//  VMTests.swift
//  VMTests
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest
@testable import VM

let timeout = 30.0

class VMTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddAmount(){
        let expec = self.expectation(description: #function)
        
        let amount = 10
        Money.shared.addAmount(amount: amount) { _,_  in
            expec.fulfill()
            XCTAssertEqual(amount, 10)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
