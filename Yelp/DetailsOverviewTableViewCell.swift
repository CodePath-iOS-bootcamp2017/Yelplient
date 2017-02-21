//
//  DetailsOverviewTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsOverviewTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var dealImageView: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var dealLabel: UILabel!
    
    var business: Business?{
        didSet{
            if let name = business?.name{
                self.nameLabel.text = name
            }
            
            if let posterUrl = self.business?.imageURL{
                self.posterImageView.setImageWith(posterUrl)
            }
            
            if let distance = self.business?.distance{
                self.distanceLabel.text = distance
            }
            
            if let categories = self.business?.categories{
                self.categoriesLabel.text = categories
            }
            
            if let reviewsCount = business?.reviewCount{
                self.reviewsLabel.text = "\(reviewsCount) Reviews"
            }
            
            if let ratingImageUrl = business?.ratingImageURL{
                self.ratingsImageView.setImageWith(ratingImageUrl)
            }
            
            if let dealText = business?.dealTitle{
                self.dealLabel.text = dealText
                self.dealLabel.isHidden = false
                self.dealImageView.isHidden = false
            }else{
                self.dealLabel.isHidden = true
                self.dealImageView.isHidden = true
            }
            
            if let phone = business?.phone{
                self.phoneLabel.text = phone
                self.phoneLabel.isHidden = false
                self.phoneImageView.isHidden = false
            }else{
                self.phoneLabel.isHidden = true
                self.phoneImageView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
