//
//  API Client.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private lazy var concurrentQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "defaultQueue"
        return queue
    }()
    
    func add(operation: Operation) {
        let queueToRun = concurrentQueue
        queueToRun.addOperation(operation)
    }
}
