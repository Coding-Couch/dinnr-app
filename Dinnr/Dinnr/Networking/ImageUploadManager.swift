//
//  ImageUploadManager.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-07.
//

import Foundation
import Combine

class ImageUploadManager {
    struct ImageBody: Codable {
         let image: Data
    }
    
    // MARK: - ImageResponse
    struct ImageResponse: Codable {
        let data: DataClass
        let success: Bool
        let status: Int
    }

    // MARK: - DataClass
    struct DataClass: Codable {
        let id, title: String
        let urlViewer: String
        let url, displayURL: String
        let size, time, expiration: String
        let image, thumb, medium: Image
        let deleteURL: String

        enum CodingKeys: String, CodingKey {
            case id, title
            case urlViewer = "url_viewer"
            case url
            case displayURL = "display_url"
            case size, time, expiration, image, thumb, medium
            case deleteURL = "delete_url"
        }
    }

    // MARK: - Image
    struct Image: Codable {
        let filename, name, mime, imageExtension: String
        let url: String

        enum CodingKeys: String, CodingKey {
            case filename, name, mime
            case imageExtension = "extension"
            case url
        }
    }
    
    private let baseURL = URL(string: "https://api.imgbb.com/1/upload")!
    private let pathItems = [String]()
    private let headers =  [
        "Content-Type": "multipart/form-data"
    ]
    #warning("Should probably get rid of this...")
    private let apiKey = "234aea31987818b7534a75ca7340ed5a"
    
    func uploadImagePublisher(data: Data) -> AnyPublisher<ImageResponse, Error>{
        let request = NetworkRequest(
            baseUrl: baseURL,
            pathItems: pathItems,
            headers: headers,
            queryParms: ["key": apiKey],
            body: ImageBody(image: data),
            httpMethod: .post
        )
        
        return DefaultNetworkClient().publisher(of: request, decodingInto: ImageResponse.self)
    }
    
    func uploadImage(data: Data) async throws -> ImageResponse {
        let request = NetworkRequest(
            baseUrl: baseURL,
            pathItems: pathItems,
            headers: headers,
            queryParms: ["key": apiKey],
            body: ImageBody(image: data),
            httpMethod: .post
        )
        
        let response = try await DefaultNetworkClient().formRequest(with: request, decodingInto: ImageResponse.self)
        
        return response
    }
     
}
