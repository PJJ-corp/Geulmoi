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

    /*
     PersistentManager에서 데이터타입을,
     CoreDataService에 saveCoreData로 전달하면
     CoreData에 해당 데이터를 저장한다.
     
     CoreData에 저장된 데이터가 있을 경우,
     removeCoreData를 호출하여 특정 데이터를 삭제하거나
     fetchCoreData를 호출하여 전체 데이터를 CoreData에서 가져올 수 있다.
     */
    func testCoreDataServiceCRUD() throws {
        let saveExp: XCTestExpectation = .init(description: "save success")
        let fetchExp: XCTestExpectation = .init(description: "fetch success")
        let deleteExp: XCTestExpectation = .init(description: "delete success")
        let fetchAfterDeleteExp: XCTestExpectation = .init(description: "no data success")
        
        let data: Data = .init()
        
        guard cdService.isInitialized else {
            XCTExpectFailure("Coredata not initialized")
            return
        }
        
        do {
            try cdService.saveData(with: ["text": "IsTest", "imageData": data])
            saveExp.fulfill()
            
        } catch {
            XCTExpectFailure("Can not save")
        }
        
        var swData: [ScanedWriting] = []
        
        do {
            swData = try cdService.fetchData()
            if swData.isEmpty {
                XCTExpectFailure("Can not fetch")
            }
            
            if let text = swData.first?.text, let _ = swData.first?.imageData {
                print("Text: \(text)")
                XCTAssertTrue(text == "IsTest")
                fetchExp.fulfill()
            } else {
                XCTExpectFailure("Can not fetch")
            }
            
        } catch {
            XCTExpectFailure("Can not fetch")
        }
        
        guard let managedObject = swData.first else {
            XCTExpectFailure("Not data")
            return
        }
        
        do {
            try cdService.deleteData(object: managedObject)
            deleteExp.fulfill()
            
        } catch {
            XCTExpectFailure("Can not delete")
        }
        
        do {
            let deletedData: [ScanedWriting] = try cdService.fetchData()
            if deletedData.isEmpty {
                fetchAfterDeleteExp.fulfill()
            } else {
                XCTExpectFailure("Can not deleted")
            }
            
        } catch {
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
