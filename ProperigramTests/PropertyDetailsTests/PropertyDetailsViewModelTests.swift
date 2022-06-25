//
//  PropertyDetailsViewModelTests.swift
//  ProperigramTests
//
//  Created by Samir on 6/26/22.
//

import XCTest
import Combine
@testable import Properigram

class PropertyDetailsViewModelTests: XCTestCase {

    var sut: PropertyDetailsViewModel!
    var useCase: PropertyDetailsUseCaseMock!
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        super.tearDown()
        deinitModule()
    }

    func testViewDidAppear()  {
        // Given
        let property = PropertiesDataMocks.propertyDetails
        let expectation = XCTestExpectation(description: "wait for async call")
        let propertyId = "123-456-789"
        sut.propertyId = propertyId
        useCase.property = property
        // When
        sut.viewDidAppear()
        sut.$propertyDetails.sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(useCase.propertyId, propertyId)
        XCTAssertEqual(property.name, sut.propertyDetails?.name)
        XCTAssertEqual(property.address, sut.propertyDetails?.address)
        XCTAssertEqual(property.imageUrl, sut.propertyDetails?.imageUrl)
    }

    func testViewDidAppearShowLoading()  {
        // Given
        let propertyId = "123-456-789"
        sut.propertyId = propertyId
        // When
        sut.viewDidAppear()
        // Then
        XCTAssertTrue(sut.isLoading)
    }

    func testViewDidAppearWithError() {
        let expectation = XCTestExpectation(description: "wait for async call")
        let propertyId = "123-456-789"
        let error = AppError(message: "error message")
        sut.propertyId = propertyId
        useCase.error = error
        // When
        sut.viewDidAppear()
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
    }

}

// MARK: - Module initialization
extension PropertyDetailsViewModelTests {

    func initModule() {
        useCase = PropertyDetailsUseCaseMock()
        sut = PropertyDetailsViewModel(useCase: useCase)
    }

    func deinitModule() {
        useCase = nil
        sut = nil
        cancelable.removeAll()
    }
}
