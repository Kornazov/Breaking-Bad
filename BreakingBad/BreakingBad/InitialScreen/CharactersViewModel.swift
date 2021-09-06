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
    
    var filterForSeason: Int? {
        didSet {
            filterData()
        }
    }
    
    func filterData() {
        if let searchString = searchString, let season = filterForSeason {
            filterCharacters = characters?.filter({ ( $0.appearance?.contains(season) ?? false) && ($0.name?.lowercased().contains(searchString) ?? false) })
            delegate?.reloadData()
            return
        }
        
        if let searchString = searchString {
            filterCharacters = characters?.filter({ ($0.name?.lowercased().contains(searchString) ?? false)})
            delegate?.reloadData()
            return
        }
        
        if let season = filterForSeason {
            filterCharacters = characters?.filter({ ( $0.appearance?.contains(season) ?? false) })
            delegate?.reloadData()
            return 
        }
        filterCharacters = characters
        delegate?.reloadData()
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
    
    func showAllCharacters() {
        filterForSeason = nil
        filterCharacters = characters
    }
}
