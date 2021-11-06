//
//  HTTPMethod.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import Foundation

/// Standard HTTP Methods
enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

extension URLRequest {
    /// Set the `URLRequest` httpMethod property with an `HTTPMethod` enum
    /// - Parameter httpMethod: The HTTPMethod
    mutating func setHttpMethod(_ httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod.rawValue
    }
}
