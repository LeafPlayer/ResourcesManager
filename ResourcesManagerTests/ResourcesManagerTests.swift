//
//  ResourcesManagerTests.swift
//  ResourcesManagerTests
//
//  Created by lincolnlaw on 2017/11/7.
//  Copyright © 2017年 lincolnlaw. All rights reserved.
//

import XCTest
@testable import ResourcesManager

class ResourcesManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        print(ImageResource.mute)
        print(ImageResource.chevronUp)
        print(I18N.currentLanguage.contributionFilePath)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
