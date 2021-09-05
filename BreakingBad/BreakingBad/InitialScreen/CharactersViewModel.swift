//
//  ViewModel.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation
import UIKit

class CharactersViewModel {
    
    var characters: Characters?
    func loadData() {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response
            case .failure(let error):
                print(error)
            }
        }
    }
}
