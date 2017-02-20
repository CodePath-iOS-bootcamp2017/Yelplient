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
    var categories: [String]?
    var distance: Int?
    var deal: Bool?
    var generalFeatures: [Feature] = []
    
    init(){
        term = ""
        offset = 0
        sort = YelpSortMode.distance
        categories = []
        distance = 0
        deal = false
    }
}

class Feature{
    var name: String?
    var code: String?
    var isActivated: Bool?
    
    init(featureName: String, featureCode: String, isFeatureActivated: Bool){
        self.name = featureName
        self.code = featureCode
        self.isActivated = isFeatureActivated
    }
}
