//
//  BindableType.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}
