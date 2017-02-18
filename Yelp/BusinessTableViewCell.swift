//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/15/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var businessPosterImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business:Business!{
        didSet{
            self.nameLabel.text = business.name
            self.addressLabel.text = business.address
            self.distanceLabel.text = business.distance
            
            if let reviews = business.reviewCount{
                self.reviewsLabel.text = "\(reviews) Reviews"
            }
            
            self.categoryLabel.text = business.categories
            
            if let ratingUrl = business.ratingImageURL{
                self.ratingImageView.setImageWith(ratingUrl)
            }
            
            if let posterUrl = business.imageURL{
                self.businessPosterImageView.setImageWith(posterUrl)
                self.businessPosterImageView.layer.cornerRadius = 5.0
                self.businessPosterImageView.clipsToBounds = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        self.nameLabel.text = business.name
        self.addressLabel.text = business.address
        self.distanceLabel.text = business.distance
        self.reviewsLabel.text = "\(business.reviewCount) Reviews"
        self.categoryLabel.text = business.categories
        
        if let ratingUrl = business.ratingImageURL{
            self.ratingImageView.setImageWith(ratingUrl)
        }
        
        if let posterUrl = business.imageURL{
            self.businessPosterImageView.setImageWith(posterUrl)
        }
        */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
