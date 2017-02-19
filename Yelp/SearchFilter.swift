//
//  SearchFilter.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/18/17.


import UIKit

class SearchFilter {
    var term: String?
    var offset: Int?
    var sort: YelpSortMode?
    var category: String?
    var distance: Int?
    var deal: Bool?
    
    init(){
        term = ""
        offset = 0
        sort = YelpSortMode.distance
        category = ""
        distance = 0
        deal = false
    }
}
