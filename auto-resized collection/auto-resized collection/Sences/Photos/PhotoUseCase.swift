//
//  PhotoUseCase.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/22/23.
//

import Combine

protocol PhotoUseCaseType {
    func getAllPhotos() -> AnyPublisher<[Photo], APIError>
}

struct PhotoUseCase: PhotoUseCaseType {
    func getAllPhotos() -> AnyPublisher<[Photo], APIError> {
        PhotoResponse
            .getAllPhotos()
            .map { $0.photos ?? [] }
            .eraseToAnyPublisher()
    }
}
