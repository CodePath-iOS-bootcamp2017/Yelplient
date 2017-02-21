//
//  DetailsOverviewTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsOverviewTableViewCell: UITableViewCell {

    var business: Business?
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupUI(){
        if let name = business?.name{
            self.nameLabel.text = name
        }
        
        if let posterUrl = self.business?.imageURL{
            self.posterImageView.setImageWith(posterUrl)
        }
    }
    
}
