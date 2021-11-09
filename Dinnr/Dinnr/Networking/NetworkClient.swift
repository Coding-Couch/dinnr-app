//
//  NetworkClient.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import Foundation
import Combine

protocol NetworkClient {
    var delegate: URLSessionTaskDelegate? { get }
    
    /// Asynchronous network request
    ///  - Parameters:
    ///     - request: NetworkRequest struct
    ///     - type: the expected  type of the response payload
    /// - Returns: Decodable Response
    func request<Request: Encodable, Response: Decodable>(
        with request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) async throws -> Response
    
    /// Publisher that publishes a response from a network call.
    /// - Parameters:
    ///     - request: NetworkRequest struct
    ///     - type: the expected type of the response payload
    /// - Returns: AnyPublisher<Response, Error>
    func publisher<Request: Encodable, Response: Decodable>(
        of request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) -> AnyPublisher<Response, Error>
}

class MockNetworkClient<T: Decodable>: NetworkClient {
    enum MockNetworkError: Error {
        case invalidType
        case noResponse
    }

    var mockResponse: T?
    var error: Error?

    weak var delegate: URLSessionTaskDelegate?

    func request<Request: Encodable, Response: Decodable>(
        with request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) async throws -> Response {
        if let error = error {
            throw error
        }

        guard let mockResponse = mockResponse, let response = mockResponse as? Response else {
            throw MockNetworkError.noResponse
        }

        return response
    }

    func publisher<Request: Encodable, Response: Decodable>(
        of request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) -> AnyPublisher<Response, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let mockResponse = mockResponse, let response = mockResponse as? Response else {
            return Fail(error: MockNetworkError.noResponse).eraseToAnyPublisher()
        }

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
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

    func request<Request: Encodable, Response: Decodable>(
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

    func publisher<Request: Encodable, Response: Decodable>(
        of request: NetworkRequest<Request>,
        decodingInto type: Response.Type
    ) -> AnyPublisher<Response, Error> {
        do {
            let request = try request.urlRequest

            return urlSession.dataTaskPublisher(for: request)
                .tryMap { (data, urlResponse) -> Data in
                    guard let httpResponse = urlResponse as? HTTPURLResponse else {
                        throw NetworkError.urlResponse(urlResponse: urlResponse)
                    }

                    guard httpResponse.isSuccess else {
                        throw NetworkError.httpStatus(statusCode: httpResponse.statusCode)
                    }

                    return data
                }
                .decode(type: Response.self, decoder: decoder)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
