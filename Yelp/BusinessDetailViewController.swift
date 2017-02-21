//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var business: Business?
    
    @IBOutlet weak var detalisTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchBusinessDetails()
        self.setupDetailsTableView()
    }
    
    func fetchBusinessDetails(){
        if let businessId = self.business?.id{
            Business.getBusiness(businessId: businessId) { (business: Business?, error: Error?) in
                self.business = business
                self.detalisTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDetailsTableView(){
        self.detalisTableView.dataSource = self
        self.detalisTableView.delegate = self
        
        self.detalisTableView.estimatedRowHeight = 120
        self.detalisTableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if business == nil{
            return 0
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row){
            case 0:
                print("DetailsOverviewTableViewCell")
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsOverviewTableViewCell", for: indexPath) as! DetailsOverviewTableViewCell
                cell.business = self.business
                return cell
            
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsMapTableViewCell", for: indexPath) as! DetailsMapTableViewCell
                cell.business = self.business
                return cell
            
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsReviewsTableViewCell", for: indexPath) as! DetailsReviewsTableViewCell
                cell.business = self.business
                return cell
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
