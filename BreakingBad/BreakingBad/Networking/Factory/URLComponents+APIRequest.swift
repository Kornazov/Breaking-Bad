//
//  URLComponents+APIRequest.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import Foundation

extension URLComponents {
    init?(baseUrl: URL, path: String?, parameters: [URLQueryItem]) {
        var finalUrl = baseUrl
        if let unwrappedPath = path {
            finalUrl.appendPathComponent(unwrappedPath)
        }
        self.init(url: finalUrl, resolvingAgainstBaseURL: false)
        queryItems = parameters
    }
}
