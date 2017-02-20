//
//  FilterFeatureTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/19/17.

import UIKit

class FilterFeatureTableViewCell: UITableViewCell {

    
    @IBOutlet weak var featureNameLabel: UILabel!
    @IBOutlet weak var featureCheckImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.featureCheckImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
