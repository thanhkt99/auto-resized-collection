//
//  PhotoViewModel.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/22/23.
//

import Combine
import Foundation

struct PhotoViewModel {
    let navigator: PhotoNavigatorType
    let useCase: PhotoUseCaseType
}

// MARK: - ViewModel
extension PhotoViewModel: ViewModelType {
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
    }
    
    final class Output: ObservableObject {
        @Published var items = [Photo]()
        @Published var isLoading = false
        @Published var error: Error?
    }
    
    func transform(_ input: Input, _ cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        input.loadTrigger
            .flatMap {
                self.useCase
                    .getAllPhotos()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .catch { _ in Empty() }
                    .eraseToAnyPublisher()
            }
            .assign(to: \.items, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .mapToOptional()
            .assign(to: \.error, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
