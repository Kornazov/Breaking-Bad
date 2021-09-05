//
//  Network Config.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation

struct NetworkConfig {
    
    static var characters: String {
        return "\(baseURL)characters"
    }
    
    static var baseURL: String {
        return "https://breakingbadapi.com/api/"
    }
}
