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
            filterCharacters = characters
        }
    }
    var filterCharacters: Characters?
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
    
    func filterData(by string: String) {
        filterCharacters = []
        if string == "" {
            filterCharacters = characters
        } else {
            characters?.forEach { character in
                if let name = character.name {
                    if name.lowercased().contains(string) {
                        filterCharacters?.append(character)
                    }
                }
            }
        }
        delegate?.reloadData()
    }
}
