
import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    var latitude: Double?
    var longitude: Double?
    var id: String?
    var dealTitle: String?
    var phone: String?
    var reviews: [Review]
    
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
            
            self.latitude = nil
            self.longitude = nil
            if let businessCoordinate = location.value(forKey: "coordinate") as? NSDictionary{
                if let latitude = businessCoordinate.value(forKey: "latitude") as? Double{
                    self.latitude = latitude
                }
                
                if let longitude = businessCoordinate.value(forKey: "longitude") as? Double{
                    self.longitude = longitude
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
        
        id = dictionary.value(forKey: "id") as? String
        
        self.reviews = []
        if let reviews = dictionary.value(forKey: "reviews") as? [NSDictionary]{
            for review in reviews{
                self.reviews.append(Review(dictionary: review))
            }
        }
        
        if let phone = dictionary.value(forKey: "phone") as? String{
            self.phone = phone
        }
        
        if let deal = dictionary.value(forKey: "deals") as? [NSDictionary]{
            if let dealTitle = deal[0].value(forKey: "title") as? String{
                self.dealTitle = dealTitle
            }
        }
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    /*
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    }
    
    class func search(completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(nil, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    */
    class func searchWithFilter(searchString: SearchFilter, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchBusinesses(searchString, completion: completion)
    }
    
    class func getBusiness(businessId: String, completion: @escaping (Business?, Error?) -> Void) -> Void{
        _ = YelpClient.sharedInstance.getBusiness(businessId, completion: completion)
    }
}
