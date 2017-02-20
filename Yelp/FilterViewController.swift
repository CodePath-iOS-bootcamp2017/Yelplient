//
//  FilterViewController.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/19/17.


import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dealsSwitch: UISwitch!
    @IBOutlet weak var featureTableView: UITableView!
    @IBOutlet weak var sortOptionsSegmentedControl: UISegmentedControl!
    
//    let features: [String] = ["Restaurants", "Food", "Nightlife", "Hotels & Travel", "Real Estate", "Health & Medical", "Beaches", "Beauty & Spas", "Education"]
    let sortOptions: [String] = ["Best matched", "Distance", "Highest Rated"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFeatureTableView()
        self.setupFilterUIFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupFilterUIFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFilterUIFields(){
        if let distance = BusinessesViewController.searchFilter.distance{
            self.distanceSlider.value = Float(distance)
            self.distanceLabel.text = "\(Int(self.distanceSlider.value))mi"
        }
        
        if let deal = BusinessesViewController.searchFilter.deal{
            if deal{
                self.dealsSwitch.isOn = true
            }else{
                self.dealsSwitch.isOn = false
            }
        }
        
        if let sortMode = BusinessesViewController.searchFilter.sort{
            switch(sortMode.rawValue){
                case 1: self.sortOptionsSegmentedControl.selectedSegmentIndex = 1
                case 2: self.sortOptionsSegmentedControl.selectedSegmentIndex = 2
                default: self.sortOptionsSegmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    
    func setupFeatureTableView(){
        self.featureTableView.delegate = self
        self.featureTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusinessesViewController.searchFilter.generalFeatures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterFeatureTableViewCell", for: indexPath) as! FilterFeatureTableViewCell
        let feature = BusinessesViewController.searchFilter.generalFeatures[indexPath.row]
        cell.featureNameLabel.text = feature.name
        cell.featureCheckImageView.isHidden = !feature.isActivated!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterFeatureTableViewCell
        if cell.featureCheckImageView.isHidden{
           cell.featureCheckImageView.isHidden = false
           BusinessesViewController.searchFilter.generalFeatures[indexPath.row].isActivated = true
        }else{
           cell.featureCheckImageView.isHidden = true
           BusinessesViewController.searchFilter.generalFeatures[indexPath.row].isActivated = false
        }
    }
    
    @IBAction func onDistanceSliderValueChanged(_ sender: Any) {
        self.distanceLabel.text = "\(Int(self.distanceSlider.value)) mi"
        BusinessesViewController.searchFilter.distance = Int(self.distanceSlider.value)
    }
    
    @IBAction func onSortOptionChanged(_ sender: Any) {
        print(self.sortOptionsSegmentedControl.selectedSegmentIndex)
        switch(self.sortOptionsSegmentedControl.selectedSegmentIndex){
            case 1: BusinessesViewController.searchFilter.sort = YelpSortMode.distance
            case 2: BusinessesViewController.searchFilter.sort = YelpSortMode.highestRated
            default: BusinessesViewController.searchFilter.sort = YelpSortMode.bestMatched
        }
    }
    
    @IBAction func onDealSwitchValueChanged(_ sender: Any) {
//        print(self.dealsSwitch.isOn)
        if self.dealsSwitch.isOn{
            BusinessesViewController.searchFilter.deal = true
        }else{
            BusinessesViewController.searchFilter.deal = nil
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
