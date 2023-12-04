//
//  PhotoResponse.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import UIKit

struct Filters: Decodable { }

struct Photo: Decodable {
    var id: Int
    var createdAt: Date?
    var privacy: Bool?
    var profile: Bool?
    var url: String?
    var userId: Int?
    var width: Int?
    var height: Int?
    var rating: Double?
    var highestRating: Double?
    var highestRatingDate: Date?
    var imageFormat: String?
    var images: [Image]?
    var imageUrl: [String]?
    var name: String?
    var description: String?
    var category: Int?
    var takenAt: Date?
    var commentsCount: Int?
    var votesCount: Int?
    var positiveVotesCount: Int?
    var timesViewed: Int?
    var user: User?
}

extension Photo: Equatable, Identifiable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
    }
}

struct Image: Decodable {
    var format: String?
    var size: Int?
    var url: URL?
    var httpsUrl: URL?
}

struct User: Decodable {
    var id: Int?
    var name: String?
    var fullName: String?
    var registrationDate: Date?
    var avatars: Avatar?
    var about: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "username"
        case fullName
        case registrationDate
        case avatars
        case about
    }
}

struct Avatar: Decodable {
    var tiny: Tiny?
    var small: Small?
    var large: Large?
    var cover: Cover?
    var defaultAvt: Default?
    
    enum CodingKeys: String, CodingKey {
        case tiny
        case small
        case large
        case cover
        case defaultAvt = "default"
    }
}

struct Tiny: Decodable {
    var https: URL?
}

struct Small: Decodable {
    var https: URL?
}

struct Large: Decodable {
    var https: URL?
}

struct Cover: Decodable {
    var https: URL?
}

struct Default: Decodable {
    var https: URL?
}
