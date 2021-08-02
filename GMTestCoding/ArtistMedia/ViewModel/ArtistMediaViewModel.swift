//
//  ArtistMediaViewModel.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import Foundation
import Combine

class ArtistMediaViewModel {
        
    @Published
    var artistListMedia = [ArtistMediaViewModelCell]()
    @Published
    var errorMedia: String?
    let artistService: ArtistMediaFetchable
    var cancellables = Set<AnyCancellable>()
    var keyWord: String = "" {
        didSet {
            fetch(keyWord: keyWord)
        }
    }
    
    init(service: ArtistMediaFetchable = ArtistMediaService()) {
        artistService = service
    }
    
    private func fetch(keyWord: String) {
        if keyWord.isEmpty {
            return
        }
        artistService.find(artist: keyWord)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, let httpError = error as? HTTPError {
                    self.errorMedia = httpError.localizedError
                    self.artistListMedia = [ArtistMediaViewModelCell]()
                    return
                }
                
                if case .failure(_) = completion {
                    self.errorMedia = "Error getting the artist list."
                    self.artistListMedia = [ArtistMediaViewModelCell]()
                    return
                }
            }, receiveValue: { artistList in
                self.artistListMedia = artistList.results.map { ArtistMediaViewModelCell(artist: $0) }
            }).store(in: &cancellables)
    }
}


fileprivate extension HTTPError {
    var localizedError: String {
        switch self {
            case .netWorkError:
                return "There was a communication error, try again."
            default:
                return "Error getting the artist list."
        }
    }
}
