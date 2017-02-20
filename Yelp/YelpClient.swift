
import UIKit

import AFNetworking
import BDBOAuth1Manager

// Yelp API keys registered at http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "ImpIAneQ8SSEUSMJpmhSFg"
let yelpConsumerSecret = "nd9uFYygcjb_9PFxuu5N185s0a4"
let yelpToken = "yD24_n1kPFXQTir3b3mBm7c_IfFNKSFN"
let yelpTokenSecret = "F8vimX5iCDdbjU9reMykte5YtXY"

enum YelpSortMode: Int {
    case bestMatched = 0
    case distance = 1
    case highestRated = 2
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    //MARK: Shared Instance
    
    static let sharedInstance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    /*
    func searchWithTerm(_ term: String, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    
    */
    
    func searchBusinesses(_ searchString: SearchFilter, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        
        // For parameter reference http://www.yelp.com/developers/documentation/v2/search_api
        
        var parameters: [String : AnyObject] = ["ll": "37.785771,-122.406165" as AnyObject]
        
        if let term = searchString.term {
            parameters["term"] = term as AnyObject?
        }
        
        if let sort = searchString.sort {
            parameters["sort"] = sort.rawValue as AnyObject?
        }
        
        if let categories = searchString.categories {
            if categories.count > 0{
                parameters["category_filter"] = (categories).joined(separator: ",") as AnyObject?
            }
        }
        
        if let deals = searchString.deal {
            parameters["deals_filter"] = deals as AnyObject?
        }
        
        if let distance = searchString.distance{
            parameters["radius_filter"] = Double(distance)*1609.34 as AnyObject?
        }
        
        if let offset = searchString.offset{
            parameters["offset"] = offset as AnyObject
        }
        
        print(parameters)
        
        return self.get("search", parameters: parameters,
                        success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                            if let response = response as? [String: Any]{
//                                print(response)
                                if let dictionaries = response["businesses"] as? [NSDictionary]{
                                    completion(Business.businesses(array: dictionaries), nil)
                                }
                            }
        },
                        failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                            print(error.localizedDescription)
                            completion(nil, error)
        })!
    }
}
