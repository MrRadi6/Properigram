//
//  PropertiesListViewModelTests.swift
//  ProperigramTests
//
//  Created by Samir on 6/25/22.
//

import XCTest
import Combine
@testable import Properigram

class PropertiesListViewModelTests: XCTestCase {

    var sut: PropertiesListViewModel!
    var useCase: PropertiesListUseCaseMock!
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        initModule()
    }
    
    override func tearDown() {
        super.tearDown()
        deinitModule()
    }

    func testHideLoadingOnReloadProperties() {
        // When
        sut.reloadProperties()
        // Then
        XCTAssertFalse(sut.isLoading)
    }

    func testWillShowItemNotLast() {
        // Given
        let properties = PropertiesDataMocks.propertyPage.properties.map({ PropertyItem(property: $0) })
        sut.properties = properties
        // When
        sut.viewWillShow(item: properties[0])
        // Then
        XCTAssertFalse(useCase.isGetMoreCalled)
    }

    func testWillShowItemtLast() {
        // Given
        let properties = PropertiesDataMocks.propertyPage.properties.map({ PropertyItem(property: $0) })
        sut.properties = properties
        // When
        sut.viewWillShow(item: properties[1])
        // Then
        XCTAssertTrue(useCase.isGetMoreCalled)
    }

    func testWillShowLastItemWithMorePages() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let properties = PropertiesDataMocks.propertyPage.properties.map({ PropertyItem(property: $0) })
        sut.properties = properties
        useCase.properties = PropertiesDataMocks.propertyPage.properties
        // When
        sut.viewWillShow(item: properties[1])
        sut.$properties
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(properties.count * 2, sut.properties.count)
    }

    func testViewReloadWithError() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let error = AppError(message: "error message")
        useCase.error = error
        // When
        sut.reloadProperties()
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
    }

    func testWillShowItemWithError() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let properties = PropertiesDataMocks.propertyPage.properties.map({ PropertyItem(property: $0) })
        let error = AppError(message: "error message")
        useCase.error = error
        sut.properties = properties
        // When
        sut.viewWillShow(item: properties[1])
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
extension PropertiesListViewModelTests {

    func initModule() {
        useCase = PropertiesListUseCaseMock()
        sut = PropertiesListViewModel(useCase: useCase)
    }

    func deinitModule() {
        useCase = nil
        sut = nil
        cancelable.removeAll()
    }
}
