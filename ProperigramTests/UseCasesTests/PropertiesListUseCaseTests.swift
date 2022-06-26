//
//  PropertiesListUseCaseTests.swift
//  ProperigramTests
//
//  Created by Samir on 6/26/22.
//

import XCTest
@testable import Properigram

class PropertiesListUseCaseTests: XCTestCase {

    var sut: PropertiesListUseCase!
    var repository: PropertyRepositoryMock!

    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        super.tearDown()
        deinitModule()
    }

    func testGetPropertiesSuccess() {
        // Given
        let page = PropertiesDataMocks.propertyPage
        let expectation = expectation(description: "wait for async call")
        var returnedProperties: [Property]?
        repository.propertiesPage = page
        // When
        sut.getProperties { result in
            switch result {
            case .success(let properties):
                returnedProperties = properties
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(repository.pageNumber, 1)
        XCTAssertEqual(repository.propertiesPerPage, 10)
        XCTAssertEqual(returnedProperties, page.properties)
    }

    func testGetPropertiesFailed() {
        // Given
        let errorMessage = "error message"
        let expectation = expectation(description: "wait for async call")
        var returnedError: AppError?
        repository.error = BaseError.systemError(message: errorMessage)
        // When
        sut.getProperties { result in
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
        XCTAssertEqual(repository.pageNumber, 1)
        XCTAssertEqual(repository.propertiesPerPage, 10)
        XCTAssertEqual(returnedError?.message, errorMessage)
    }

    func testGetMorePropertiesWithNextPageAvailable() {
        // Given
        let page = PropertiesDataMocks.propertyPage
        let expectation = expectation(description: "wait for async call")
        var returnedProperties: [Property]?
        repository.propertiesPage = page
        // When
        sut.getProperties(completion: { _ in })
        sut.getMoreProperties { result in
            switch result {
            case .success(let properties):
                returnedProperties = properties
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(repository.pageNumber, 2)
        XCTAssertEqual(repository.propertiesPerPage, 10)
        XCTAssertEqual(returnedProperties, page.properties)
    }

    func testGetMorePropertiesWithNoNextPage() {
        // Given
        let page = PropertiesDataMocks.propertySinglePage
        let expectation = expectation(description: "wait for async call")
        expectation.isInverted = true
        repository.propertiesPage = page
        // When
        sut.getProperties(completion: { _ in })
        sut.getMoreProperties { _ in
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testMorePropertiesFailed() {
        // Given
        let page = PropertiesDataMocks.propertyPage
        let errorMessage = "error message"
        let expectation = expectation(description: "wait for async call")
        var returnedError: AppError?
        repository.propertiesPage = page
        // When
        sut.getProperties { _ in }
        repository.error = BaseError.systemError(message: errorMessage)
        repository.propertiesPage = nil
        sut.getMoreProperties { result in
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
        XCTAssertEqual(returnedError?.message, errorMessage)
    }

    func testCanGetMorePropertiesWithMorePageAvailable() {
        // Given
        let page = PropertiesDataMocks.propertyPage
        let expectation = expectation(description: "wait for async call")
        repository.propertiesPage = page
        // When
        sut.getProperties { _ in
            expectation.fulfill()
        }
        let canLoadMore = sut.canGetMoreProperties()
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(canLoadMore)
    }

    func testCanGetMorePropertiesWithNoMorePageAvailable() {
        // Given
        let page = PropertiesDataMocks.propertySinglePage
        let expectation = expectation(description: "wait for async call")
        repository.propertiesPage = page
        // When
        sut.getProperties { _ in
            expectation.fulfill()
        }
        let canLoadMore = sut.canGetMoreProperties()
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(canLoadMore)
    }
}

// MARK: - Module initialization
extension PropertiesListUseCaseTests {

    func initModule() {
        repository = PropertyRepositoryMock()
        sut = PropertiesListUseCase(repository: repository)
    }

    func deinitModule() {
        repository = nil
        sut = nil
    }
}
