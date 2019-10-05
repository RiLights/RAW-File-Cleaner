//
//  RAW_File_CleanerTests.swift
//  RAW File CleanerTests
//
//  Created by Yaryna Pochtarenko on 22/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import XCTest
@testable import RAW_File_Cleaner

class RAW_File_CleanerTests: XCTestCase {
    
    var directory_items:[String] = []

    override func setUp() {
        self.directory_items = ["bobo01.jpg","bobo01.CR2",
                               "bobo02.jpg","bobo02.CR2",
                               "dodo01.jpg","dodo01.CR2"]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApplyFilterBasic() {
        let spares:[String] = ["dd.CR2"]
        self.directory_items += spares
        let res = raw_filter(self.directory_items,raw_name: "CR2")
        
        XCTAssertEqual(spares, res)
    }
    
    func testApplyFilterRAW() {
        let spares:[String] = ["dd.CR2"]
        self.directory_items += spares
        let res = raw_filter(self.directory_items,raw_name: "RAW")
        
        XCTAssertEqual([], res)
    }
    
    func testApplyFilterLowercase() {
        let spares:[String] = ["dd.cr2"]
        self.directory_items += spares
        let res = raw_filter(self.directory_items,raw_name: "CR2")
        
        XCTAssertEqual(spares, res)
    }

    func testApplyFilterMultyFiles() {
        let spares:[String] = ["dd.cr2","dd.CR2","qwe.CR2","qwer.CR2"]
        self.directory_items += spares
        let res = raw_filter(self.directory_items,raw_name: "CR2")
        
        XCTAssertEqual(spares, res)
    }
    func testApplyFilterSpareFiles() {
        let spares:[String] = ["qwe.CR2","qwer.CR2"]
        let _spares:[String] = ["name.nk","somefolder"]
        self.directory_items += spares
        self.directory_items += _spares
        let res = raw_filter(self.directory_items,raw_name: "CR2")
        
        XCTAssertEqual(spares, res)
    }
    
    func testApplyFilterFullPath() {
        let spares:[String] = ["/vol/mac/dd.CR2","/vol/mac/qwer.CR2"]
        self.directory_items += spares
        let res = raw_filter(self.directory_items,raw_name: "CR2")
        
        XCTAssertEqual(spares, res)
    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
