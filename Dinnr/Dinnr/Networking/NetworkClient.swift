//
//  NetworkClient.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import Foundation

protocol NetworkClient {
    var delegate: URLSessionTaskDelegate? { get }

    func request<Request, Response: Codable>(
        with request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) async throws -> Response
}

final class DefaultNetworkClient: NetworkClient {
    enum NetworkError: Error, CustomStringConvertible {
        case urlResponse(urlResponse: URLResponse)
        case httpStatus(statusCode: Int)

        var description: String {
            switch self {
            case let .urlResponse(urlResponse):
                return "Failed to cast URLResponse to HTTPURLResponse: \(String(describing: urlResponse))"
            case let .httpStatus(statusCode):
                return "Server returned a non-success HTTP Status Code: \(statusCode)"
            }
        }
    }

    private let urlSession: URLSession
    private let decoder: JSONDecoder

    weak var delegate: URLSessionTaskDelegate?

    init(urlSession: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    func request<Request, Response: Codable>(
        with request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) async throws -> Response {
        let request = try request.urlRequest

        let (data, urlResponse) = try await urlSession.data(for: request, delegate: delegate)

        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkError.urlResponse(urlResponse: urlResponse)
        }

        guard httpResponse.isSuccess else {
            throw NetworkError.httpStatus(statusCode: httpResponse.statusCode)
        }

        let response = try decoder.decode(type.self, from: data)

        return response
    }
}
