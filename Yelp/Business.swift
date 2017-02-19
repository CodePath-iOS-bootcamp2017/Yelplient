
import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        var businessimageURL:URL? = nil
        if let imageURLString = dictionary.value(forKey: "image_url") as? String {
            if let imageUrl = URL(string: imageURLString){
                businessimageURL = imageUrl
            }
        }
        self.imageURL = businessimageURL
        
        var address = ""
        if let location = dictionary.value(forKey: "location") as? NSDictionary{
            if let addressArray = location.value(forKey: "address") as? NSArray{
                if addressArray.count > 0 {
                    if let firstAddress = addressArray[0] as? String{
                        address = firstAddress
                    }
                }
            }
            
            if let neighborhoods = location.value(forKey: "neighborhoods") as? NSArray{
                if neighborhoods.count > 0 {
                    if !address.isEmpty {
                        address += ", "
                    }
                    if let firstNeighborhood = neighborhoods[0] as? String{
                        address += firstNeighborhood
                    }
                }
            }
        }
        self.address = address
        
        if let categoriesArray = dictionary.value(forKey: "categories") as? [[String]]{
            var categoryNames = [String]()
            for category in categoriesArray {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        if let distanceMeters = dictionary["distance"] as? NSNumber{
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters.doubleValue)
        } else {
            distance = nil
        }
        
        if let ratingImageURLString = dictionary["rating_img_url_large"] as? String{
            ratingImageURL = URL(string: ratingImageURLString)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    }
    
    class func search(completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(nil, sort: nil, categories: nil, deals: nil, completion: completion)
    }
}
