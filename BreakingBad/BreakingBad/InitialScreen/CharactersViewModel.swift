//
//  ViewModel.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation
import UIKit

protocol CharactersViewModelDelegate: AnyObject {
    func reloadData()
}

class CharactersViewModel {
    
    weak var delegate: CharactersViewModelDelegate?
    var characters: Characters? {
        didSet {
            filterCharacters = characters?.filter({($0.category?.contains("Breaking") ?? false)})
        }
    }
    var searchString: String? {
        didSet {
            filterData()
        }
    }
    var numberForSeason: Int? {
        didSet {
            filterData()
        }
    }
    
    var filterCharacters: Characters?
    var seasons = ["Season 1","Season 2","Season 3","Season 4","Season 5"]
    
    func loadData() {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadDataTest(completion: @escaping(Result<Characters?, Error>) -> Void) {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    
    func showAllCharacters() {
        numberForSeason = nil
        filterCharacters = characters
    }
    
    func filterData() {
        if let searchString = searchString, let season = numberForSeason {
            filterCharacters = characters?.filter({ ( $0.appearance?.contains(season) ?? false) && ($0.name?.lowercased().contains(searchString) ?? false) })
            delegate?.reloadData()
            return
        }
        
        if let searchString = searchString {
            filterCharacters = characters?.filter({ ($0.name?.lowercased().contains(searchString) ?? false)})
            delegate?.reloadData()
            return
        }
        
        if let season = numberForSeason {
            filterCharacters = characters?.filter({ ( $0.appearance?.contains(season) ?? false) })
            delegate?.reloadData()
            return
        }
        filterCharacters = characters
        delegate?.reloadData()
    }
}
