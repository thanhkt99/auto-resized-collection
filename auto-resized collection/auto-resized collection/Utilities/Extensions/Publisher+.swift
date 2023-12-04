//
//  Publisher+.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import Foundation
import Combine

extension Publisher {
    func mapToOptional() -> AnyPublisher<Output?, Failure> {
        map { value -> Output? in value }.eraseToAnyPublisher()
    }
    
    func unwrap() -> AnyPublisher<Output, Failure> {
        compactMap { value -> Output in value }.eraseToAnyPublisher()
    }
}

// ErrorTracker
typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        }).eraseToAnyPublisher()
    }
}

// ActivityTracker
typealias ActivityTracker = CurrentValueSubject<Bool, Never>

extension Publisher {
    func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        }).eraseToAnyPublisher()
    }
}
