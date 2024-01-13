//
//  PersistentDataTest.swift
//  ManagerTests
//
//  Created by juntaek.oh on 2024/01/13.
//  Copyright © 2024 Manager. All rights reserved.
//

import XCTest
import UIKit
import RxSwift
@testable import Manager
@testable import Entity
@testable import Resources

final class PersistentDataTest: XCTestCase {

    let uuid1: String = UUID().uuidString
    let uuid2: String = UUID().uuidString
    let uuid3: String = UUID().uuidString
    let successCount: Int = 4
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        let saveExp: XCTestExpectation = .init(description: "save success")
        let fetchExp: XCTestExpectation = .init(description: "fetch success")
        let removeExp: XCTestExpectation = .init(description: "remove success")
        
        let firstImage: UIImage = ResourcesAsset.test1.image
        let secondImage: UIImage = ResourcesAsset.test2.image
        let thirdImage: UIImage = ResourcesAsset.test3.image
        
        guard let firstData: Data = firstImage.pngData(),
              let secondData: Data = secondImage.pngData(),
              let thirdData: Data = thirdImage.pngData() else {
            XCTExpectFailure("Can't convert to Data")
            
            return
        }
        
        let data1: ScanedModel = .init(uuid: uuid1, imageData: firstData, text: "Data1")
        let data2: ScanedModel = .init(uuid: uuid2, imageData: secondData, text: "Data2")
        let data3: ScanedModel = .init(uuid: uuid3, imageData: thirdData, text: "Data3")
        
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data1)
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data2)
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data3)
        
        let fetchedData: [ScanedModel] = PersistentDataManager.shared.fetchCoreData(with: .scanedWriting)
            .compactMap { $0 as? ScanedModel }
        var count: Int = 0
        
        if (fetchedData.count == 3) {
            count += 1
            fetchedData.forEach {
                guard $0.uuid == data1.uuid || $0.uuid == data2.uuid || $0.uuid == data3.uuid else {
                    XCTExpectFailure("Data not saved or fetched successly")
                    return
                }
                count += 1
                saveExp.fulfill()
                fetchExp.fulfill()
            }
        } else {
            XCTExpectFailure("Data not saved or fetched successly")
        }
        
        let dataIndex1 = fetchedData[1]
        PersistentDataManager.shared.removeCoreData(with: .scanedWriting, model: fetchedData[1])
        
        let fetchedAfterRemoveData: [ScanedModel] = PersistentDataManager.shared.fetchCoreData(with: .scanedWriting)
            .compactMap { $0 as? ScanedModel }
        if (fetchedAfterRemoveData.count == 2) {
            let filtered = fetchedAfterRemoveData
                .filter { $0.uuid == dataIndex1.uuid }
            guard filtered.count == 0 else {
                XCTExpectFailure("Data not saved or fetched successly")
                return
            }
            
            removeExp.fulfill()
        } else {
            XCTExpectFailure("Data not saved or fetched successly")
        }
        
        wait(for: [saveExp, fetchExp, removeExp], timeout: 15)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
