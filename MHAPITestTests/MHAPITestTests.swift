//
//  MHAPITestTests.swift
//  MHAPITestTests
//
//  Created by LittleFoxiOSDeveloper on 2023/04/11.
//

import XCTest
@testable import MHAPI
import RxSwift

final class MHAPITestTests: XCTestCase {
    
    var appleAPI: AppleAPI?
    let disposeBag = DisposeBag()
    
    var littleAPI: LittleAPI?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.appleAPI = AppleAPI()
        self.littleAPI = LittleAPI()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.appleAPI = nil
        self.littleAPI = nil
    }

    func testExample() throws {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCallAppleAPI() throws{
        let exception = self.expectation(description: "test call apple api")

        self.appleAPI?.call(api: SearchAPIInfo(keyword: "kb", config: AppleAPIConfig()), completed: { res in
            print(res)

            XCTAssertEqual(res.data?.resultCount, 50)
            exception.fulfill()
        })

        wait(for: [exception], timeout: 5)
    }
    
    func testCallAPIByRx() throws{
//        let exception = self.expectation(description: "test call api by rx")
        
//        self.api?.callByRx(TestAPI(keyword: "kb", config: APIConfig()))
//            .subscribe(
//                onNext: { element in
//                    XCTAssertNotNil(element.data)
//                    exception.fulfill()
//                }, onError: { error in
//                    print((error as? APICallError)?.desc)
//                }, onCompleted: {
//                    print("completed")
//                }, onDisposed: {
//                    print("disposed")
//                }).disposed(by: disposeBag)
//
//        wait(for: [exception], timeout: 5)
    }
}
  
