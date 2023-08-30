//
//  HomeVC+Extension.swift
//  TableViewDemo
//
//  Created by Sandeep on 20/07/23.
//

import Foundation
import UIKit

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return self.viewModel.featureImageList.value.count
        case 2 :
            return self.viewModel.imageListData.value.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case 0 :
            guard let cell = collectionView.dequeReusableCell(CarouselCVC.self, indexPath: indexPath) as? CarouselCVC else {fatalError("Unable deque cell...")}
            cell.setData(data: self.viewModel.featureImageList.value[indexPath.row])
            return cell
            
        case 2 :
            guard let cell = collectionView.dequeReusableCell(ImageItemCVC.self, indexPath: indexPath) as? ImageItemCVC else {fatalError("Unable deque cell...")}
            cell.setDate(data: self.viewModel.imageListData.value[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Header" {
            switch indexPath.section {
            case 1 :
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderVeiw.headerIdentifier, for: indexPath) as! SearchHeaderVeiw
                header.delegate = self
                return header
            default :
                return UICollectionReusableView()
            }
        }
        if kind == "Footer" {
            switch indexPath.section {
            case 0 :
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PagerView.headerIdentifier, for: indexPath) as! PagerView
                footer.numberOfPages = self.viewModel.featureImageList.value.count
                footer.selectedPage = 0
                return footer
            default :
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offestY = scrollView.contentOffset.y
        if abs(offestY) > 225 {
            searchHeaderView.isHidden = false
            searchHeaderView.isSticky = true
        }else {
            searchHeaderView.isHidden = true
            searchHeaderView.isSticky = false
        }
    }
    
}
