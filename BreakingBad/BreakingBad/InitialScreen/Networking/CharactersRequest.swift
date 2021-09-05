//
//  CharactersRequest.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation
class CharactersRequest: BaseRequest {
    
    override var endpoint: String? {
        return NetworkConfig.characters
    }
}
