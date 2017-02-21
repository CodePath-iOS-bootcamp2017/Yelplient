//
//  Review.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class Review: NSObject {
    var username: String?
    var userImageURL: URL?
    var ratingImageURL: URL?
    var comment: String?
    
    init(dictionary: NSDictionary){
        if let user = dictionary.value(forKey: "user") as? NSDictionary{
            if let name = user.value(forKey: "name") as? String{
                self.username = name
            }
            
            if let userProfileUrlString = user.value(forKey: "image_url") as? String{
                if let profileURL = URL(string: userProfileUrlString){
                    self.userImageURL = profileURL
                }
            }else{
                print("user profile can't be converted to url")
            }
        }
        
        
        if let ratingUrlString = dictionary.value(forKey: "rating_image_url") as? String{
            if let ratingUrl = URL(string: ratingUrlString){
                self.ratingImageURL = ratingUrl
            }
        }else{
            print("rating can't be converted to url")
        }
        
        if let userComment = dictionary.value(forKey: "excerpt") as? String{
            self.comment = userComment
        }
    }
}
