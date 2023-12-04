//
//  PhotoViewController.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/22/23.
//

import UIKit
import Combine
import Then

final class PhotoViewController: UIViewController, BindableType {
    enum Section: Hashable {
        case main
    }
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    
    var viewModel: PhotoViewModel!
    var cancelBag = CancelBag()
    
    var items = [Photo]() {
        didSet {
            if !items.isEmpty {
                var snapShot = NSDiffableDataSourceSnapshot<Section, Photo>()
                snapShot.appendSections([.main])
                snapShot.appendItems(items, toSection: .main)
                dataSource.apply(snapShot, animatingDifferences: true)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    var identifier = "PhotoCollectionViewCell"
    private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>! = nil
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        collectionView.do {
            $0.delegate = self
            $0.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        configureDataSource()
    }
    
    func bindViewModel() {
        let input = PhotoViewModel.Input(loadTrigger: Just(()).eraseToAnyPublisher())
        let output = viewModel.transform(input, cancelBag)
//        
        output.$items
            .subscribe(itemsSubscriber)
        
        output.$error
            .dropFirst()
            .subscribe(errorSubscriber)
    }
}

// MARK: - Binders
extension PhotoViewController {
    private var itemsSubscriber: Binder<[Photo]> {
        Binder(self) { vc, items in
            DispatchQueue.main.async {
                vc.collectionView.isHidden = items.isEmpty
                vc.items = items
            }
        }
    }
    
    private var errorSubscriber: Binder<Error?> {
        Binder(self) { (vc, error) in
            guard let error = error else { return }
            vc.showError(error, completion: nil)
            
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, photo: Photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(ofType: PhotoCollectionViewCell.self, at: indexPath)
            cell.configCell(photo)
            cell.contentScaleFactor = 1.0
            return cell
        }
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout { 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.width / 2)
    }
}
