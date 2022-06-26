//
//  PropertyDetailsUseCaseTests.swift
//  ProperigramTests
//
//  Created by Samir on 6/26/22.
//

import XCTest
@testable import Properigram

class PropertyDetailsUseCaseTests: XCTestCase {
    var sut: PropertyDetailsUseCase!
    var repository: PropertyRepositoryMock!

    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        super.tearDown()
        deinitModule()
    }

    func testGetPropertyDetailsSuccess() {
        // Given
        let propertyId = "123-456-789"
        let property = PropertiesDataMocks.propertyDetails
        let expectation = expectation(description: "wait for async call")
        var returnedProperty: PropertyDetails?
        repository.propertyDetails = property
        // When
        sut.getPropertyDetails(with: propertyId) { result in
            switch result {
            case .success(let propertyDetails):
                returnedProperty = propertyDetails
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(repository.propertyId, propertyId)
        XCTAssertEqual(returnedProperty, property)
    }

    func testGetPropertiesFailed() {
        // Given
        let propertyId = "123-456-789"
        let errorMessage = "error message"
        let expectation = expectation(description: "wait for async call")
        var returnedError: AppError?
        repository.error = BaseError.systemError(message: errorMessage)
        // When
        sut.getPropertyDetails(with: propertyId) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                returnedError = error
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(repository.propertyId, propertyId)
        XCTAssertEqual(returnedError?.message, errorMessage)
    }
}

// MARK: - Module initialization
extension PropertyDetailsUseCaseTests {

    func initModule() {
        repository = PropertyRepositoryMock()
        sut = PropertyDetailsUseCase(repository: repository)
    }

    func deinitModule() {
        repository = nil
        sut = nil
    }
}
