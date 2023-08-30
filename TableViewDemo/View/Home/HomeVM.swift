//
//  HomeVM.swift
//  TableViewDemo
//
//  Created by Sandeep on 20/07/23.
//

import Foundation


class HomeVM {
    var imageListData : Observable<[ImageItem]> = Observable([])
    var featureImageList : Observable<[ImageItem]> = Observable([])
    
    func searchImageList(title : String) {
        let imageList = imageListSearchDataBy(title: title)
        self.imageListData.value = imageList
    }
    
    func getFeatureImageList() {
        self.featureImageList.value = imageItemFeaturedMockData
    }
}
