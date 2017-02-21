//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetailViewController: UIViewController {

    var business: Business?
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchBusinessDetails()
        
    }
    
    func fetchBusinessDetails(){
        if let businessId = self.business?.id{
            Business.getBusiness(businessId: businessId) { (business: Business?, error: Error?) in
                self.business = business
                self.setupUI()
            }
        }
    }
    
    func setupUI(){
        if let name = business?.name{
            self.nameLabel.text = name
        }
        
        if let posterUrl = self.business?.imageURL{
            self.posterImageView.setImageWith(posterUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
