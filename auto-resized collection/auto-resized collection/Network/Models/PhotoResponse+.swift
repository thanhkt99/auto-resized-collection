//
//  PhotoResponse+.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import Combine

final class PhotoResponse: Decodable {
    private(set) var photos: [Photo]?
    private(set) var currentPage: Int?
    private(set) var totalPages: Int?
    private(set) var totalItems: Int?
    private(set) var feature: String?
    private(set) var filters: Filters?
    
}

extension PhotoResponse {
    static func getAllPhotos() -> AnyPublisher<PhotoResponse, APIError> {
        return API.shared
            .request(endpoint: .getPhotos)
            .eraseToAnyPublisher()
    }
}

