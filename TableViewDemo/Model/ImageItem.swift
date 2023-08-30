//
//  ImageItem.swift
//  TableViewDemo
//
//  Created by Sandeep on 20/07/23.
//

import Foundation
import UIKit

struct ImageItem {
    var title : String
    var image : String
}

let imageItemFeaturedMockData = [
    ImageItem(title: "Sun set", image: "image1"),
    ImageItem(title: "Taj Mahal", image: "image2"),
    ImageItem(title: "Peacock feather", image: "image3"),
    ImageItem(title: "Water tree", image: "image4"),
]

let imageItemListMockData = [
    ImageItem(title: "Sun set", image: "image1"),
    ImageItem(title: "Taj Mahal", image: "image2"),
    ImageItem(title: "Peacock feather", image: "image3"),
    ImageItem(title: "Water tree", image: "image4"),
    ImageItem(title: "Flower", image: "image5"),
    ImageItem(title: "Forest", image: "image6"),
    ImageItem(title: "Sun set", image: "image1"),
    ImageItem(title: "Taj Mahal", image: "image2"),
    ImageItem(title: "Peacock feather", image: "image3"),
    ImageItem(title: "Water tree", image: "image4"),
    ImageItem(title: "Flower", image: "image5"),
    ImageItem(title: "Forest", image: "image6"),
    ImageItem(title: "Sun set", image: "image1"),
    ImageItem(title: "Taj Mahal", image: "image2"),
    ImageItem(title: "Peacock feather", image: "image3"),
    ImageItem(title: "Water tree", image: "image4"),
    ImageItem(title: "Flower", image: "image5"),
    ImageItem(title: "Forest", image: "image6")
]

func imageListSearchDataBy(title: String) -> [ImageItem] {
    if title.isEmpty {
        return imageItemListMockData
    } else {
        var result = [ImageItem]()
        for item in imageItemListMockData {
            let itemTitle = item.title.lowercased()
            if itemTitle.contains(title.lowercased()) {
                result.append(item)
            }
        }
        return result
    }
}
