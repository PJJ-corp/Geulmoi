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

    /*
     사용자가 찍은 책 사진을 String으로 변환까지 마쳐 하나의 데이터 타입으로 변경했을 때,
     해당 데이터를 PersistentManager에 saveCoreData로 전달하면
     CoreData에 해당 데이터를 저장한다.
     
     CoreData에 저장된 데이터가 있을 경우,
     removeCoreData를 호출하여 특정 데이터를 삭제하거나
     fetchCoreData를 호출하여 전체 데이터를 CoreData에서 가져올 수 있다.
     */
    func testPersistentManagerCRUD() throws {
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
        
        let data1: ScannedData = .init(uuid: uuid1, imageData: firstData, text: "Data1")
        let data2: ScannedData = .init(uuid: uuid2, imageData: secondData, text: "Data2")
        let data3: ScannedData = .init(uuid: uuid3, imageData: thirdData, text: "Data3")
        
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data1)
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data2)
        PersistentDataManager.shared.saveCoreData(with: .scanedWriting, model: data3)
        
        let fetchedData: [ScannedData] = PersistentDataManager.shared.GetCoreData(with: .scanedWriting)
            .compactMap { $0 as? ScannedData }
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
        PersistentDataManager.shared.deleteCoreData(with: .scanedWriting, model: fetchedData[1])
        
        let fetchedAfterRemoveData: [ScannedData] = PersistentDataManager.shared.GetCoreData(with: .scanedWriting)
            .compactMap { $0 as? ScannedData }
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
