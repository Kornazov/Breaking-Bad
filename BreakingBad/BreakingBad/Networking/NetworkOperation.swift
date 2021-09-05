//
//  NetworkOperation.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation

class NetworkOperation<T: Decodable>: AsyncOperation {
    typealias NetworkOperationCompletion = (_ result: Result<T?, Error>) -> Void
    
    var completion: NetworkOperationCompletion?
    var networkService: NetworkService = NetworkService<T>()
    
    func complete(with result: Result<T?, Error>) {
        finish()
        
        if !isCancelled {
            completion?(result)
        }
    }
}
