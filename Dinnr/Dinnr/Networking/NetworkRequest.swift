//
//  NetworkRequest.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import Foundation

struct NetworkRequest<Body: Codable> {
    enum RequestError: Error, CustomStringConvertible {
        case componentsFailed(baseUrl: URL)
        case urlFailed(components: URLComponents)

        var description: String {
            switch self {
            case let .componentsFailed(baseUrl):
                return "Failed to create components from Url: \(baseUrl)"
            case let .urlFailed(components):
                return "Failed to create url from components: \(String(describing: components))"
            }
        }
    }

    var baseUrl: URL = Endpoint.baseUrl
    var pathItems: [String] = []
    var headers: [String: String] = [:]
    var queryParms: [String: String] = [:]
    var body: Body?
    var httpMethod: HTTPMethod

    var urlRequest: URLRequest {
        get throws {
            var url = baseUrl

            for pathItem in pathItems {
                url.appendPathComponent(pathItem)
            }

            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw RequestError.componentsFailed(baseUrl: baseUrl)
            }

            components.queryItems = queryParms.reduce(into: [URLQueryItem](), { partialResult, queryItem in
                let (key, value) = queryItem
                partialResult.append(URLQueryItem(name: key, value: value))
            })

            guard let url = components.url else {
                throw RequestError.urlFailed(components: components)
            }

            var urlRequest = URLRequest(url: url)

            urlRequest.setHttpMethod(httpMethod)

            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }

            if let body = body {
                let httpBody = try JSONEncoder().encode(body)
                urlRequest.httpBody = httpBody
            }

            return urlRequest
        }
    }
}
