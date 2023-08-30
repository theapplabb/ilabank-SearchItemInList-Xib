//
//  PagerView.swift
//  TableViewDemo
//
//  Created by Sandeep on 21/07/23.
//

import Foundation
import UIKit

class PagerView: UICollectionReusableView {
    
    static let headerIdentifier = "PagerView"

    var numberOfPages : Int = 1 {
        didSet {
            self.pagerView.numberOfPages = numberOfPages
        }
    }
    var selectedPage : Int = 0 {
        didSet {
            self.pagerView.currentPage = selectedPage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        [pagerView].forEach{addSubview($0)}
        setUpConstrains()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pagerView : UIPageControl = {
        let pagerView = UIPageControl()
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pagerView.tintColor = .black
        pagerView.numberOfPages = 1
        pagerView.backgroundColor = self.backgroundColor
        pagerView.backgroundStyle = .automatic
        pagerView.currentPageIndicatorTintColor = .black
        pagerView.pageIndicatorTintColor = .lightGray
        return pagerView
    }()
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            pagerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pagerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
