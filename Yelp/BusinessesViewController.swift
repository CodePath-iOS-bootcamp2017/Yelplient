//
//  BusinessesViewController.swift
//  Yelp
//

import UIKit
import MapKit
import SVProgressHUD
import CoreLocation

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    var businesses: [Business]!
    static var searchFilter: SearchFilter = SearchFilter()
    static var userCurrentLocation: CLLocationCoordinate2D?
    
    @IBOutlet weak var businessTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var searchBar:UISearchBar!
    var loadingMoreProgressIndicator: InfiniteScrollActivityView?
    let refreshControl = UIRefreshControl()
    let filterButton = UIButton()
    let switchViewButton = UIButton()
    var locationManager: CLLocationManager!
    var isLoadingMoreData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureProgressIndicator()
        self.initializeSearchFilter()
        self.configureSearchBar()
        self.configureRefreshControl()
        self.configureNavigationBar()
        self.configureLocationManager()
        self.congigureMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        BusinessesViewController.searchFilter.offset = nil
        self.loadDataFromNetwork()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureNavigationBar(){
        
        self.filterButton.frame = CGRect(x: 0, y: 0, width: 35, height: 25)
        self.filterButton.setImage(UIImage(named:"filter.png"), for: UIControlState.normal)
        self.filterButton.addTarget(self, action: #selector(onFilterBarButtonTapped(_:)), for: UIControlEvents.touchDown)
        let filterBarButton = UIBarButtonItem()
        filterBarButton.customView = self.filterButton
        self.navigationItem.leftBarButtonItem = filterBarButton
        
        self.switchViewButton.frame = CGRect(x: 0, y: 0, width: 35, height: 25)
        self.switchViewButton.setImage(UIImage(named:"map.png"), for: UIControlState.normal)
        self.switchViewButton.addTarget(self, action: #selector(switchView(_:)), for: UIControlEvents.touchDown)
        let switchViewBarButton = UIBarButtonItem()
        switchViewBarButton.customView = self.switchViewButton
        self.navigationItem.rightBarButtonItem = switchViewBarButton
        
//        self.loadNavigationBar()
    }
    
    func switchView(_ sender: Any){
        if self.businessTableView.isHidden{
            self.businessTableView.isHidden = false
            self.businessTableView.alpha = 1.0
            self.mapView.isHidden = true
            self.mapView.alpha = 0
            self.switchViewButton.setImage(UIImage(named:"map.png"), for: UIControlState.normal)
        }else{
            self.businessTableView.isHidden = true
            self.businessTableView.alpha = 0
            self.mapView.isHidden = false
            self.mapView.alpha = 1.0
            self.plotMapAnnotations()
            self.switchViewButton.setImage(UIImage(named:"list.png"), for: UIControlState.normal)
        }
    }
    
    func onFilterBarButtonTapped(_ sender: Any){
        performSegue(withIdentifier: "filterShowSegue", sender: sender)
    }
    
    func configureRefreshControl(){
        self.refreshControl.addTarget(self, action: #selector(refreshContent(_:)), for: UIControlEvents.valueChanged)
        self.refreshControl.tintColor = UIColor.red
        self.businessTableView.insertSubview(refreshControl, at: 0)
    }
    
    // called on refresh event
    func refreshContent(_ refreshControl: UIRefreshControl){
        self.loadDataFromNetwork()
        refreshControl.endRefreshing()
    }
    
    func configureTableView(){
        self.businessTableView.delegate = self
        self.businessTableView.dataSource = self
        self.businessTableView.rowHeight = UITableViewAutomaticDimension
        self.businessTableView.estimatedRowHeight = 120
        self.businessTableView.isHidden = false
        self.businessTableView.alpha = 1.0
    }
    
    func congigureMapView(){
        self.mapView.isHidden = true
        self.mapView.alpha = 0.0
    }
    
    func goToLocation(location: CLLocation){
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        self.mapView.setRegion(region, animated: false)
    }
    
    func configureProgressIndicator(){
        let progressIndicatorFrameTableView = CGRect(x: 0, y: self.businessTableView.contentSize.height, width: self.businessTableView.bounds.width, height: InfiniteScrollActivityView.defaultHeight)
        self.loadingMoreProgressIndicator = InfiniteScrollActivityView(frame: progressIndicatorFrameTableView)
        loadingMoreProgressIndicator?.isHidden = true
        
        self.businessTableView.addSubview(loadingMoreProgressIndicator!)
        
        var insetTableView = self.businessTableView.contentInset
        insetTableView.bottom += (loadingMoreProgressIndicator?.bounds.height)!
        self.businessTableView.contentInset = insetTableView
    }
    
    func initializeSearchFilter(){
//        print("initializeSearchFilter")
        BusinessesViewController.searchFilter.term = nil
        BusinessesViewController.searchFilter.categories = nil
        BusinessesViewController.searchFilter.distance = 15
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
    
    func loadDataFromNetwork(){
        self.evaluateFilterCriteria()
        self.performSearchWithFilter()
    }
    
    func performSearchWithFilter(){
        SVProgressHUD.show()
        SVProgressHUD.setForegroundColor(UIColor.red)
        
        self.evaluateFilterCriteria()
        Business.searchWithFilter(searchString: BusinessesViewController.searchFilter) { (businesses:[Business]?, error: Error?) in
            if let businesses = businesses{
                self.businesses = businesses
                self.businessTableView.reloadData()
                self.plotMapAnnotations()
            }
            SVProgressHUD.dismiss()
        }
        
    }
    
    func loadMoreData(){
        if let businesses = self.businesses{
            BusinessesViewController.searchFilter.offset = businesses.count
            self.evaluateFilterCriteria()
            
            Business.searchWithFilter(searchString: BusinessesViewController.searchFilter) { (businesses:[Business]?, error: Error?) in
                if let businesses = businesses{
                    self.businesses.append(contentsOf: businesses)
                    self.businessTableView.reloadData()
                }
                self.isLoadingMoreData = false
                self.loadingMoreProgressIndicator?.stopAnimating()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(!isLoadingMoreData){
            let totalHeight = self.businessTableView.contentSize.height
            let offsetHeight = self.businessTableView.bounds.height
            let threshold = totalHeight - offsetHeight
            
            if scrollView.contentOffset.y>threshold && scrollView.isDragging{
                
                self.isLoadingMoreData = true
                
                let frame = CGRect(x: 0, y: self.businessTableView.contentSize.height, width: self.businessTableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                self.loadingMoreProgressIndicator?.frame = frame
                self.loadingMoreProgressIndicator!.startAnimating()
                
                loadMoreData()
            }
        }
        
    }
    
    
    func plotMapAnnotations(){
        self.mapView.removeAnnotations(self.mapView.annotations)
        for business in self.businesses{
            let businessCoordinate = CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = businessCoordinate
            annotation.title = business.name
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            print("got location authorization")
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("user location updated")
        if let userLocation = locations.first{
            print("user location: \(userLocation)")
            BusinessesViewController.userCurrentLocation = userLocation.coordinate
            self.loadDataFromNetwork()
            self.goToLocation(location: userLocation)
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue")
        if segue.identifier == "businessDetailsSegue"{
            if let cell = sender as? BusinessTableViewCell{
                if let cellIndex = self.businessTableView.indexPath(for: cell){
                    if let detailsViewController = segue.destination as? BusinessDetailViewController{
                        detailsViewController.business = self.businesses[cellIndex.row]
                    }
                }
            }
        }
    }
}

extension BusinessesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        BusinessesViewController.searchFilter.offset = nil
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
        self.loadDataFromNetwork()
    }
}
