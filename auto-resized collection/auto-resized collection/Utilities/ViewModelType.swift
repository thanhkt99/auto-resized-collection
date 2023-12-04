//
//  ViewModelType.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, _ cancelBag: CancelBag) -> Output
}
