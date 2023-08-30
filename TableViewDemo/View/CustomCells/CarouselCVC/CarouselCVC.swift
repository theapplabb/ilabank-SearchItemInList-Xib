//
//  CarouselCVC.swift
//  TableViewDemo
//
//  Created by Shivaditya Kr on 29/08/23.
//

import UIKit

class CarouselCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    //MARK: UI Setup
    private func setupUI() {
        // ImageVIew
        self.imageView.backgroundColor = .systemBackground
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleToFill
        self.imageView.layer.cornerRadius = 8
    }
    
    // MARK: Data Setup
    func setData(data: ImageItem) {
        let resizedImage = resizeImage(image: UIImage(named: data.image)!, targetSize: CGSize(width: 200, height: 100))
        self.imageView.image = resizedImage
    }
}
