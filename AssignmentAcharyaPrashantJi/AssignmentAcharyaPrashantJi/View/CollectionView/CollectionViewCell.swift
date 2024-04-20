//
//  CollectionViewCell.swift
//  AssignmentAcharyaPrashantJi
//
//  Created by Rajeshwari Sharma on 19/04/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    func setupImageView() {
            // Set content mode to aspect fill for center-cropped effect
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
}
