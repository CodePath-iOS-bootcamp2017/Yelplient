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
    
    init(dictionary: NSDictionary){
        if let user = dictionary.value(forKey: "user") as? NSDictionary{
            if let name = user.value(forKey: "") as? String{
                self.username = name
            }
            
            if let userProfileUrl = user.value(forKey: "image_url") as? URL{
                self.userImageURL = userProfileUrl
            }else{
                print("user profile can't be converted to url")
            }
        }
        
        
        if let ratingUrl = dictionary.value(forKey: "rating_image_url") as? URL{
            self.ratingImageURL = ratingUrl
        }else{
            print("rating can't be converted to url")
        }
    }
}
