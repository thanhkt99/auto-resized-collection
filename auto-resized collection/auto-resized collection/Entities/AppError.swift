//
//  AppError.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import Foundation

enum AppError: LocalizedError {
    case none
    case error(msg: String)
    
    var errorDescription: String? {
        switch self {
        case let .error(msg):
            return msg
        default:
            return ""
        }
    }
}
