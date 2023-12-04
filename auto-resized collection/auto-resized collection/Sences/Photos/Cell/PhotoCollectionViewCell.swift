//
//  PhotoCollectionViewCell.swift
//  auto-resized collection
//
//  Created by Tien Thanh on 11/22/23.
//

import UIKit
import Then
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.do {
            $0.layer.cornerRadius = 3.0
            $0.layer.cornerCurve = .continuous
            $0.layer.masksToBounds = true
        }
    }
    
    func configCell(_ photo: Photo) {
        avatarImageView.sd_setImage(with: photo.images?.first?.url, completed: nil)
        avatarImageView.contentScaleFactor = 1.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
}
