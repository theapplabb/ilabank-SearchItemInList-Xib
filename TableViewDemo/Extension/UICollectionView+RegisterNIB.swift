//
//  UICollectionView+RegisterNIB.swift
//  TableViewDemo
//
//  Created by Shivaditya Kr on 29/08/23.
//

import UIKit

extension UICollectionView {
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    func registerTableViewHeaderFooterNib(_ headerFooterClass: AnyClass) {
        let identifier = String.className(headerFooterClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeReusableCell(_ cellClass: AnyClass, indexPath : IndexPath) -> UICollectionViewCell {
        let identifier = String.className(cellClass)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
