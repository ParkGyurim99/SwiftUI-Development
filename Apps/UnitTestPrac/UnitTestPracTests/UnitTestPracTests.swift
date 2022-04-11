//
//  UnitTestPracTests.swift
//  UnitTestPracTests
//
//  Created by Park Gyurim on 2022/04/11.
//

import XCTest
@testable import UnitTestPrac

class UnitTestPracTests: XCTestCase {
    var sut : LoginValidator! // sut :  systemUnderTest -> 테스트할 클래스 정의시 사용
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = LoginValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testLoginValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        //Arrange
        let user = User(email: "Fomagran6@naver.com", password: "1234")
        
        //Action
        let isValidEmail = sut.isValidEmail(email: user.email)
        
        //Assert
        XCTAssertTrue(isValidEmail, "isValidEmail은 True를 반환해야되는데 False를 반환했어 @를 포함시켜야 해!")
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
