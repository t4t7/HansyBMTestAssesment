//
//  ArtistMediaViewModelUT.swift
//  GMTestCodingTests
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import Foundation
import XCTest
import Combine
@testable import GMTestCoding

fileprivate struct MockMediaService: ArtistMediaFetchable {
    let fakeResult: ArtisMediaResults
    let error: Error?
    func find(artist keyWord: String) -> AnyPublisher<ArtisMediaResults, Error> {
        
        if let dummyError = error {
            return Fail(outputType: ArtisMediaResults.self, failure: dummyError)
                .eraseToAnyPublisher()
        }
        
        return Just(fakeResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class ArtistMediaViewModelUT: XCTestCase {
    
    //MARK:- Positive
    var cancellable = Set<AnyCancellable>()
    
    func testWhenSearchAnyKeyWord_GivenAnyString_ThenGetAFakeListAsResult() {
        let fakeCallService = expectation(description: "FakeCallService")
        let mockService = MockMediaService(fakeResult: getMockData(), error: nil)
        let viewModel = ArtistMediaViewModel(service: mockService)
        viewModel.keyWord = "AnyString"
        viewModel.$artistListMedia
            .sink { list in
                XCTAssertTrue(!list.isEmpty)
                fakeCallService.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [fakeCallService], timeout: 5)
    }
    
    //MARK:- Negative
    
    func testWhenSearchAnyKeyWord_GivenAnyString_ThenGetAnEmptyListAsResult() {
        let fakeCallService = expectation(description: "EmptyListService")
        let mockService = MockMediaService(fakeResult: ArtisMediaResults(resultCount: 1, results: [ArtistMedia]()),
                                           error: nil)
        let viewModel = ArtistMediaViewModel(service: mockService)
        viewModel.keyWord = "AnyString"
        viewModel.$artistListMedia
            .sink { list in
                XCTAssertTrue(list.isEmpty)
                fakeCallService.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [fakeCallService], timeout: 5)
    }
    
    //MARK:- Boundary
    
    func testWhenSearchAnyKeyWord_GivenAnyString_ThenGetAnError() {
        let fakeCallService = expectation(description: "ErrorCallingService")
        fakeCallService.expectedFulfillmentCount = 2
        let mockService = MockMediaService(fakeResult: ArtisMediaResults(resultCount: 1, results: [ArtistMedia]()),
                                           error: HTTPError.serverError(500))
        let viewModel = ArtistMediaViewModel(service: mockService)
        viewModel.keyWord = "AnyString"
        viewModel.$artistListMedia
            .sink(receiveValue: { list in
                XCTAssertTrue(list.isEmpty)
                fakeCallService.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel.$errorMedia
            .sink { messageError in
                XCTAssertNotNil(messageError)
                fakeCallService.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [fakeCallService], timeout: 5)
    }
    
    func getMockData() -> ArtisMediaResults {
        let artistList = [ArtistMedia(artistName: "Test",
                                      trackName: "Track Test",
                                      releaseDate: Date(),
                                      primaryGenreName: "Genre Name",
                                      trackPrice: 1)]
        
        return ArtisMediaResults(resultCount: 1, results: artistList)
    }
    
}
