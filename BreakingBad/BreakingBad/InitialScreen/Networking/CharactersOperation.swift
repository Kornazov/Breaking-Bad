//
//  CharactersOperation.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation
class CharactersOperation: NetworkOperation<Characters> {
    var request: CharactersRequest
    
    override init() {
        request = CharactersRequest()
    }
    
    override func main() {
        networkService.requestData(with: request) { [weak self] result in
            self?.complete(with: result)
        }
    }
}
