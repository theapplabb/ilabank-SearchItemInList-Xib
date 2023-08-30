//
//  ImageItemCVC.swift
//  TableViewDemo
//
//  Created by Shivaditya Kr on 29/08/23.
//

import UIKit

class ImageItemCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    // MARK: UI Setup
    private func setupUI() {
        // ImageView
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 8
        // Label
        self.titleLabel.font = UIFont.systemFont(ofSize: 15,weight: .bold)
        self.titleLabel.textColor = .label
    }
    
    // MARK: Data Setup
    func setDate(data: ImageItem) {
        self.imageView.image = UIImage(named: data.image)
        self.titleLabel.text = data.title
    }
}
