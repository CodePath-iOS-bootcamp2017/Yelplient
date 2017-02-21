//
//  DetailsReviewsTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsReviewsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var business: Business?{
        didSet{
            if let reviews = business?.reviews{
                if reviews.count > 0{
                    print("has review comments")
                    let firstReview = reviews[0]
                    self.nameLabel.text = firstReview.username
                    
                    if let ratingImageUrl = firstReview.ratingImageURL{
                        self.ratingImageView.setImageWith(ratingImageUrl)
                    }
                    
                    if let profileImageUrl = firstReview.userImageURL{
                        self.profileImageView.setImageWith(profileImageUrl)
                    }
                    
                    self.commentLabel.text = firstReview.comment
                }else{
                    print("No review comments")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
