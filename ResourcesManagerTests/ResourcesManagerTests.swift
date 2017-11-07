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
        I18N.setToSystemDefaultLangauge()
        print(I18N.currentLanguage)
        print(I18N.MainMenu.BiggerSize)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSetToChinese() {
//        I18N.userPreferredLanguage(.chineseTraditional)
//        print(I18N.MainMenu.BiggerSize)
//        I18N.userPreferredLanguage(.english)
//        print(I18N.MainMenu.BiggerSize)
        print(ImageResource.chevronUp)
        print(ImageResource.play)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
