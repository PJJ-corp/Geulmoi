//
//  VisionTest.swift
//  ManagerTests
//
//  Created by juntaek.oh on 2023/10/16.
//  Copyright © 2023 Manager. All rights reserved.
//

import XCTest
@testable import Manager
@testable import Resources
import UIKit
import RxSwift

final class VisionTest: XCTestCase {
    
    let disposeBag: DisposeBag = .init()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
     사용자가 책 내용을 사진으로 찍었을 때
     찍은 사진 이미지를 VisionManager로 전달하면
     OCR을 통해 사진 이미지 속의 글자를 String으로 변환하여 준다
     */
    func testVisionManagerConvertingImageToText() throws {
        var count: Int = 0
        
        let firstExp: XCTestExpectation = .init(description: "test1 success")
        let secondExp: XCTestExpectation = .init(description: "test2 success")
        let thirdExp: XCTestExpectation = .init(description: "test3 success")
        
        let visionManager: VisionManager = .init()
        visionManager.convertedTextRelay
            .subscribe(with: self) { (_, text) in
                print("Text: \n\(text)")
                
                switch count {
                case 0:
                    count += 1
                    firstExp.fulfill()
                    
                case 1:
                    count += 1
                    secondExp.fulfill()
                    
                case 2:
                    count += 1
                    thirdExp.fulfill()
                    
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        let firstImage: UIImage = ResourcesAsset.test1.image
        let secondImage: UIImage = ResourcesAsset.test2.image
        let thirdImage: UIImage = ResourcesAsset.test3.image
        
        guard let firstData: Data = firstImage.pngData(),
              let secondData: Data = secondImage.pngData(),
              let thirdData: Data = thirdImage.pngData() else {
            XCTExpectFailure("Can't convert to Data")
            
            return
        }
        
        visionManager.executeVisionOcr(with: [firstData, secondData, thirdData])
        
        wait(for: [firstExp, secondExp, thirdExp], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
