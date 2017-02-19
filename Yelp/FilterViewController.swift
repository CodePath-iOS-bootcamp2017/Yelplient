//
//  FilterViewController.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/19/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dealsSwitch: UISwitch!
    @IBOutlet weak var featureTableView: UITableView!
    
    let features: [String] = ["Restaurants", "Food", "Nightlife", "Hotels & Travel", "Real Estate", "Health & Medical"]
    let sortOptions: [String] = ["Best matched", "Distance", "Highest Rated"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFeatureTableView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFeatureTableView(){
        self.featureTableView.delegate = self
        self.featureTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterFeatureTableViewCell", for: indexPath) as! FilterFeatureTableViewCell
        cell.featureNameLabel.text = self.features[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterFeatureTableViewCell
        if cell.featureCheckImageView.isHidden{
           cell.featureCheckImageView.isHidden = false
        }else{
           cell.featureCheckImageView.isHidden = true
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
