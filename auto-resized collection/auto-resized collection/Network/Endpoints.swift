//
//  Endpoints.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

enum Endpoints {
    case getPhotos
    
    func path() -> String {
        switch self {
        case .getPhotos:
            return "photos"
        }
    }
}
