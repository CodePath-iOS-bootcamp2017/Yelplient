//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var businesses: [Business]!
    static var searchFilter: SearchFilter = SearchFilter()
    
    @IBOutlet weak var businessTableView: UITableView!
    
    var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.businessTableView.delegate = self
        self.businessTableView.dataSource = self
        self.businessTableView.rowHeight = UITableViewAutomaticDimension
        self.businessTableView.estimatedRowHeight = 120
        
        self.initializeSearchFilter()
        self.configureSearchBar()
        self.performInitialSearch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeSearchFilter(){
        print("initializeSearchFilter")
        BusinessesViewController.searchFilter.term = nil
        BusinessesViewController.searchFilter.categories = nil
        BusinessesViewController.searchFilter.distance = nil
        BusinessesViewController.searchFilter.deal = nil
        BusinessesViewController.searchFilter.offset = nil
        BusinessesViewController.searchFilter.sort = nil
        
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Restaurants", featureCode: "restaurants", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Food", featureCode: "food", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Nightlife", featureCode: "nightlife", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Hotels & Travel", featureCode: "hotelstravel", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Real Estate", featureCode: "realestate", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Health & Medical", featureCode: "health", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Beaches", featureCode: "beaches", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Beauty & Spas", featureCode: "beautysvc", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Education", featureCode: "education", isFeatureActivated: false))
        BusinessesViewController.searchFilter.generalFeatures.append(Feature(featureName: "Fashion", featureCode: "fashion", isFeatureActivated: false))
    }
    
    func evaluateFilterCriteria(){
        BusinessesViewController.searchFilter.term = nil
        if let searchText = self.searchBar.text{
            if(!searchText.isEmpty){
                BusinessesViewController.searchFilter.term = searchText
            }
        }
        
        BusinessesViewController.searchFilter.categories = []
        for feature in BusinessesViewController.searchFilter.generalFeatures{
            if feature.isActivated!{
                BusinessesViewController.searchFilter.categories?.append(feature.code!)
            }
        }
        if (BusinessesViewController.searchFilter.categories?.isEmpty)!{
            BusinessesViewController.searchFilter.categories = nil
        }
    }
    
    func configureSearchBar(){
        self.searchBar = UISearchBar()
        self.searchBar.sizeToFit()
        navigationItem.titleView = self.searchBar
        self.searchBar.delegate = self
    }
    
    func performInitialSearch(){
        /*
         Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
         
         self.businesses = businesses
         
         if let businesses = businesses {
         self.businessTableView.reloadData()
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         
         }
         )
         
         //Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
        Business.search { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.businessTableView.reloadData()
            }
        }
    }
    
    func performSearchWithFilter(){
        /*
        if let searchText = self.searchBar.text{
            BusinessesViewController.searchFilter.term = searchText
        }else{
            BusinessesViewController.searchFilter.term = ""
        }
//        print(BusinessesViewController.searchFilter.term)
        Business.searchWithTerm(term: (BusinessesViewController.searchFilter.term)!, sort: nil, categories: nil, deals: nil) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses{
                self.businesses = businesses
                self.businessTableView.reloadData()
            }
        }
        */
        self.evaluateFilterCriteria()
        Business.searchWithFilter(searchString: BusinessesViewController.searchFilter) { (businesses:[Business]?, error: Error?) in
            if let businesses = businesses{
                self.businesses = businesses
                self.businessTableView.reloadData()
            }
        }
        
    }
    
    //overriding tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.businesses != nil  {
            return self.businesses.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
        
        cell.business = self.businesses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BusinessesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.performSearchWithFilter()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
        self.performInitialSearch()
    }
}
