//
//  UIViewController+.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/21/23.
//

import UIKit

extension UIViewController {
    func logDeinit() {
        print(String(describing: type(of: self)) + " deinit")
    }
    
    func showError(_ error: Error, completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
