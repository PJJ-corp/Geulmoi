//
//  CoreDataTest.swift
//  ServiceTests
//
//  Created by juntaek.oh on 2023/11/04.
//  Copyright © 2023 Service. All rights reserved.
//

import XCTest
@testable import Service
@testable import Resources

final class CoreDataTest: XCTestCase {
    
    let cdService: CoreDataService = .init(with: "ScanModel", entityName: "ScanedWriting")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let saveExp: XCTestExpectation = .init(description: "save success")
        let fetchExp: XCTestExpectation = .init(description: "fetch success")
        let deleteExp: XCTestExpectation = .init(description: "delete success")
        let fetchAfterDeleteExp: XCTestExpectation = .init(description: "no data success")
        
        let data: Data = .init()
        
        guard cdService.isInitialized else {
            XCTExpectFailure("Coredata not initialized")
            return
        }
        
        let isSaved: Bool = cdService.saveData(with: ["text": "IsTest", "imageData": data])
        if isSaved {
            saveExp.fulfill()
        } else {
            XCTExpectFailure("Can not save")
        }
        
        let swData: [ScanedWriting] = cdService.fetchData()
        if swData.isEmpty {
            XCTExpectFailure("Can not fetch")
        }
        
        if let text = swData.first?.text, let _ = swData.first?.imageData {
            XCTAssertTrue(text == "IsTest")
            print("Text: \(text)")
            fetchExp.fulfill()
        } else {
            XCTExpectFailure("Can not fetch")
        }
        
        guard let managedObject = swData.first else {
            XCTExpectFailure("Not data")
            return
        }
        
        let isDelete: Bool = cdService.deleteData(object: managedObject)
        if isDelete {
            deleteExp.fulfill()
        } else {
            XCTExpectFailure("Can not delete")
        }
        
        let deletedData: [ScanedWriting] = cdService.fetchData()
        if deletedData.isEmpty {
            fetchAfterDeleteExp.fulfill()
        } else {
            XCTExpectFailure("Can not deleted")
        }
        
        wait(for: [saveExp, fetchExp, deleteExp, fetchAfterDeleteExp], timeout: 15)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
